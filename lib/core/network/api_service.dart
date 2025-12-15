import 'package:dio/dio.dart';
import 'package:pokedex/core/flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokedex/core/network/interceptors/auth_interceptor.dart';
import 'package:pokedex/core/network/interceptors/header_interceptor.dart';
import 'package:pokedex/core/network/interceptors/log_interceptor.dart';
import 'package:pokedex/core/network/interceptors/refresh_token_interceptor.dart';
import 'package:pokedex/core/network/token_refresh_service.dart';
import '../../core/network/network_info.dart';
import 'api_response.dart';

enum HttpMethod { get, post, put, delete }

class ApiService {
  final Dio _dio;
  final NetworkInfo networkInfo;
  final FlutterSecureStorages flutterSecureStorages;
  final TokenRefreshService tokenRefreshService;

  ApiService(
    this._dio,
    this.networkInfo,
    this.flutterSecureStorages,
    this.tokenRefreshService,
  ) {
    _dio.interceptors.add(AppLogInterceptor());
    _dio.interceptors.add(HeaderInterceptor());
    _dio.interceptors.add(AuthInterceptor(flutterSecureStorages));
    _dio.interceptors.add(RefreshTokenInterceptor(_dio, tokenRefreshService, flutterSecureStorages));
  }

  Future<ApiResponse<dynamic>> request(
    String endpoint, {
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? queryParams,
    dynamic data,
  }) async {

    // 1 Check internet before API call
    if (!await networkInfo.isConnected) {
      return ApiError('No Internet');
    }

    try {
      late Response response;

      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(endpoint, queryParameters: queryParams);
          break;
        case HttpMethod.post:
          response = await _dio.post(endpoint,
              data: data, queryParameters: queryParams);
          break;
        case HttpMethod.put:
          response = await _dio.put(endpoint,
              data: data, queryParameters: queryParams);
          break;
        case HttpMethod.delete:
          response = await _dio.delete(endpoint,
              data: data, queryParameters: queryParams);
          break;
      }

      // Handle response status codes:
      if (response.statusCode == 200) {
        return ApiSuccess(response.data, statusCode: response.statusCode!);
      } else if (response.statusCode == 400) {
        return ApiError('Bad request', statusCode: response.statusCode!);
      } else if (response.statusCode == 401) {
        return ApiError('Unauthorized', statusCode: response.statusCode!);
      } else if (response.statusCode == 403) {
        return ApiError('Forbidden', statusCode: response.statusCode!);
      } else if (response.statusCode == 404) {
        return ApiError('Not found', statusCode: response.statusCode!);
      } else if (response.statusCode! >= 500) {
        return ApiError('Server error', statusCode: response.statusCode!);
      } else {
        return ApiError('Unexpected error', statusCode: response.statusCode!);
      }

    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return ApiError('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return ApiError('Receive timeout');
      } else if (e.type == DioExceptionType.badResponse) {
        return ApiError(
          e.response?.data.toString() ?? 'Unknown error',
          statusCode: e.response?.statusCode,
        );
      } else {
        return ApiError(e.message.toString());
      }
    } catch (e) {
      return ApiError(e.toString());
    }
  }

}

