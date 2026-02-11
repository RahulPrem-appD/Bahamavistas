import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/logger.dart';

const _tag = 'Storage';

class StorageService {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userDataKey = 'user_data';
  static const _onboardingCompleteKey = 'onboarding_complete';

  final FlutterSecureStorage _secureStorage;
  late SharedPreferences _prefs;

  StorageService() : _secureStorage = const FlutterSecureStorage();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    AppLogger.info(_tag, 'Initialized SharedPreferences');
  }

  // Token management
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    AppLogger.debug(_tag, 'Tokens saved');
  }

  Future<String?> getAccessToken() async {
    final token = await _secureStorage.read(key: _accessTokenKey);
    AppLogger.debug(_tag, 'getAccessToken: ${token != null ? 'found' : 'null'}');
    return token;
  }

  Future<String?> getRefreshToken() async {
    return _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  // User data
  Future<void> saveUserJson(Map<String, dynamic> userData) async {
    await _prefs.setString(_userDataKey, jsonEncode(userData));
    AppLogger.debug(_tag, 'User data saved');
  }

  Map<String, dynamic>? getUserJson() {
    final data = _prefs.getString(_userDataKey);
    AppLogger.debug(_tag, 'getUserJson: ${data != null ? 'found' : 'null'}');
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  Future<void> clearUserData() async {
    await _prefs.remove(_userDataKey);
  }

  // Onboarding
  bool get onboardingComplete => _prefs.getBool(_onboardingCompleteKey) ?? false;

  Future<void> setOnboardingComplete(bool value) async {
    await _prefs.setBool(_onboardingCompleteKey, value);
  }

  // Clear all
  Future<void> clearAll() async {
    AppLogger.info(_tag, 'Clearing all stored data');
    await clearTokens();
    await clearUserData();
  }
}
