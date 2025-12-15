import 'package:dio/dio.dart';
import 'package:pokedex/core/network/network_constants.dart';
import 'package:pokedex/core/flutter_secure_storage/flutter_secure_storage.dart';

class TokenRefreshService {
  TokenRefreshService(this._dio, this._flutterSecureStorages, {this.refreshEndpoint = defaultRefreshPath});

  final Dio _dio;
  final FlutterSecureStorages _flutterSecureStorages;
  final String refreshEndpoint;

  Future<String?> refresh() async {
    final refreshToken = await _flutterSecureStorages.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    final response = await _dio.post(
      refreshEndpoint,
      data: {'refreshToken': refreshToken},
      options: Options(
        extra: const {skipTokenRefreshKey: true},
        contentType: Headers.jsonContentType,
      ),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      return null;
    }

    final newAccessToken = data['accessToken'] as String?;
    final newRefreshToken = (data['refreshToken'] as String?) ?? refreshToken;

    if (newAccessToken == null || newAccessToken.isEmpty) {
      return null;
    }

    await _flutterSecureStorages.saveTokens(
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
    );
    return newAccessToken;
  }
}

