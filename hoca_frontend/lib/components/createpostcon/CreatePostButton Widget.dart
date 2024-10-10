import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/main.dart';

class CreatePostButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<int> selectedBoxIndices;
  final VoidCallback onPressed;

  const CreatePostButton({super.key, 
    required this.formKey,
    required this.selectedBoxIndices,
    required this.onPressed,
  });

  void _showTopNotification(BuildContext context, String message, Color backgroundColor) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 650,
      left: 20,
      right: 20,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate() && selectedBoxIndices.isNotEmpty) {
            // Show success notification at the top
            _showTopNotification(context, 'Post created successfully!', Colors.green);
            
            // Navigate back to MainScreen
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreen()),
              (Route<dynamic> route) => false,
            );
          } else if (selectedBoxIndices.isEmpty) {
            // Show error notification at the top
            _showTopNotification(
              context,
              'Please select at least one type of place to work',
              Colors.red,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF87C4FF),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Create Post',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}