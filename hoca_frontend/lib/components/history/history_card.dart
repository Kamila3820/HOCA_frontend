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

  const HistoryCard({
    Key? key,
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
  }) : super(key: key);

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
                if (showRating) ...[
                  const SizedBox(height: 8),
                  // Check if isRated to conditionally render a GestureDetector or a Container
                  isRated
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            width: 50,
                            height: 60,
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
                      : GestureDetector(
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
                              height: 60,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
