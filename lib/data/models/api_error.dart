class ApiError {
  final String message;
  final String? code;
  final int? statusCode;

  ApiError({required this.message, this.code, this.statusCode});

  factory ApiError.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    // NewsAPI error shapes often like:
    // { "status": "error", "code": "apiKeyInvalid", "message": "Your API key is invalid" }
    final msg = (json['message'] ?? json['error'] ?? json['messageText'] ?? '')
        .toString();
    final c = (json['code'] ?? json['errorCode'])?.toString();
    return ApiError(
      message: msg.isEmpty ? 'Unknown error' : msg,
      code: c,
      statusCode: statusCode,
    );
  }

  static ApiError unknown([String? message]) =>
      ApiError(message: message ?? 'Something went wrong');

  Map<String, dynamic> toJson() => {
    'message': message,
    'code': code,
    'statusCode': statusCode,
  };
}
