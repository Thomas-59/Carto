class BadCredentialException implements Exception {
  final String message;

  BadCredentialException({
    this.message = "The credential you use is false or damaged."
  });

  @override
  String toString() {
    return "BadCredentialException: $message";
  }
}
