import 'package:flutter/material.dart';
import 'package:hoca_frontend/pages/createpost/createpost.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key, required Null Function() onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20), // Adjust the value to move it lower
      child: Container(
        width: 70, // Set the desired width
        height: 70, // Set the desired height
        decoration: const BoxDecoration(
          color: Colors.transparent, // Set container background to transparent
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  CreatePostPage()),
            );
          },
          backgroundColor: const Color(0xFF7E869E).withOpacity(0.5),
          shape: const CircleBorder(), // Keep the round shape
          elevation: 0,
          child: const Icon(Icons.add,
              size: 50, color: Color.fromARGB(147, 13, 13, 13)),
        ),
      ),
    );
  }
}