import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpost/String.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;

  const PhoneNumberField({
    super.key,
    required this.controller,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final GlobalKey _tooltipKey = GlobalKey();

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
            buildRequiredLabel('Phone Number'),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _showTooltip,
              child: Tooltip(
                key: _tooltipKey,
                message: "Enter your 10-digit phone number", // Customize this message
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
            child: TextFormField(
              controller: widget.controller,
              onSaved: (value) => phoneNumber = value,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
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
                  return 'Enter Phone Number';
                }
                if (value.length < 10) {
                  return 'Enter 10 digits';
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