import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    super.onRequest(options, handler);
  }
}
