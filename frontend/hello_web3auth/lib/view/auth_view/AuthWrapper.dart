import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/view/auth_view/bloc/bloc.dart';
import 'package:hello_web3auth/view/auth_view/bloc/state.dart';
import 'package:hello_web3auth/view/auth_view/signin_screen.dart';
import 'package:hello_web3auth/view/auth_view/signup_screen.dart';
import 'package:hello_web3auth/view/splash_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthProcessBloc, AuthProcessState>(
        builder: (context, state) {
      if (state is SignInViewState) {
        return SignInScreen();
      } else if (state is SignUpViewState) {
        return SignUpScreen();
      } else {
        return const SplashScreen();
      }
    });
  }
}
