import 'dart:async';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../utils/logger.dart';
import 'storage_service.dart';

const _tag = 'ApiClient';

class ApiClient {
  late final Dio _dio;
  final StorageService _storage;
  bool _isRefreshing = false;
  bool _sessionExpired = false;
  Completer<String?>? _refreshCompleter;

  bool get sessionExpired => _sessionExpired;

  void Function()? onSessionExpired;

  ApiClient(this._storage) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConfig.connectTimeout),
      receiveTimeout: Duration(milliseconds: ApiConfig.receiveTimeout),
      headers: {'Content-Type': 'application/json'},
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    ));
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header for auth endpoints
    if (!options.path.contains('/auth/')) {
      final token = await _storage.getAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    final query = options.queryParameters.isNotEmpty
        ? '?${options.queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&')}'
        : '';
    AppLogger.info(_tag, '\u2192 ${options.method} ${options.path}$query');
    handler.next(options);
  }

  void _onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final ms = response.requestOptions.extra['_startTime'] != null
        ? ' (${DateTime.now().millisecondsSinceEpoch - (response.requestOptions.extra['_startTime'] as int)}ms)'
        : '';
    AppLogger.info(_tag, '\u2190 ${response.statusCode} ${response.requestOptions.path}$ms');
    handler.next(response);
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final path = err.requestOptions.path;
    final status = err.response?.statusCode;
    final msg = err.response?.data is Map ? err.response?.data['message'] ?? err.response?.data['error'] : err.message;
    AppLogger.error(_tag, '\u2717 $status $path: $msg');

    if (err.response?.statusCode == 401) {
      // If a refresh is already in progress, wait for it then retry
      if (_isRefreshing) {
        AppLogger.debug(_tag, 'Token refresh in progress, queuing $path');
        final newToken = await _refreshCompleter?.future;
        if (newToken != null) {
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newToken';
          final retryResponse = await _dio.fetch(opts);
          return handler.resolve(retryResponse);
        }
        return handler.next(err);
      }

      _isRefreshing = true;
      _refreshCompleter = Completer<String?>();
      AppLogger.info(_tag, 'Token refresh: attempting');

      try {
        final refreshToken = await _storage.getRefreshToken();
        if (refreshToken == null) {
          AppLogger.warning(_tag, 'Token refresh: no refresh token');
          _refreshCompleter!.complete(null);
          _handleSessionExpired();
          return handler.next(err);
        }

        final response = await Dio(BaseOptions(
          baseUrl: ApiConfig.baseUrl,
        )).post('/auth/refresh', data: {
          'refresh_token': refreshToken,
        });

        if (response.statusCode == 200 && response.data['success'] == true) {
          final data = response.data['data'];
          final newAccessToken = data['access_token'] as String;
          await _storage.saveTokens(newAccessToken, data['refresh_token']);
          AppLogger.info(_tag, 'Token refresh: success');

          // Unblock queued requests
          _refreshCompleter!.complete(newAccessToken);

          // Retry original request
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newAccessToken';
          final retryResponse = await _dio.fetch(opts);
          return handler.resolve(retryResponse);
        } else {
          AppLogger.warning(_tag, 'Token refresh: failed, session expired');
          _refreshCompleter!.complete(null);
          _handleSessionExpired();
        }
      } catch (e) {
        AppLogger.error(_tag, 'Token refresh: error', e);
        _refreshCompleter!.complete(null);
        _handleSessionExpired();
      } finally {
        _isRefreshing = false;
        _refreshCompleter = null;
      }
    }
    handler.next(err);
  }

  void _handleSessionExpired() {
    AppLogger.warning(_tag, 'Session expired, clearing storage');
    _sessionExpired = true;
    _storage.clearAll();
    onSessionExpired?.call();
  }

  // HTTP methods
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(
    String path, {
    dynamic data,
  }) {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) {
    return _dio.delete(path);
  }
}

/// Parse Dio errors into user-friendly messages
String parseError(dynamic error) {
  if (error is DioException) {
    if (error.response?.data is Map) {
      final message = error.response?.data['message'] ??
          error.response?.data['error'];
      if (message != null) return message.toString();
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'Unable to connect to server. Please check your connection.';
      default:
        if (error.response?.statusCode == 401) {
          return 'Invalid credentials. Please try again.';
        }
        if (error.response?.statusCode == 404) {
          return 'Not found.';
        }
        if (error.response?.statusCode == 409) {
          return 'This email is already registered.';
        }
        return 'Something went wrong. Please try again.';
    }
  }
  return error.toString();
}
