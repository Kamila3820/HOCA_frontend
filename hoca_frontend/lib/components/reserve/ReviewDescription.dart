import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewDescription extends StatelessWidget {
  final String? comment;

  const ReviewDescription({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,  
      child: Text(
        comment!,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,  
      ),
    );
  }
}
