import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class GenderDropdown extends StatefulWidget {
  final String? gender;
  final Function(String?) onChanged;

  const GenderDropdown({
    super.key,
    required this.gender,
    required this.onChanged,
  });

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.gender;
  }

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
              value: _selectedGender?.isNotEmpty == true ? _selectedGender : null,
              items: [
                DropdownMenuItem(
                  value: '',
                  child: Text(
                    '',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
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
              ],
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
                widget.onChanged(value);
              },
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