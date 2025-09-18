import 'api_error.dart';

class ApiResult<T> {
  final T? data;
  final ApiError? error;

  bool get isSuccess => data != null && error == null;

  ApiResult.success(this.data) : error = null;
  ApiResult.failure(this.error) : data = null;
}
