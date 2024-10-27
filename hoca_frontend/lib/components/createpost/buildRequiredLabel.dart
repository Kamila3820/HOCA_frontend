  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildRequiredLabel(String text) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Text(
          ' ',
          style: TextStyle(
            
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }