import 'package:dio/dio.dart';
import 'package:pokedex/core/flutter_secure_storage/flutter_secure_storage.dart';


class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._flutterSecureStorages);

  final FlutterSecureStorages _flutterSecureStorages;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _flutterSecureStorages.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
