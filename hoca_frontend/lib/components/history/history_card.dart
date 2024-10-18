import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'rating_dialog.dart';

class HistoryCard extends StatelessWidget {
  final String id;
  final String name;
  final String date;
  final String time;
  final String status;
  final Color statusColor;
  final Color iconColor;
  final IconData icon;
  final bool showRating;
  final bool isRated;
  final String? reason;
  final String price; // Price field

  const HistoryCard({
    super.key,
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.status,
    this.statusColor = Colors.green,
    required this.iconColor,
    required this.icon,
    this.showRating = false,
    this.isRated = false,
    this.reason,
    required this.price, // Initialize price
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  id,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$date $time',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  if (status == 'Completed') ...[
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                  if (reason != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      reason!,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (status == 'Canceled') ...[
                  Text(
                    status, // Display "Canceled"
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                if (status != 'Canceled') ...[ // Do not show price for canceled jobs
                  Text(
                    '฿ $price', // Show price for non-canceled jobs
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                if (showRating) ...[
                  isRated
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            width: 50,
                            height: 30,
                            child: Center(
                              child: Text(
                                'Rated',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [                         
                            GestureDetector(
                              onTap: () {
                                showRatingDialog(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE15D),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      'Rating',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
