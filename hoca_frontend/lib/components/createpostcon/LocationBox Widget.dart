import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your location',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Locate Your Location',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(243, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}