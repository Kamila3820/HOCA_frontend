import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Color(0xFF90D26D),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'verified',
            style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}