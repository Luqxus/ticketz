import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/auth/bloc.dart';
import 'package:hello_web3auth/bloc/auth/event.dart';
import 'package:hello_web3auth/repository/user_repository.dart';
import 'package:hello_web3auth/utils/custom_exceptions.dart';
import 'package:hello_web3auth/utils/signin_response.dart';
import 'package:hello_web3auth/view/auth_view/bloc/event.dart';
import 'package:hello_web3auth/view/auth_view/bloc/state.dart';

class AuthProcessBloc extends Bloc<AuthProcessEvent, AuthProcessState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  AuthProcessBloc(
      {required this.authenticationBloc, required this.userRepository})
      : super(SignInViewState()) {
    on<SignInButtonPressed>(_signin);
    on<SignUpButtonPressed>(_signup);
    on<ToggleSignInView>(_toggleSignInView);
    on<ToggleSignUpView>(_toggleSignUpView);
  }

  _signin(SignInButtonPressed event, Emitter emit) async {
    emit(AuthProcessLoadingState());

    try {
      print("--------------------------");
      final SignInResponse response = await userRepository.signin(
        email: event.email,
        password: event.password,
      );

      print(response.getEmail);
      authenticationBloc.add(LoggedIn(response.getEmail, response.getToken));
    } on UnauthorizedException {
      emit(AuthProcessFailureState(
          'wrong email or password. Please try again.'));
    } catch (error) {
      print("+_+++++++++++++++++++");
      print(error.toString());
      emit(AuthProcessFailureState(error.toString()));
    }
  }

  _signup(SignUpButtonPressed event, Emitter emit) async {
    emit(AuthProcessLoadingState());

    try {
      final SignInResponse response = await userRepository.signup(
        email: event.email,
        username: event.username,
        password: event.password,
      );

      authenticationBloc.add(LoggedIn(response.email, response.token));
    } on UnauthorizedException {
      emit(AuthProcessFailureState('user already exists'));
    } catch (error) {
      emit(AuthProcessFailureState(error.toString()));
    }
  }

  _toggleSignInView(ToggleSignInView event, Emitter emit) {
    emit(AuthProcessLoadingState());

    emit(SignInViewState());
  }

  _toggleSignUpView(ToggleSignUpView event, Emitter emit) {
    emit(AuthProcessLoadingState());

    emit(SignUpViewState());
  }
}
