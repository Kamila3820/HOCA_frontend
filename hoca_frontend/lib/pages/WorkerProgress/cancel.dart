import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/main.dart';

// Replace the existing CancelOrderDialog with this version
class WorkerCancelOrderDialog extends StatefulWidget {
  const WorkerCancelOrderDialog({super.key});

  @override
  State<WorkerCancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<WorkerCancelOrderDialog> {
  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cancel Order',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'I want to cancel the order due to...',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildCancelOption('Urgent Business'),
            _buildCancelOption('Bad Weather'),
            _buildCancelOption('Amount of work & Place to work'),
            _buildCancelOption('Other Problems'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedReason == null 
                    ? null  // Button is disabled when no reason is selected
                    : () {
                        // Handle send action
                        print('Selected reason: $selectedReason');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const MainScreen(),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF87C4FF),
                  disabledBackgroundColor: Colors.grey[300], // Color when button is disabled
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Send',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: selectedReason == null ? Colors.grey[600] : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelOption(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedReason == text ? const Color(0xFF87C4FF) : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile(
        title: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        value: text,
        groupValue: selectedReason,
        onChanged: (value) {
          setState(() {
            selectedReason = value as String;
          });
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        activeColor: const Color(0xFF87C4FF),
      ),
    );
  }
}