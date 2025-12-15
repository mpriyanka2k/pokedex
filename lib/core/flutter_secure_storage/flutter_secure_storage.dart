import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorages {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _isLogedIn = 'is_loged_in';
  static const _userEmail = 'user_email';
  static const _userPassword = 'user_password';
  static const _appLocal = 'app_local';

   void Function(bool)? onLoginStateChanged;

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Save tokens 
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  /// Clear tokens
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
  
  Future<bool> getIsLogedIn() async {
    String? value = await _secureStorage.read(key: _isLogedIn);
    return value == 'true';
  }

  Future<void> setIsLogedIn(bool isLoggedIn) async {
    await _secureStorage.write(key: _isLogedIn, value: isLoggedIn.toString());
     // Notify listeners
    onLoginStateChanged?.call(isLoggedIn);
  }

  Future<void> saveUserEmailAndPassword(String email, String password) async {
    await _secureStorage.write(key: _userEmail, value: email);
    await _secureStorage.write(key: _userPassword, value: password);
  
  }

  Future<String?> getUserEmail() async {
    return await _secureStorage.read(key: _userEmail);
  }
  Future<String?> getUserPassword() async {
    return await _secureStorage.read(key: _userPassword);
  }

  Future<void> saveLocale(String type) async {
    await _secureStorage.write(key: _appLocal, value: type);
  }

  Future<String?> getLocale() async {
    return await _secureStorage.read(key: _appLocal);

  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
  
}
