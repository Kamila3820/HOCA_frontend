import 'package:flutter/material.dart';

class NameRating extends StatelessWidget {
  const NameRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Artiwara Kongmalai',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '(5 times)',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ],
    );
  }
}