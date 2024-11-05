import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildCategoryChip(
    List<int> selectedCategories, String label, IconData icon, int value, Function(int) toggleCategory) {
  // Check if the category is selected
  bool isSelected = selectedCategories.contains(value);
  
  return GestureDetector(
    onTap: () => toggleCategory(value), // Pass the integer value
    child: Chip(
      avatar: Icon(
        icon,
        color: Colors.black87,
        size: 15.0,
      ),
      label: Text(
        label,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 10,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: isSelected
          ? const Color.fromARGB(110, 135, 195, 255)
          : const Color.fromARGB(35, 155, 155, 155),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
