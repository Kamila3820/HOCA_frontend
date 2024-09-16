import 'package:flutter/material.dart';

class WorkerWorkingScreen extends StatelessWidget {
  const WorkerWorkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOrderDetails(),
            const SizedBox(height: 10),
            _buildTimeline(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Complete action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('COMPLETE'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildOrderDetails() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text('J'),
              ),
              title: Text('Jintara Malawan'),
              subtitle: Text('08x-765-4321'),
              trailing: Text('500 THB - QR Payment'),
            ),
            SizedBox(height: 10),
            Text('Artiwara need your help'),
            Text('Service Timeline'),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text('Map the Floor'),
        ),
        ListTile(
          leading: Icon(Icons.radio_button_unchecked, color: Colors.grey),
          title: Text('Wash Dishes'),
        ),
        ListTile(
          leading: Icon(Icons.radio_button_unchecked, color: Colors.grey),
          title: Text('Iron Clothes'),
        ),
        ListTile(
          leading: Icon(Icons.radio_button_unchecked, color: Colors.grey),
          title: Text('Map the Floor'),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Progress'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: 2,
      onTap: (index) {
        // Handle bottom navigation
      },
    );
  }
}
