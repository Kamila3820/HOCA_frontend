import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final GlobalKey _tooltipKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.gender;
  }

  void _showTooltip() {
    final dynamic tooltip = _tooltipKey.currentState;
    tooltip?.ensureTooltipVisible();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            buildRequiredLabel('Gender'),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _showTooltip,
              child: Tooltip(
                key: _tooltipKey,
                message: "Select your gender preference", // Customize this message
                preferBelow: false,
                verticalOffset: -5,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(16),
                triggerMode: TooltipTriggerMode.manual,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                textStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(192, 0, 0, 0),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: MouseRegion(
                  cursor: SystemMouseCursors.help,
                  child: FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    size: 17,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
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