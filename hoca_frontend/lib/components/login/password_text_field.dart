import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align the text to the left
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0), // Add space ahead of "Password" text
          child: Text(
            "Password", // Topic text above the TextField
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFF7A7777), // Same color as the email label
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ), // Add some spacing between the topic text and the field
        Center(
          child: SizedBox(
            width: 340, // Set the desired width of the TextField
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter password",
                hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black.withOpacity(0.2), // Transparent hint text
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5), // Same border radius as the email field
                ),
              ),
              obscureText: true, // To hide the password input
              style: const TextStyle(
                color: Color(0xFFA9A8A8), // Same color and weight as the email text
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
