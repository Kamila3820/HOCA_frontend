import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecurityRating extends StatelessWidget {
  final int? score;

  const SecurityRating({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Security",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Icon(
          Icons.star,
          color: Color(0xFF3EA03C),
        ),
        const SizedBox(width: 5),
        Text(
          "$score/10",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3EA03C),
          ),
        ),
      ],
    );
  }
}