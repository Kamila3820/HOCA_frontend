import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        "I'm available to do the task jobs listed below. Now I'm staying in Thung Khru, BKK:\n- Mop the floor\n- Wash dishes\n- Iron clothes",
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}