import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewHeader extends StatelessWidget {
  final String? name;

  const ReviewHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$name's Review:",
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}