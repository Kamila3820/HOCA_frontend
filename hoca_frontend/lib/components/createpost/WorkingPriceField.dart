import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class WorkingPriceField extends StatelessWidget {
  final TextEditingController controller; // Add the controller

  const WorkingPriceField({
    super.key,
    required this.controller, // Make it required
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRequiredLabel('Working Price'),
        const SizedBox(height: 8.0),
        Center(
          child: SizedBox(
            width: 150,
            child: TextFormField(
              controller: controller, // Use the controller
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
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
                  return 'Enter worker price';
                }
                if (int.tryParse(value) == null) {
                  return 'Enter a valid number';
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
