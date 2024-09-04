import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Don't have an account yet? ",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15, // Font size for this part
                    color: Colors.black, // Black color for this part
                  ),
                ),
              ),
              TextSpan(
                text: "Register now",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15, // Font size for this part
                    color: Colors.blueAccent, // Blue color for the "Register now" part
                    decoration: TextDecoration.underline, // Underline only this part
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
