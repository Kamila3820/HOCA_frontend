import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewTile extends StatelessWidget {
  final String name;
  final String date;

  const ReviewTile({super.key, required this.name, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            name[0].toUpperCase(),
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              date.replaceAll("-", "/"),
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      ],
    );
  }
}