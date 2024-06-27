import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/auth/bloc.dart';
import 'package:hello_web3auth/bloc/auth/event.dart';
import 'package:hello_web3auth/repository/user_repository.dart';
import 'package:hello_web3auth/utils/custom_exceptions.dart';
import 'package:hello_web3auth/utils/signin_response.dart';
import 'package:hello_web3auth/view/auth_view/sigin_in/bloc/event.dart';
import 'package:hello_web3auth/view/auth_view/sigin_in/bloc/state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  SignInBloc({required this.authenticationBloc, required this.userRepository})
      : super(SignInInitial()) {
    on<SignInButtonPressed>(_signin);
  }

  _signin(SignInButtonPressed event, Emitter emit) async {
    emit(SignInLoading());

    try {
      final SignInResponse response = await userRepository.signin(
        email: event.email,
        password: event.password,
      );

      authenticationBloc.add(LoggedIn(response.email, response.token));
    } on UnauthorizedException {
      emit(SignInFailure('wrong email or password. Please try again.'));
    } catch (error) {
      emit(SignInFailure(error.toString()));
    }
  }
}
