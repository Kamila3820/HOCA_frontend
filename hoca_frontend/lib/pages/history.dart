import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/history/history_card.dart';

class MessageNotificationTab extends StatelessWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;

  const MessageNotificationTab({
    Key? key,
    required this.onTabSelected,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildTab('User', 0),
          _buildTab('Worker', 1),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? const Color(0xFF87C4FF) : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 2,
              color: isSelected ? const Color(0xFF87C4FF) : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedTabIndex = 0;

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
          MessageNotificationTab(
            selectedIndex: _selectedTabIndex,
            onTabSelected: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
              // Add any additional logic for tab changes here
            },
          ),
          Expanded(
            child: _selectedTabIndex == 0 ? _buildUserList() : _buildWorkerList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return ListView(
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
    );
  }

  Widget _buildWorkerList() {
    // Placeholder for notification list
     return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // HistoryCard for a completed job with a price
        HistoryCard(
          id: 'ID165187',
          name: 'Gaysowadorn Yinggay',
          date: '2/06/2024',
          time: '13:00',
          status: 'Completed',
          iconColor: Colors.green,
          icon: FontAwesomeIcons.broom,
          
          price: '200.00', // Include price for completed jobs
        ),
        // HistoryCard for a canceled job (no price)
        HistoryCard(
          id: 'ID122231',
          name: 'Kaweephop Noppakun',
          date: '26/02/2024',
          time: '20:00',
          status: 'Canceled',
          statusColor: Colors.red,
          iconColor: Colors.red,
          icon: Icons.cancel,
          reason: 'Accident on leg',
          price: '', // No price for canceled jobs
        ),
        // HistoryCard for another completed job with a price
      ],
    );
  }
}