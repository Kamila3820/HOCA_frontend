import 'package:flutter/material.dart';
import 'package:hoca_frontend/pages/register.dart';

class RegisterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Navigate to the sign-up page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
        child: const Text(
          "Don't have an account yet? Register now",
          style: TextStyle(
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
