import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("➡️ REQUEST: ${options.method} ${options.uri}");
    debugPrint("Headers: ${options.headers}");
    debugPrint("Query: ${options.queryParameters}");
    debugPrint("Data: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("⬅️ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}");
    debugPrint("Data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("❌ ERROR: ${err.message}");
    if (err.response != null) {
      debugPrint("Response Data: ${err.response?.data}");
    }
    super.onError(err, handler);
  }
}
