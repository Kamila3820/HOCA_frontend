import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildIconWithLabelWithColor({
  required IconData icon,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
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
