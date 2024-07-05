import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/view/auth_view/bloc/bloc.dart';
import 'package:hello_web3auth/view/auth_view/bloc/event.dart';
import 'package:hello_web3auth/view/widget/auth_widgets/text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Form(
            child: Column(
              children: [
                AuthFormTextField(
                  controller: _emailController,
                  hintText: 'Email',
                ),
                AuthFormTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                ),
                AuthFormTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 32,
                ),
                _signupButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signupButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),
      onPressed: () {
        BlocProvider.of<AuthProcessBloc>(context).add(
          SignUpButtonPressed(
            email: _emailController.text,
            password: _passwordController.text,
            username: _usernameController.text,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Text('Sign in'),
      ),
    );
  }
}
