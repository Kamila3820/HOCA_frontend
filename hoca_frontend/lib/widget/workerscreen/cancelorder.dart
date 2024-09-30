import 'package:flutter/material.dart';

class CancelOrderScreen extends StatelessWidget {
  const CancelOrderScreen({super.key});

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
            const SizedBox(height: 20),
            _buildCancelForm(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Send cancellation reason
              },
              child: const Text('SEND'),
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
            Text('Distance: 15 km'),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('I want to cancel the order due to...'),
        RadioListTile(
          title: const Text('Urgent Business'),
          value: 1,
          groupValue: 0,
          onChanged: (value) {
            // Handle radio button change
          },
        ),
        RadioListTile(
          title: const Text('Bad Weather'),
          value: 2,
          groupValue: 0,
          onChanged: (value) {
            // Handle radio button change
          },
        ),
        RadioListTile(
          title: const Text('Amount of work & Place to work'),
          value: 3,
          groupValue: 0,
          onChanged: (value) {
            // Handle radio button change
          },
        ),
        RadioListTile(
          title: const Text('Other Problems'),
          value: 4,
          groupValue: 0,
          onChanged: (value) {
            // Handle radio button change
          },
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
