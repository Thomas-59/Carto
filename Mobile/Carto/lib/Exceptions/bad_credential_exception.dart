/// A exception given when a credential error arise
class BadCredentialException implements Exception {
  /// The context of the error
  final String message;

  /// The initializer of the exception
  BadCredentialException({
    this.message = "The credential you use is false or damaged."
  });

  /// Describe the error
  @override
  String toString() {
    return "BadCredentialException: $message";
  }
}
