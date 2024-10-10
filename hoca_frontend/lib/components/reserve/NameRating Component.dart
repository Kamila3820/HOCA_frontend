import 'package:flutter/material.dart';

class NameRating extends StatelessWidget {
  final String? name;
  final int? taskCount;

  const NameRating({super.key, required this.name, required this.taskCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name!, // Use dynamic name
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '($taskCount times)', // Display dynamic task count
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ],
    );
  }
}
