class ResponseStatusCodeException implements Exception {
  final String message;
  final int? statusCode;

  ResponseStatusCodeException({required this.message, this.statusCode});

  @override
  String toString() {
    return 'reason: $message, status code: $statusCode';
  }
}
