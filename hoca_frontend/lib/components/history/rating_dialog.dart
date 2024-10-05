import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'rating_section.dart';

void showRatingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blue box with adjustable width and height
              Container(
                width: double.infinity, // Set to full width of the dialog
                height: 80, // Set the desired height
                decoration: BoxDecoration(
                  color: const Color(0xFF87C4FF), // Blue background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners at the top
                ),
                padding: const EdgeInsets.all(12), // Add padding for aesthetics
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Rating your experience!\nTo give recommend to a worker',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0), // Black text for contrast
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: SizedBox(
                        width: 40, // Set the desired width
                        height: 40, // Set the desired height
                        child: Icon(Icons.close, color: const Color.fromARGB(255, 0, 0, 0)), // Black close icon
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(child: RatingSection(title: 'Work')),
              const SizedBox(height: 16),
              Center(child: RatingSection(title: 'Security')),
              const SizedBox(height: 16),
              Text(
                'Share your experience',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
  maxLines: 3,
  decoration: InputDecoration(
    hintText: 'Let us know your great experience!',
    hintStyle: TextStyle(
      color: Colors.black54, // Adjust the color for hint text
      fontSize: 14, // Optionally, set the font size
      fontWeight: FontWeight.normal, // Optionally, set the font weight
    ),
    border: OutlineInputBorder(),
  ),
),

              const SizedBox(height: 16),
              Center(
  child: ElevatedButton(
    onPressed: () {
      Navigator.of(context).pop(); // Close the dialog after submitting
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF87C4FF), // Set the background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Set the border radius
      ),
    ),
    child: Text(
      'Send rating',
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Colors.white, // Set the text color
          fontSize: 17,
          fontWeight: FontWeight.w500,
           // Set the text size
        ),
      ),
    ),
  ),
),


            ],
          ),
        ),
      );
    },
  );
}
