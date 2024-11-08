import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/models/ratingmetrics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicture extends StatelessWidget {
  final String postID;
  final String? imageUrl;
  final double? rating;
  final bool? status;
  final VoidCallback? onRatingTap;

  const ProfilePicture({
    super.key, 
    required this.postID,
    required this.imageUrl, 
    required this.rating, 
    this.status, 
    this.onRatingTap
  });

  void _showRatingDialog(BuildContext context) async {
    RatingMetrics? ratingMetrics;
    String url = "/v1/rating/metric/$postID";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await Caller.dio.get(
        url,
        options: Options(
          headers: {
            'x-auth-token': '$token', // Add token to header
          },
        ),
      );

      if (response.statusCode == 200) {
        ratingMetrics = RatingMetrics.fromJson(response.data);
      } else {
        // Handle server errors
        print("Failed to load rating metrics: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching rating metrics: $e");
    }


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.feedback, color: Colors.blue), // Add the feedback icon here
                          const SizedBox(width: 8.0), // Space between icon and text
                          Text(
                            'Customer Feedback',
                            style: GoogleFonts.montserrat(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),
                  Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                  color: const Color(0xFF87C4FF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      offset: const Offset(0, 4),           // Position of shadow
                      blurRadius: 6,                         // Blur effect
                    ),
                  ],
                ),
                  child: Column(
                    children: [
                      Text(
                        'Overall Rating',
                        style: GoogleFonts.montserrat(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '${rating!.toStringAsFixed(1)}/10',
                        style: GoogleFonts.montserrat(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Based on ${ratingMetrics?.totalRating} reviews',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.0,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                  const SizedBox(height: 24.0),
                  _ratingRow('Maximum score', '${ratingMetrics?.maxScore}/10', Color(0xFF90D26D)),
                  _ratingRow('Minimum score', '${ratingMetrics?.minScore}/10', Colors.yellow.shade300),
                  _starRatingRow('Avg. Work', ratingMetrics!.avgWork!),
                  _starRatingRow('Avg. Security', ratingMetrics.avgSecurity!),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _ratingRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _starRatingRow(String label, double ratingValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
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
                const SizedBox(width: 4.0),
                Text(
                  ratingValue.toStringAsFixed(1),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                    if (status == false)
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.black.withOpacity(0),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (status == false)
              const Positioned(
                child: Icon(
                  Icons.visibility_off,
                  color: Colors.redAccent,
                  size: 80,
                ),
              ),
            if (rating != null && rating! > 0.0)
              Positioned(
                bottom: 20,
                left: 140,
                child: GestureDetector(
                  onTap: () {
                    if (onRatingTap != null) {
                      onRatingTap!();
                    } else {
                      _showRatingDialog(context);
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 2),
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
                            rating!.toStringAsFixed(1),
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
              ),
          ],
        ),
      ],
    );
  }
}