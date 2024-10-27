import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class WorkerNameField extends StatelessWidget {
  final TextEditingController controller; // Add the controller

  const WorkerNameField({
    super.key,
    required this.controller, // Make it required
  });

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
              controller: controller, // Use the passed controller
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
