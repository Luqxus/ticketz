import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStartedEvent extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String email;
  final String token;
  LoggedIn(this.email, this.token);

  @override
  List<Object?> get props => [email, token];
}

class LoggedOut extends AuthEvent {}
