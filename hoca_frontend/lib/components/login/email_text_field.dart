import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "example@gmail.com",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
