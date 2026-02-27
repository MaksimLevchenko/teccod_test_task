import 'dart:convert';

class ErrorParser {
  const ErrorParser();

  String parse(
    String body, {
    String fallbackMessage = 'Произошла ошибка при выполнении запроса.',
  }) {
    final String trimmedBody = body.trim();
    if (trimmedBody.isEmpty) {
      return fallbackMessage;
    }

    try {
      final dynamic decoded = jsonDecode(trimmedBody);
      if (decoded is Map) {
        final dynamic messageValue = decoded['message'];
        if (messageValue is String && messageValue.trim().isNotEmpty) {
          return messageValue;
        }
        final dynamic errorValue = decoded['error'];
        if (errorValue is String && errorValue.trim().isNotEmpty) {
          return errorValue;
        }
      }
    } catch (_) {
      return trimmedBody;
    }

    return trimmedBody;
  }
}
