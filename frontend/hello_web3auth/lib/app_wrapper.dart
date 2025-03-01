import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/auth/bloc.dart';
import 'package:hello_web3auth/bloc/auth/state.dart';
import 'package:hello_web3auth/view/auth_view/AuthWrapper.dart';
import 'package:hello_web3auth/view/home_view/home_view.dart';
import 'package:hello_web3auth/view/splash_screen.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthState>(
        builder: (context, state) {
      if (state is AuthLoadingState) {
        return const SplashScreen();
      } else if (state is UnauthenticatedState) {
        return const AuthWrapper();
      } else if (state is AuthenticatedState) {
        return HomeScreen();
      } else {
        return const SplashScreen();
      }
    });
  }
}
