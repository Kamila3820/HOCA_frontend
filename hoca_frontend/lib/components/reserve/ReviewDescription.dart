import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock",
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    );
  }
}