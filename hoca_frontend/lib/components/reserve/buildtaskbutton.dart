  // Widget for the Task Buttons
  import 'package:flutter/material.dart';

Widget buildTaskButton(String taskName) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF6E7DA),  // Use backgroundColor instead of primary
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(taskName),
    );
  }