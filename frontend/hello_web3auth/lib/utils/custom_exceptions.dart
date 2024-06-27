class UnKnownException implements Exception {
  final String message;

  UnKnownException(this.message);
}

class SignUpException implements Exception {
  final String message;

  SignUpException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}
