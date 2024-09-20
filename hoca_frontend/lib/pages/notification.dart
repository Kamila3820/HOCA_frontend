import 'package:flutter/material.dart';

class NotiPage extends StatelessWidget {
  const NotiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!, Suphanut'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_pin),
                SizedBox(width: 8),
                Text('15/34 Thungkhru, Bangkok'),
              ],
            ),
            SizedBox(height: 16),
            Text('Service', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ServiceButton(icon: Icons.cleaning_services, label: 'Cleaning'),
                ServiceButton(icon: Icons.shopping_bag, label: 'Clothes'),
                ServiceButton(icon: Icons.pets, label: 'Pets'),
                ServiceButton(icon: Icons.grass, label: 'Gardening'),
              ],
            ),
            SizedBox(height: 16),
            Text('Worker Available', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            WorkerList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 32),
          onPressed: () {},
        ),
        Text(label),
      ],
    );
  }
}

class WorkerList extends StatelessWidget {
  const WorkerList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WorkerCard(
          name: 'Teerasil Dangda',
          rating: '8.7',
          distance: '2.4 km',
          price: '420 THB/hr',
        ),
        WorkerCard(
          name: 'Aritwara Kongmalai',
          rating: '8.0',
          distance: '3.6 km',
          price: '400 THB/hr',
        ),
        // Add more WorkerCards as needed
      ],
    );
  }
}

class WorkerCard extends StatelessWidget {
  final String name;
  final String rating;
  final String distance;
  final String price;

  const WorkerCard({super.key, 
    required this.name,
    required this.rating,
    required this.distance,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage:
              AssetImage('assets/worker.jpg'), // Replace with your image
        ),
        title: Text(name),
        subtitle: Text('$distance | $price'),
        trailing: Text('Total ⭐ $rating'),
      ),
    );
  }
}
