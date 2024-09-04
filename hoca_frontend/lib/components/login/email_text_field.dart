import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align the text to the left
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0), // Add space ahead of "Email" text
          child: Text(
            "Email", // Topic text above the TextField
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFF7A7777), // Same color as the password label
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
                hintText: "example@gmail.com", // Email hint text
                hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black.withOpacity(0.2), // Transparent hint text
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5), // Same border radius as the password field
                ),
              ),
              style: const TextStyle(
                color: Color(0xFFA9A8A8), // Same color as password text
                fontWeight: FontWeight.w600, // Same font weight as password text
              ),
            ),
          ),
        ),
      ],
    );
  }
}
