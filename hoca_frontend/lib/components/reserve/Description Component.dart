import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String? description;
  final String? create;
  final String? update;

  const Description({super.key, required this.description, required this.create, required this.update});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8), // Space between label and box
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            description ?? '-',
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 10), // Space between description box and dates

        // Created on
        Align(
          alignment: Alignment.centerRight, // Align to the right
          child: Text(
            'created on: ${create ?? '-'}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 5), // Space between created on and edited at

        // Edited at
        Align(
          alignment: Alignment.centerRight, // Align to the right
          child: Text(
            'edited at: ${update ?? '-'}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
