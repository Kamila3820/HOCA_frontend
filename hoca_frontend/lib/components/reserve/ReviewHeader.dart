import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Artiwara Kongmalai's Review:",
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}