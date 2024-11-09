import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifiedBadge extends StatelessWidget {
  final String? availableStart;
  final String? availableEnd;

  const VerifiedBadge({super.key, required this.availableStart, required this.availableEnd});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: const Color(0xFF90D26D),
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
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.access_time,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              '$availableStart-$availableEnd',
              style: GoogleFonts.poppins(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
