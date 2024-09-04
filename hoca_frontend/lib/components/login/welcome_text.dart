import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome to HOCA",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF87C4FF),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Please Login to your account",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
            fontSize: 23,
            color: Color(0xFF7A7777),
          ),
          ),
          
        ),
      ],
    );
  }
}
