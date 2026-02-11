import '../models/auth_response.dart';
import '../utils/logger.dart';
import 'api_client.dart';

const _tag = 'AuthService';

class AuthService {
  final ApiClient _client;

  AuthService(this._client);

  Future<AuthResponse> login(String email, String password) async {
    AppLogger.info(_tag, 'login: $email');
    final response = await _client.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    AppLogger.info(_tag, 'login: success');
    return AuthResponse.fromJson(response.data['data']);
  }

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    AppLogger.info(_tag, 'register: $email');
    final response = await _client.post('/auth/register', data: {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      if (phone != null) 'phone': phone,
    });
    AppLogger.info(_tag, 'register: success');
    return AuthResponse.fromJson(response.data['data']);
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    AppLogger.info(_tag, 'refreshToken');
    final response = await _client.post('/auth/refresh', data: {
      'refresh_token': refreshToken,
    });
    AppLogger.info(_tag, 'refreshToken: success');
    return AuthResponse.fromJson(response.data['data']);
  }

  Future<void> forgotPassword(String email) async {
    AppLogger.info(_tag, 'forgotPassword: $email');
    await _client.post('/auth/forgot-password', data: {
      'email': email,
    });
    AppLogger.info(_tag, 'forgotPassword: success');
  }

  Future<void> verifyResetCode(String email, String code) async {
    AppLogger.info(_tag, 'verifyResetCode: $email');
    await _client.post('/auth/verify-reset-code', data: {
      'email': email,
      'code': code,
    });
    AppLogger.info(_tag, 'verifyResetCode: success');
  }

  Future<void> resetPassword(String email, String code, String newPassword) async {
    AppLogger.info(_tag, 'resetPassword: $email');
    await _client.post('/auth/reset-password', data: {
      'email': email,
      'code': code,
      'new_password': newPassword,
    });
    AppLogger.info(_tag, 'resetPassword: success');
  }
}
