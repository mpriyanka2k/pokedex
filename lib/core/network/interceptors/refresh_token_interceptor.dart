import 'package:dio/dio.dart';
import 'package:pokedex/core/flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokedex/core/network/network_constants.dart';
import 'package:pokedex/core/network/token_refresh_service.dart';

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor(
    this._dio,
    this._tokenRefreshService,
    this._flutterSecureStorages,
  );

  final Dio _dio;
  final TokenRefreshService _tokenRefreshService;
  final FlutterSecureStorages _flutterSecureStorages;

  Future<String?>? _refreshFuture;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!_shouldAttemptRefresh(err)) {
      handler.next(err);
      return;
    }

    try {
      final token = await _getOrCreateRefreshFuture();
      if (token == null || token.isEmpty) {
        handler.next(err);
        return;
      }

      final requestOptions = _updatedRequest(err.requestOptions, token);
      final response = await _dio.fetch(requestOptions);
      handler.resolve(response);
    } catch (_) {
      await _flutterSecureStorages.clearTokens();
      handler.next(err);
    }
  }

  bool _shouldAttemptRefresh(DioException err) {
    if (err.response?.statusCode != 401) {
      return false;
    }
    final extras = err.requestOptions.extra;
    if (extras[skipTokenRefreshKey] == true) {
      return false;
    }
    if (extras[retriedAfterRefreshKey] == true) {
      return false;
    }
    return true;
  }

  Future<String?> _getOrCreateRefreshFuture() {
    _refreshFuture ??= _tokenRefreshService.refresh().whenComplete(() {
      _refreshFuture = null;
    });
    return _refreshFuture!;
  }

  RequestOptions _updatedRequest(RequestOptions original, String token) {
    final headers = Map<String, dynamic>.from(original.headers);
    headers['Authorization'] = 'Bearer $token';

    final extra = Map<String, dynamic>.from(original.extra);
    extra[retriedAfterRefreshKey] = true;

    return original.copyWith(
      headers: headers,
      extra: extra,
    );
  }
}

