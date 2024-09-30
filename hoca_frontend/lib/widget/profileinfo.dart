import 'package:flutter/material.dart';

class WorkerProfilePage extends StatelessWidget {
  const WorkerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Worker image
              ),
              const SizedBox(height: 10),
              const Text(
                'Artiwara Kongmalai',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '(5 times)',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow[700]),
                  const SizedBox(width: 5),
                  const Text('8.0', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  _buildTaskChip('Iron the clothes'),
                  _buildTaskChip('Mop the floor'),
                  _buildTaskChip('Wash dishes'),
                ],
              ),
              const SizedBox(height: 20),
              _buildVerifiedBadge(),
              const SizedBox(height: 20),
              _buildContactInfo(),
              const SizedBox(height: 20),
              _buildDescription(),
              const SizedBox(height: 20),
              _buildReviewSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }

  Widget _buildTaskChip(String task) {
    return Chip(
      label: Text(task),
      backgroundColor: Colors.grey[300],
    );
  }

  Widget _buildVerifiedBadge() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified, color: Colors.green),
        SizedBox(width: 5),
        Text(
          'verified',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 10),
            Text('Thung Khru, Bangkok'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.phone),
            SizedBox(width: 10),
            Text('098-765-4321'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.message),
            SizedBox(width: 10),
            Text('LINE ID: lawyer7'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.money),
            SizedBox(width: 10),
            Text('400 THB/hr.'),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Acceptable family size: 4',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Description:\n'
            'I\'m available to do the task jobs listed below. Now I\'m staying in Thung Khru, BKK:\n'
            '- Mop the floor\n'
            '- Wash dishes\n'
            '- Iron clothes',
          ),
          SizedBox(height: 10),
          Text(
            'Created on 14/03/2024',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'John Mayer\'s Review:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 10),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('K'),
          ),
          title: Text('Karl Anthony'),
          subtitle: Text('8/04/2024'),
        ),
      ],
    );
  }
}
