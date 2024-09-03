import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOrderDetails(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Cancel action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Confirm action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('CONFIRM'),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildOrderDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            Text('Address: Condominium H4 Floor 4 Room 423'),
            SizedBox(height: 10),
            Text('Note from customer:'),
            Text('Look like someone need your help...'),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
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
