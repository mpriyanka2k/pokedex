// api_response.dart
abstract class ApiResponse<T> {}

class ApiSuccess<T> extends ApiResponse<T> {
  final T data;
  final int statusCode;
  ApiSuccess(this.data, {required this.statusCode});
}

class ApiError<T> extends ApiResponse<T> {
  final String message;
  final int? statusCode;
  ApiError(this.message, {this.statusCode});
}
