class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Object? details;

  ApiException(this.message, {this.statusCode, this.details});

  @override
  String toString() {
    final String statusCodePart =
        statusCode == null ? '' : ', statusCode: $statusCode';
    return 'ApiException(message: $message$statusCodePart, details: $details)';
  }
}
