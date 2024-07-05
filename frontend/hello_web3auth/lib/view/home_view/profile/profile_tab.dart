import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _createEventButton(),
              _logoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  _createEventButton() {
    return TextButton(
      onPressed: () {},
      child: Text('New event'),
    );
  }

  _logoutButton() {
    return TextButton(
      onPressed: () {},
      child: Text('Logout'),
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
