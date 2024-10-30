import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/history/history_card.dart';
import 'package:hoca_frontend/models/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          _buildTab('Reserved', 0),
          _buildTab('Worked', 1),
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
  List<dynamic> userHistory = [];
  List<dynamic> workHistory = [];

  @override
  void initState() {
    super.initState();
    if (_selectedTabIndex == 0) {
      _fetchUserHistory();
      _fetchWorkedHistory();
    }
  }

  void _loadData() {
    _fetchUserHistory();
  }

  Future<void> _fetchUserHistory() async {
    String url = "/v1/history/list";
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
      print(response.data);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print("1");
         List<History> historyList = (response.data as List).map((historyJson) => History.fromJson(historyJson)).toList();
        print("Historyyyyyyyyyyyyyyyyyyyyyy");
        print(historyList);
        setState(() {
          userHistory = historyList; // Update the state with parsed history data
        });
      } else if (response.statusCode == 404 || response.statusCode == 500) {
        print('Failed to fetch history');
      } else {
        throw Exception('Failed to load post');
      } 
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _fetchWorkedHistory() async {
    String url = "/v1/history/work";
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
      print(response.data);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print("1");
         List<History> historyList = (response.data as List).map((historyJson) => History.fromJson(historyJson)).toList();
        print("Historyyyyyyyyyyyyyyyyyyyyyy");
        print(historyList);
        setState(() {
          workHistory = historyList; // Update the state with parsed history data
        });
      } else if (response.statusCode == 404 || response.statusCode == 500) {
        print('Failed to fetch history');
      } else {
        throw Exception('Failed to load post');
      } 
    } catch (error) {
      print('Error: $error');
    }
  }

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
    if (userHistory.isEmpty) {
    return Center(
      child: Text(
        'No reserve history available',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: userHistory.length,
    itemBuilder: (context, index) {
      // Access the History object
      History historyItem = userHistory[index];
      String formattedDate = historyItem.createdAt!.replaceAll('-', '/');

      return HistoryCard(
        historyID: historyItem.historyID.toString(),
        orderID: "ID"+historyItem.orderID!,
        name: historyItem.name!,
        date: formattedDate, 
        time: '',  
        status: historyItem.status!,
        iconColor: historyItem.status! == 'complete' ? Colors.green : Colors.red,
        icon: historyItem.status! == 'complete' ? Icons.check_circle : Icons.cancel,
        reason: historyItem.cancellationReason!,
        price: historyItem.price?.toString() ?? '',
        showRating: historyItem.status! == 'complete' ? true : false,
        isRated: historyItem.isRated!,
        reloadData: _loadData,
      );
    },
  );
}


  Widget _buildWorkerList() {
    if (workHistory.isEmpty) {
    return Center(
      child: Text(
        'No work history available',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workHistory.length,
      itemBuilder: (context, index) {
        History historyItem = workHistory[index];
        String formattedDate = historyItem.createdAt!.replaceAll('-', '/');

        return HistoryCard(
          historyID: historyItem.historyID.toString(),
          orderID: "ID"+historyItem.orderID!,
          name: historyItem.name!,
          date: formattedDate, 
          time: '',  
          status: historyItem.status!,
          iconColor: historyItem.status! == 'complete' ? Colors.green : Colors.red,
          icon: historyItem.status! == 'complete' ? Icons.check_circle : Icons.cancel,
          reason: historyItem.cancellationReason!,
          price: historyItem.price?.toString() ?? '',
          isRated: historyItem.isRated!,
        );
      },
    );
  }
}