import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/history/history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'History',
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // HistoryCard for a completed job with a price
                HistoryCard(
                  id: 'ID344546',
                  name: 'Ratanaporn Yong',
                  date: '28/04/2024',
                  time: '12:30',
                  status: 'Completed',
                  iconColor: Colors.green,
                  icon: FontAwesomeIcons.broom,
                  showRating: true,
                  price: '120.00', // Include price for completed jobs
                ),
                // HistoryCard for a canceled job (no price)
                HistoryCard(
                  id: 'ID588724',
                  name: 'Ploypailin Saethong',
                  date: '26/04/2024',
                  time: '18:45',
                  status: 'Canceled',
                  statusColor: Colors.red,
                  iconColor: Colors.red,
                  icon: Icons.cancel,
                  reason: 'Bad weather',
                  price: '', // No price for canceled jobs
                ),
                // HistoryCard for another completed job with a price
                HistoryCard(
                  id: 'ID448875',
                  name: 'Jinda Saeaum',
                  date: '25/04/2024',
                  time: '10:30',
                  status: 'Completed',
                  iconColor: Colors.green,
                  icon: FontAwesomeIcons.broom,
                  showRating: true,
                  isRated: true,
                  price: '150.00', // Include price for completed jobs
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
