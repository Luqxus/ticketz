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

class CreateEventException implements Exception {
  final String message;

  CreateEventException(this.message);
}

class FetchEventException implements Exception {
  final String message;

  FetchEventException(this.message);
}

class BuyTicketException implements Exception {
  final String message;

  BuyTicketException(this.message);
}

class GetTicketException implements Exception {
  final String message;

  GetTicketException(this.message);
}
