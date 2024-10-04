import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderContainer extends StatelessWidget {
  final VoidCallback onBackPressed;

  const HeaderContainer({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF87C4FF).withOpacity(0.6),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(90),
          bottomRight: Radius.circular(90),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 160, left: 20, right: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0),
                onPressed: onBackPressed,
              ),
            ),
            Center(
              child: Text(
                'Create Worker',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
