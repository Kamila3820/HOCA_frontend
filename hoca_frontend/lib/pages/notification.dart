import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/noti/buildnotificationcard.dart';

class NotiPage extends StatelessWidget {
  const NotiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF87C4FF).withOpacity(0.6), // 60% opacity
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      'Notification',
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
          ),
          const SizedBox(height: 20), // Add some spacing
          Expanded(
  child: ListView(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    children: [
      buildNotificationCard(
        imageUrl: 'https://via.placeholder.com/150', // Replace with actual image URL
        title: 'Confirmation',
        message: "Please confirm a new Karl Anthony's order within 15 minutes otherwise it will cancel automatically",
      ),
      const SizedBox(height: 10),
      buildNotificationCard(
        imageUrl: 'https://via.placeholder.com/150', // Replace with actual image URL
        title: 'Rating',
        message: "You've received a rating score from James588",
      ),
      const SizedBox(height: 10),
      buildNotificationCard(
        imageUrl: 'https://via.placeholder.com/150', // Replace with actual image URL
        title: 'Alert',
        message: "Your account will be locked after 3 failed login attempts.",
      ),
      const SizedBox(height: 10),
      buildNotificationCard(
        imageUrl: 'https://via.placeholder.com/150', // Replace with actual image URL
        title: 'Promo Code',
        message: "Use code 'SAVE20' for 20% off your next purchase.",
      ),
    ],
  ),
),

        ],
      ),
    );
  }


}
