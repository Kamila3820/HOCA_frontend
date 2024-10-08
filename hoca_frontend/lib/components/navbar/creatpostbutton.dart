import 'package:flutter/material.dart';
import 'package:hoca_frontend/pages/createpost/createpost.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomFloatingActionButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: FloatingActionButton(
          onPressed: onPressed ?? () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatePostPage()),
            );
          },
          backgroundColor: const Color(0xFF7E869E).withOpacity(0.5),
          shape: const CircleBorder(),
          elevation: 0,
          child: const Icon(Icons.add,
              size: 50, color: Color.fromARGB(147, 13, 13, 13)),
        ),
      ),
    );
  }
}