import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/auth_response.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../services/api_client.dart';
import '../utils/logger.dart';

const _tag = 'Auth';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final StorageService _storage;
  final ApiClient _apiClient;

  User? _currentUser;
  bool _isLoading = true;
  String? _error;

  AuthProvider(this._authService, this._storage, this._apiClient) {
    _apiClient.onSessionExpired = _onSessionExpired;
  }

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _onSessionExpired() {
    AppLogger.warning(_tag, 'Session expired callback fired');
    _currentUser = null;
    _error = 'Session expired. Please log in again.';
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    AppLogger.info(_tag, 'tryAutoLogin: starting');
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _storage.getAccessToken();
      if (token == null) {
        AppLogger.info(_tag, 'tryAutoLogin: no token found');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final userData = _storage.getUserJson();
      if (userData != null) {
        _currentUser = User.fromJson(userData);
        AppLogger.info(_tag, 'tryAutoLogin: user loaded from storage');
      } else {
        AppLogger.info(_tag, 'tryAutoLogin: token found but no user data');
      }
    } catch (e) {
      AppLogger.error(_tag, 'tryAutoLogin: error', e);
    }

    AppLogger.info(_tag, 'tryAutoLogin: authenticated=${_currentUser != null}');
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    AppLogger.info(_tag, 'login: attempting for $email');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final AuthResponse auth = await _authService.login(email, password);
      await _storage.saveTokens(auth.accessToken, auth.refreshToken);
      await _storage.saveUserJson(auth.user.toJson());
      _currentUser = auth.user;
      _isLoading = false;
      AppLogger.info(_tag, 'login: success');
      notifyListeners();
      return true;
    } catch (e) {
      _error = parseError(e);
      _isLoading = false;
      AppLogger.error(_tag, 'login: failed - $_error', e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    AppLogger.info(_tag, 'register: attempting for $email');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final AuthResponse auth = await _authService.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      await _storage.saveTokens(auth.accessToken, auth.refreshToken);
      await _storage.saveUserJson(auth.user.toJson());
      _currentUser = auth.user;
      _isLoading = false;
      AppLogger.info(_tag, 'register: success');
      notifyListeners();
      return true;
    } catch (e) {
      _error = parseError(e);
      _isLoading = false;
      AppLogger.error(_tag, 'register: failed - $_error', e);
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    AppLogger.info(_tag, 'logout');
    await _storage.clearAll();
    _currentUser = null;
    _error = null;
    notifyListeners();
  }

  Future<bool> forgotPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.forgotPassword(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = parseError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyResetCode(String email, String code) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.verifyResetCode(email, code);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = parseError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(String email, String code, String newPassword) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.resetPassword(email, code, newPassword);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = parseError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
