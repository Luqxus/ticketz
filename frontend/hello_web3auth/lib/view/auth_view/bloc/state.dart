import 'package:equatable/equatable.dart';

class AuthProcessState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInViewState extends AuthProcessState {}

class SignUpViewState extends AuthProcessState {}

class AuthProcessLoadingState extends AuthProcessState {}

class AuthProcessFailureState extends AuthProcessState {
  final String message;

  AuthProcessFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
