class InternetConnectionException implements Exception {
  String message;

  InternetConnectionException({
    required this.message,
  });

  @override
  String toString() {
    return 'reason $message';
  }
}
