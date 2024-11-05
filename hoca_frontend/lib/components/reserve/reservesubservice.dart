import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/models/categories.dart';

class ReSubserviceWidget extends StatelessWidget {
  final List<Categories> categories;

  const ReSubserviceWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    // Extract the names of the first three categories, adding "..." if there are more than three
    final displayedNames = categories.length > 3
        ? categories.take(3).map((cat) => cat.name).toList() + ['...']
        : categories.map((cat) => cat.name).toList();

    return Expanded(
      child: Row(
        children: displayedNames.map((name) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            padding: const EdgeInsets.all(6.0),
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
              name,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(228, 0, 0, 0),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
