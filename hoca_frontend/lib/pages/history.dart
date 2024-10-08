import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/widget/historyItemBox.dart';
import 'package:hoca_frontend/widget/ratingPopup.dart';
import 'rating.dart'; // Assuming you have this rating page
import 'package:hoca_frontend/components/navbar/customnavbar.dart'; // Make sure to import the navbar

class HistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> historyItems = [
    {
      'orderID': "111",
      'name': 'Ratanaporn Yong',
      'date': '28/04/2024 12:30',
      'price': "100",
      'status': 'Completed',
      'cancellationReason': '',
      'ratingStatus': true,
    },
    {
      'orderID': "112",
      'name': 'Ploypailin Saethong',
      'date': '28/04/2024 18:45',
      'price': "100",
      'status': 'Cancelled',
      'cancellationReason': 'Bad weather',
      'ratingStatus': true,
    },
    {
      'orderID': "113",
      'name': 'Jinda Saeum',
      'date': '25/04/2024 10:30',
      'price': "100",
      'status': 'Completed',
      'cancellationReason': '',
      'ratingStatus': false,
    },
    {
      'orderID': "113",
      'name': 'Jinda Saeum',
      'date': '25/04/2024 10:30',
      'price': "100",
      'status': 'Completed',
      'cancellationReason': '',
      'ratingStatus': false,
    },
    {
      'orderID': "113",
      'name': 'Jinda Saeum',
      'date': '25/04/2024 10:30',
      'price': "100",
      'status': 'Completed',
      'cancellationReason': '',
      'ratingStatus': false,
    },
    {
      'orderID': "114",
      'name': 'Artivara Kong',
      'date': '12/04/2024 11:45',
      'price': "100",
      'status': 'Completed',
      'cancellationReason': '',
      'ratingStatus': true,
    },
  ];

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF87C4FF).withOpacity(0.6),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0), // Add bottom padding to avoid floating button overlap
  child: ListView.builder(
    itemCount: historyItems.length,
    itemBuilder: (context, index) {
      final item = historyItems[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4), // Adjusted gap between items
        child: HistoryItemBox(
          orderID: item['orderID'],
          name: item['name'],
          date: item['date'],
          price: item['price'],
          status: item['status'],
          cancellationReason: item['cancellationReason'],
          ratingStatus: item['ratingStatus'],
          onRate: item['ratingStatus'] == false
              ? () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const RatingDialog();
                    },
                  );
                }
              : null, // Disable the button if it's already rated
        ),
      );
    },
  ),
),

      bottomNavigationBar: const CustomBottomNavigationBar(
        currentPage: 'History', // Update to reflect the current page
      ),
      floatingActionButton: const CustomFloatingActionButton(), // Add the floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Center the floating action button
    );
  }
}
