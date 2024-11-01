import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildNotificationCard({required String imageUrl, required String title, required String message, Color titleColor = Colors.black }) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              imageUrl,
              width: 50, // Adjust the size as needed
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: titleColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}