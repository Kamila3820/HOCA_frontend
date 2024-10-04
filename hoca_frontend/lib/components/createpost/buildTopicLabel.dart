 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTopicLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }