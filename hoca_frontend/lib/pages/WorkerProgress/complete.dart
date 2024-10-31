import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/workerorder.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerCompletionPage extends StatefulWidget {
  final String orderID;

  final String? latitude;
  final String? longitude;
  final String? address;

  const WorkerCompletionPage({
    super.key, required this.orderID,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  State<WorkerCompletionPage> createState() => _WorkerCompletionPageState();
}

class _WorkerCompletionPageState extends State<WorkerCompletionPage> {
  late Future<WorkerOrder?> orderFuture;

  Future<Map<String, String>> _getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'latitude': prefs.getString('latitude') ?? '',
      'longitude': prefs.getString('longitude') ?? '',
      'address': prefs.getString('address') ?? '',
    };
  }

  Future<WorkerOrder?> fetchWorkerOrder(String orderID) async {
  String url = "/v1/order/worker/$orderID";
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  try {
    final response = await Caller.dio.get(
      url,
      options: Options(
        headers: {
          'x-auth-token': '$token', // Add token to header
        },
      ),
    );

    // Check if the response data is null and handle it
    if (response.data == null) {
      return null; // Return null if no active order is found
    }

    return WorkerOrder.fromJson(response.data); // Continue with parsing if data exists
  } catch (e) {
    debugPrint('Error fetching worker order: $e');
    return null;
  }
}

void handleNavigation(WorkerOrder? order) {
    if (order?.status == "cancelled") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProgressPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<WorkerOrder?>(
        future: orderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProgressPage()),
                );
              });
              return const Center(child: CircularProgressIndicator()); 
          } else if (!snapshot.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProgressPage()),
                );
              });
              return const Center(child: CircularProgressIndicator()); // Show a loading indicator until the page is replaced
            } else {
              final order = snapshot.data!;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                handleNavigation(order);
              });

               return Column(
        children: [
          // Header with customer info and completion status
          Container(
            height: 120.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF87C4FF).withOpacity(0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'Progress',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Progress steps
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            color: const Color(0xFF87C4FF).withOpacity(0.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProgressStep('Confirm', isActive: false, isCompleted: false),
                _buildProgressStep('Preparing', isActive: false, isCompleted: false),
                _buildProgressStep('Working', isActive: false, isCompleted: false),
                _buildProgressStep('Complete', isActive: true, isCompleted: true),
              ],
            ),
          ),

Container(
  padding: const EdgeInsets.all(20),
  child: Row(
    children: [
      const CircleAvatar(
        radius: 28,
        backgroundColor: Colors.grey,
        child: Icon(Icons.person, color: Colors.white, size: 30),
      ),
      const SizedBox(width: 15),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.contactName!,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Completed!',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(), // Add space between the completed text and the time
                Text(
                  'Time: 7 MAR 2024 19:03',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey, // You can change the color as needed
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4), // Space between completed text and payment text
            Align(
              alignment: Alignment.centerRight, // Align the payment text to the right
              child: Text(
                'Payment Successful',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.green, // You can change the color as needed
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),


                 const Divider(
  thickness: 1,
  color: Colors.grey, // Adjust the color if needed
  indent: 20, // Align with the customer info padding
  endIndent: 20, // Align with the customer info padding
),

        Expanded(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      // Your HOCA Logo image
      SizedBox(
        width: 300,
        height: 300,
        child: ClipOval(
          child: Image.asset(
            'assets/images/hoca-logo.png', // Make sure to update this path to match your asset location
            fit: BoxFit.contain,
          ),
        ),
      ),

      // All Done! text
      Text(
        'All Done!',
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Remove the SizedBox here to eliminate space
      // All Task Finished text
      Text(
        'All Task Finished',
        style: GoogleFonts.poppins(
          fontSize: 24,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),

      const SizedBox(height: 20), // You can adjust this spacing if needed

      // Done button
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120),
      child: ElevatedButton(
        onPressed: () async {
          // Get saved location data
          final locationData = await _getSavedLocation();
          
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
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          'DONE',
          style: GoogleFonts.poppins( 
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
    ],
  ),
),


        ],
               );
            }
        },
      ),
    );
  }

            }

  Widget _buildProgressStep(String label, {required bool isActive, required bool isCompleted}) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 4,
          color: isCompleted
              ? Colors.blue
              : (isActive ? Colors.blue : const Color.fromARGB(255, 255, 255, 255)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.blue : const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ],
    );
  }
