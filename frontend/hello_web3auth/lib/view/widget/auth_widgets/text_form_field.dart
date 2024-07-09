import 'package:flutter/material.dart';

class AuthFormTextField extends StatelessWidget {
  const AuthFormTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false});

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }
}
