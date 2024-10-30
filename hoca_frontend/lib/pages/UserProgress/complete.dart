import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/userorder.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCompletionPage extends StatefulWidget {
  final String orderID;
  final String? latitude;
  final String? longitude;
  final String? address;

  const UserCompletionPage({super.key, required this.orderID, this.address, this.latitude, this.longitude});

  @override
  State<UserCompletionPage> createState() => _UserCompletionPageState();
}

class _UserCompletionPageState extends State<UserCompletionPage> {
  late Future<UserOrder?> orderFuture;

  @override
  void initState() {
    super.initState();
    orderFuture = fetchOrderById(widget.orderID);
  }

  Future<UserOrder?> fetchOrderById(String orderID) async {
  String url = "/v1/order/user/$orderID";
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
    if (response.statusCode == 200) {
      return UserOrder.fromJson(response.data);
    } else if (response.statusCode == 404 || response.statusCode == 500) {
      return null;
    } else {
      throw Exception('Failed to load post');
    } 
  } catch (error) {
    Caller.handle(context, error as DioError); 
    rethrow; 
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
    return Scaffold(
      body: FutureBuilder<UserOrder?>(
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

              if (order.status == "complete" || order.status == "cancelled") {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProgressPage()), 
                  );
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProgressPage()), 
                  );
                });
                return const Center(child: CircularProgressIndicator()); // Show loading indicator until navigation
              }

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.workerName!,
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
                      ],
                    ),
                  ],
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
