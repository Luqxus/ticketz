import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/view/auth_view/bloc/bloc.dart';
import 'package:hello_web3auth/view/auth_view/bloc/event.dart';
import 'package:hello_web3auth/view/widget/auth_widgets/text_form_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const RangeMaintainingScrollPhysics(),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hey,\nSign in now.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'If you are new /',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<AuthProcessBloc>(context).add(
                              ToggleSignUpView(),
                            );
                          },
                          child: Text(
                            ' Sign up',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    AuthFormTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    AuthFormTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    _signinButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signinButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
            onPressed: () {
              BlocProvider.of<AuthProcessBloc>(context).add(
                SignInButtonPressed(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Text(
                'Sign in',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
