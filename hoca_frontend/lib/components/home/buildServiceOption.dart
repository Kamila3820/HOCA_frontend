import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Widget buildServiceOption(String title, IconData icon) { // Removed underscore
  return Column(
    children: [
      Container(
        width: 88,
        height: 70,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFF6E7DA),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 21),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 10.1),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
