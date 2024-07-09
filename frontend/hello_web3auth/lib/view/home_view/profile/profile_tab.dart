import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/auth/bloc.dart';
import 'package:hello_web3auth/bloc/auth/event.dart';
import 'package:hello_web3auth/repository/event_repository.dart';
import 'package:hello_web3auth/view/create_event/bloc/bloc.dart';
import 'package:hello_web3auth/view/create_event/create_event.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              _createEventButton(context),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  _createEventButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: navigate to create event page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CreateEventBloc(EventRepositoryImpl()),
              child: CreateEventScreen(),
            ),
          ),
        );
      },
      child: const Text('New event'),
    );
  }

  _logoutButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
      },
      child: const Text('Logout'),
    );
  }
}

class NewEventScreen extends StatelessWidget {
  const NewEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
