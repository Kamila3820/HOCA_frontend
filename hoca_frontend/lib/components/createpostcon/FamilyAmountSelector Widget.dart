import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FamilyAmountSelector extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String? selectedFamilyAmount;
  final Function(String?) onFamilyAmountChanged;

  const FamilyAmountSelector({
    required this.formKey,
    required this.selectedFamilyAmount,
    required this.onFamilyAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 520,
      left: 20,
      right: 20,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select the acceptable amount of family to work',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 250,
                child: DropdownButtonFormField<String>(
                  value: selectedFamilyAmount,
                  items: [
                    DropdownMenuItem(
                      value: '1-2 Members',
                      child: Text(
                        '1-2 Members',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: '3-4 Members',
                      child: Text(
                        '3-4 Members',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: '5+ Members',
                      child: Text(
                        '5+ Members',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                  onChanged: onFamilyAmountChanged,
                  decoration: InputDecoration(
                    hintText: "Select amount of family",
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
                      return 'Please select an amount';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'It will relate to the amount of work',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}