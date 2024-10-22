import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class GenderDropdown extends StatefulWidget {
  final String? gender; // Add gender parameter
  final Function(String?) onChanged; // Add onChanged callback

  const GenderDropdown({
    super.key,
    required this.gender, // Make it required
    required this.onChanged, // Make it required
  });

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRequiredLabel('Gender'),
        const SizedBox(height: 8.0),
        Center(
          child: SizedBox(
            width: 150,
            child: DropdownButtonFormField<String>(
              value: widget.gender, // Use the gender from the parent
              items: [
                DropdownMenuItem(
                  value: 'Male',
                  child: Text(
                    'Male',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Female',
                  child: Text(
                    'Female',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text(
                    'Other',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ],
              onChanged: widget.onChanged, // Use the onChanged callback
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select a Gender';
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
