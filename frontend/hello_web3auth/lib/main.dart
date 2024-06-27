import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/app_wrapper.dart';
import 'package:hello_web3auth/bloc/auth/bloc.dart';
import 'package:hello_web3auth/bloc/auth/event.dart';
import 'package:hello_web3auth/service/secure_storage.dart';

void main() {
  runApp(TicketzApp());
}

class TicketzApp extends StatelessWidget {
  const TicketzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AuthenticationBloc(
          secureStorage: SecureStorage(),
        )..add(
            AppStartedEvent(),
          ),
        child: const AppWrapper(),
      ),
    );
  }
}
