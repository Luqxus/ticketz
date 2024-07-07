import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/app_wrapper.dart';
import 'package:hello_web3auth/bloc/auth/bloc.dart';
import 'package:hello_web3auth/bloc/auth/event.dart';
import 'package:hello_web3auth/bloc/events/bloc.dart';
import 'package:hello_web3auth/bloc/tickets/bloc.dart';
import 'package:hello_web3auth/repository/event_repository.dart';
import 'package:hello_web3auth/repository/ticket_repository.dart';
import 'package:hello_web3auth/repository/user_repository.dart';
import 'package:hello_web3auth/service/secure_storage.dart';
import 'package:hello_web3auth/view/auth_view/bloc/bloc.dart';
import 'package:hello_web3auth/view/auth_view/bloc/event.dart';
import 'package:hello_web3auth/view/home_view/bloc/bloc.dart';

void main() {
  runApp(TicketzApp());
}

class TicketzApp extends StatelessWidget {
  TicketzApp({super.key});

  final SecureStorage _secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // authentication bloc provider

        BlocProvider(
          create: (context) => AuthenticationBloc(
            secureStorage: _secureStorage,
          )..add(
              AppStartedEvent(),
            ),
        ),

        // home view bloc provider
        BlocProvider(
          create: (context) => HomeViewBloc(),
        ),

        // event  bloc provider
        BlocProvider<EventsBloc>(
          create: (context) => EventsBloc(EventRepositoryImpl()),
        ),

        // auth process bloc provider
        BlocProvider(
          create: (context) => AuthProcessBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: UserRepositoryImpl(),
          )..add(ToggleSignInView()),
        ),

        // tickets bloc provider
        BlocProvider(
          create: (context) => TicketBloc(
            secureStorage: _secureStorage,
            ticketRepository: TicketRepositoryImpl(),
          ),
        ),
      ],

      // material app
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const AppWrapper(),
      ),
    );
  }
}
