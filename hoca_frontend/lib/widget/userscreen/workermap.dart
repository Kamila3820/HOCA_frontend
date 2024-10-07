import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        backgroundColor: Colors.lightBlue[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepIndicator('Confirm', isActive: false),
                _buildStepIndicator('Preparing', isActive: true),
                _buildStepIndicator('Working', isActive: false),
                _buildStepIndicator('Complete', isActive: false),
              ],
            ),
            const SizedBox(height: 24),

            // User info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage('https://example.com/placeholder.jpg'),
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Artiwara Kongmalai',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: const [
                              Icon(Icons.directions_walk, size: 16),
                              SizedBox(width: 4),
                              Text('Arriving to the destination'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: const [
                              Text('Amount:'),
                              SizedBox(width: 4),
                              Text(
                                '800 THB - QR Payment',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Worker info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Worker on the way!'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text('Worker: Jintara 0123456789'),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '15 Mins',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const LinearProgressIndicator(value: 0.5),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Map placeholder
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.map, size: 64, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Wait message
            const Center(
              child: Text(
                'Please wait a moment, Worker on the way!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 32),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(String title, {required bool isActive}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }
}