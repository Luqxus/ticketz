import 'package:equatable/equatable.dart';

class AuthProcessEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInButtonPressed extends AuthProcessEvent {
  final String email;
  final String password;

  SignInButtonPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpButtonPressed extends AuthProcessEvent {
  final String email;
  final String username;
  final String password;

  SignUpButtonPressed(
      {required this.email, required this.password, required this.username});

  @override
  List<Object?> get props => [email, username, password];
}

class ToggleSignUpView extends AuthProcessEvent {}

class ToggleSignInView extends AuthProcessEvent {}
