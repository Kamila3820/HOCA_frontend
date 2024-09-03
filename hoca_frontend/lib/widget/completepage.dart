import 'package:flutter/material.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({super.key});

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
            _buildWorkerInfo('Artiwara Kongmalai', 'Complete!'),
            const Spacer(),
            _buildCompletionBadge(),
            const Spacer(),
            _buildDoneButton(context),
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

  Widget _buildCompletionBadge() {
    return Center(
      child: Column(
        children: [
          Image.network(
            'https://via.placeholder.com/100',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20),
          const Text('All Done! All Task Finished',
              style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: const Text('DONE', style: TextStyle(color: Colors.white)),
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
