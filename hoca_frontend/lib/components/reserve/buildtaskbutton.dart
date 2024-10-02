  // Widget for the Task Buttons
  import 'package:flutter/material.dart';

Widget buildTaskButton(String taskName) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,  // Use backgroundColor instead of primary
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(taskName),
    );
  }