import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Work",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
        const SizedBox(width: 5),
        Text(
          "9/10",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}