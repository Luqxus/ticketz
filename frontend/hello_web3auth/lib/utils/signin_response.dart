class SignInResponse {
  final String token;
  final String email;

  SignInResponse(this.email, this.token);

  String get getToken => token;
  String get getEmail => email;
}
