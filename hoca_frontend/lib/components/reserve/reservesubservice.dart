import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReSubserviceWidget extends StatelessWidget {
  final String text;

  const ReSubserviceWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEED9), // Light peach color
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(228, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }
}