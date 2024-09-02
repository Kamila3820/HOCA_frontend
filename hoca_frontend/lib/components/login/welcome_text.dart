import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Welcome to HOCA",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Please Login to your account",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
