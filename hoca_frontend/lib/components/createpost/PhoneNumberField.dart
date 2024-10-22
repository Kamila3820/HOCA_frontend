import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoca_frontend/components/createpost/String.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller; // Add controller parameter

  const PhoneNumberField({
    super.key,
    required this.controller, // Make controller required
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRequiredLabel('Phone Number'),
        const SizedBox(height: 8.0),
        Center(
          child: SizedBox(
            width: 150,
            child: TextFormField(
              controller: controller, // Use the controller
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
