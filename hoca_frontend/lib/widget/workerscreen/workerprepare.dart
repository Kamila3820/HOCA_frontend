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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStepIndicator(),
            _buildWorkerInfo(),
            _buildServiceTimeline(),
            _buildUploadSection(),
            _buildCompleteButton(),
          ],
        ),
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
          _buildStep('Preparing', isActive: false),
          _buildStep('Working', isActive: true),
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
                Text('time 7 MAR 2024 19:03', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('800 THB - QR Payment', style: TextStyle(color: Colors.green)),
            const SizedBox(height: 8),
            Text('Artiwara 0817654321', style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTimeline() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Service Timeline', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTimelineItem('Mop The Floor', isDone: true),
          _buildTimelineItem('Wash Dishes', isDone: true),
          _buildTimelineItem('Iron Clothes', isDone: false),
          _buildTimelineItem('Mop The Floor', isDone: false),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String task, {required bool isDone}) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone ? Colors.green : Colors.grey[300],
          ),
          child: isDone ? Icon(Icons.check, color: Colors.white, size: 16) : null,
        ),
        const SizedBox(width: 12),
        Text(task),
      ],
    );
  }

  Widget _buildUploadSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Upload The Work Done', style: TextStyle(fontWeight: FontWeight.bold)),
          Icon(Icons.add, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCompleteButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ElevatedButton(
        onPressed: () {
          // Handle complete action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('COMPLETE', style: TextStyle(fontSize: 18)),
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