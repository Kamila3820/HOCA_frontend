import 'package:flutter/material.dart';
import 'payment.dart';

class WorkingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWorkerInfo(
                'Artiwara Kongmalai', 'Arriving to the destination'),
            SizedBox(height: 20),
            _buildAmountInfo('800 THB - QR Payment'),
            SizedBox(height: 40),
            _buildMap(),
            Spacer(),
            _buildWorkingButton(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildWorkerInfo(String name, String status) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(status),
    );
  }

  Widget _buildAmountInfo(String amount) {
    return Row(
      children: [
        Text(
          'Amount',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildMap() {
    return Container(
      height: 300,
      color: Colors.grey[300],
      child: Center(child: Text('Map View Placeholder')),
    );
  }

  Widget _buildWorkingButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Updated property
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: Text('Working Time!', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task_alt),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: 3,
      onTap: (index) {
        // Handle bottom navigation taps
      },
    );
  }
}