class ProblemDetails {
  final String? type;
  final String? title;
  final int? status;
  final String? detail;
  final String? instance;

  ProblemDetails({
    this.type,
    this.title,
    this.status,
    this.detail,
    this.instance,
  });

  factory ProblemDetails.fromJson(Map<String, dynamic> json) {
    return ProblemDetails(
      type: json['type'] as String?,
      title: json['title'] as String?,
      status: json['status'] as int?,
      detail: json['detail'] as String?,
      instance: json['instance'] as String?,
    );
  }
}

class ApiException implements Exception {
  final int statusCode;
  final ProblemDetails? problemDetails;
  final String message;

  ApiException(this.message, {required this.statusCode, this.problemDetails});

  @override
  String toString() {
    if (problemDetails != null && problemDetails!.detail != null) {
      return 'ApiException [$statusCode]: ${problemDetails!.title} - ${problemDetails!.detail}';
    }
    return 'ApiException [$statusCode]: $message';
  }
}

class BadRequestException extends ApiException {
  BadRequestException(super.message, {super.problemDetails})
    : super(statusCode: 400);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message, {super.problemDetails})
    : super(statusCode: 401);
}

class ForbiddenException extends ApiException {
  ForbiddenException(super.message, {super.problemDetails})
    : super(statusCode: 403);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message, {super.problemDetails})
    : super(statusCode: 404);
}

class ServerException extends ApiException {
  ServerException(super.message, {super.problemDetails})
    : super(statusCode: 500);
}
