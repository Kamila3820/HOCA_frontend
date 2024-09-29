import 'package:flutter/material.dart';
import 'completepage.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
            _buildWorkerInfo('Artiwara Kongmalai', 'Working time!'),
            const SizedBox(height: 20),
            _buildOrderId(),
            const SizedBox(height: 40),
            _buildQRCode(),
            const Spacer(),
            _buildPaymentButton(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildWorkerInfo(String name, String status) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(status),
    );
  }

  Widget _buildOrderId() {
    return const Text('Order ID: 12345678');
  }

  Widget _buildQRCode() {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.grey[300],
        child: const Center(child: Text('QR Code Placeholder')),
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CompletePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.green, // Replace 'primary' with 'backgroundColor'
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: const Text('Payment Successful',
            style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const [
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
