import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerCancelOrderDialog extends StatefulWidget {
  final String orderID;

  final String? latitude;
  final String? longitude;
  final String? address;

  const WorkerCancelOrderDialog({
    super.key, required this.orderID,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  State<WorkerCancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<WorkerCancelOrderDialog> {
  String? selectedReason;
   bool isLoading = false;

  void cancelOrderByUser() async {
    setState(() {
      isLoading = true; // Show loading indicator while the request is being processed
    });

    String orderID = widget.orderID;
    String cancelBy = "worker"; 
    String url = "/v1/order/cancel/$orderID?cancelBy=$cancelBy";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await Caller.dio.patch(
        url,
        data: {
          "cancellation_reason": selectedReason,
        },
        options: Options(
          headers: {
            'x-auth-token': token,
          },
        ),
      );
      
      if (response.statusCode == 200) {
        // Show a success message and navigate back to the main screen
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Your order has been canceled.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  ); // Navigate to the main screen
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Handle error, show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to cancel the order. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator once the request completes
      });
    }
  }

  Future<Map<String, String>> _getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'latitude': prefs.getString('latitude') ?? '',
      'longitude': prefs.getString('longitude') ?? '',
      'address': prefs.getString('address') ?? '',
    };
  }

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
                    : () async {
                        // Get saved location data
                        final locationData = await _getSavedLocation();
                        print('Selected reason: $selectedReason');
                        // Navigate to MainScreen with location data
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              latitude: locationData['latitude'],
                              longitude: locationData['longitude'],
                              address: locationData['address'],
                            ),
                          ),
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
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
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
