import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/pages/home.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 650,
      left: 20,
      right: 20,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF87C4FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            'Create Post',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
