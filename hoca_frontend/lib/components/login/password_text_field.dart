import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: true,
    );
  }
}
