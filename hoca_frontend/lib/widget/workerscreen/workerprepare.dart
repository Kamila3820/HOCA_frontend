import 'package:flutter/material.dart';

class WorkerPreparingScreen extends StatelessWidget {
  const WorkerPreparingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        backgroundColor: Colors.lightBlue[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStepIndicator(),
          _buildWorkerInfo(),
          const Spacer(),
          _buildVacuumIcon(),
          const SizedBox(height: 20),
          _buildReadyToWorkButton(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.lightBlue[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStep('Confirm', isActive: false),
          _buildStep('Preparing', isActive: true),
          _buildStep('Working', isActive: false),
          _buildStep('Complete', isActive: false),
        ],
      ),
    );
  }

  Widget _buildStep(String title, {required bool isActive}) {
    return Text(
      title,
      style: TextStyle(
        color: isActive ? Colors.blue : Colors.grey,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildWorkerInfo() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('J', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jintara Maliwan', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('088-765-4321', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
                Text('7 MAR 2024 19:03', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('800 THB - QR Payment', style: TextStyle(color: Colors.green)),
            const SizedBox(height: 12),
            Text('Client need your help', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person, size: 16),
                Expanded(child: LinearProgressIndicator(value: 0.5)),
                Icon(Icons.location_on, size: 16),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('15 km'),
                Text('Arriving in 20 mins'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVacuumIcon() {
    return Icon(Icons.cleaning_services, size: 100, color: Colors.grey);
  }

  Widget _buildReadyToWorkButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // Handle ready to work action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('READY TO WORK', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 3,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline, size: 40),
          label: '',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Progress'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}