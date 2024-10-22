import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui'; // Import this to use ImageFilter for blur effect

class ProfilePicture extends StatelessWidget {
  final String? imageUrl;
  final double? rating;
  final bool? status; // Add status field

  const ProfilePicture({super.key, required this.imageUrl, required this.rating, this.status});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: ClipOval(
                // Ensure that the blur effect respects the circular shape
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                    if (status == false) // Apply blur when status is false
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust the blur intensity here
                        child: Container(
                          color: Colors.black.withOpacity(0), // Transparent overlay to enable the blur
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (status == false) // Show visibility_off icon if status is false
              const Positioned(
                child: Icon(
                  Icons.visibility_off,
                  color: Colors.redAccent,
                  size: 80,
                ),
              ),
            if (rating != null && rating! > 0.0) // Check if rating is not 0.0
              Positioned(
                bottom: 20,
                left: 140,
                child: Container(
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 18),
                            Icon(Icons.star, color: Colors.black, size: 10),
                          ],
                        ),
                        Text(
                          rating!.toStringAsFixed(1), // Display dynamic rating value
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.yellow,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
