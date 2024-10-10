import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpost/String.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class WorkerNameField extends StatelessWidget {
  const WorkerNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRequiredLabel('Worker Name'),
        const SizedBox(height: 8.0),
        Center(
          child: SizedBox(
            width: 340,
            child: TextFormField(
              onSaved: (value) => workerName = value,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a worker name';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}