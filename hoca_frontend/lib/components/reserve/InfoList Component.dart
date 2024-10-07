import 'package:flutter/material.dart';

class InfoList extends StatelessWidget {
  const InfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInfoTile(Icons.location_on, 'Thung Khru, Bangkok'),
        buildInfoTile(Icons.phone, '098-765-4321'),
        buildInfoTile(Icons.message, 'LINE ID: lawyer7'),
        buildInfoTile(Icons.home, 'Acceptable type of place: House/Dormitory room'),
        buildInfoTile(Icons.people, 'Acceptable range of family size: 3-5 people'),
      ],
    );
  }

  Widget buildInfoTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}