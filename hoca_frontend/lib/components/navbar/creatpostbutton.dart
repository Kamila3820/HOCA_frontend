import 'package:flutter/material.dart';
import 'package:hoca_frontend/pages/mngPost.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomFloatingActionButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Only show FAB when keyboard is not visible
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    
    if (isKeyboardVisible) {
      return const SizedBox.shrink(); // Hide when keyboard is visible
    }

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
              MaterialPageRoute(builder: (context) => ManagePostPage()),
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