import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildIconWithLabelWithColor(
  IconData icon,
  String label,
  String currentPage,
  VoidCallback onTap, // Change this to VoidCallback for better clarity
) {
  bool isSelected = label == currentPage;

  return GestureDetector( // Make the widget clickable
    onTap: onTap, // Call the provided onTap function when tapped
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? const Color(0xFF87C4FF) : Colors.grey,
          size: 27,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: isSelected ? const Color(0xFF87C4FF) : Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
