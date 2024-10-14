import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldSection extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller; // Added controller

  const TextFormFieldSection({
    Key? key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.controller, // Accept the controller as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFF7A7777),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller, // Set the controller for the TextFormField
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFFB3B1B1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFB3B1B1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF87C4FF)),
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
