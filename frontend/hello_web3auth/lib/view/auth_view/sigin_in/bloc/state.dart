import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInFailure extends SignInState {
  final String message;

  SignInFailure(this.message);

  @override
  List<Object?> get props => [message];
}
