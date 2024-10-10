import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpost/String.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Describe',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Center(
          child: SizedBox(
            width: 320,
            child: TextFormField(
              onSaved: (value) => description = value,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              style: const TextStyle(
                color: Color(0xFFA9A8A8),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 3,
            ),
          ),
        ),
      ],
    );
  }
}