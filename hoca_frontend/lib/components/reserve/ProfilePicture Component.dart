import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://example.com/profile_picture.jpg'),
              ),
            ),
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
                        '8.0',
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