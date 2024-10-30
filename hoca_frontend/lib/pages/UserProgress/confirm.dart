import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/userorder.dart';
import 'package:hoca_frontend/pages/UserProgress/cancel.dart';
import 'package:hoca_frontend/pages/UserProgress/preparing.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProgressPage extends StatefulWidget {
  final String orderID;
   final String? latitude;
  final String? longitude;
  final String? address;


  const UserProgressPage({super.key, required this.orderID,
  this.latitude,
    this.longitude,
    this.address,});

  @override
  State<UserProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<UserProgressPage> with SingleTickerProviderStateMixin {
  late Future<UserOrder?> orderFuture;
  late AnimationController _animationController;

  Future<Map<String, String>> _getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'latitude': prefs.getString('latitude') ?? '',
      'longitude': prefs.getString('longitude') ?? '',
      'address': prefs.getString('address') ?? '',
    };
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

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

  void handleNavigation(UserOrder? order) {
    if (order == null || order.status == "complete" || order.status == "cancelled") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProgressPage()),
      );
    } else if (order.status == "preparing") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserArrivalPage(orderID: widget.orderID)),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

              WidgetsBinding.instance.addPostFrameCallback((_) {
                handleNavigation(order);
              });

              return Column(
        children: [
          // Header container with the title
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0),
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
                    ),
                  ),
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
                _buildProgressStep('Confirm', isActive: true, isCompleted: true),
                _buildProgressStep('Preparing', isActive: false, isCompleted: false),
                _buildProgressStep('Working', isActive: false, isCompleted: false),
                _buildProgressStep('Complete', isActive: false, isCompleted: false),
              ],
            ),
          ),

          // Worker Details Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Worker info row
                Row(
                  children: [
                    // Worker image
                    const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                    const SizedBox(width: 15),
                    // Worker details
                    Expanded(
                      child: Column(
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
                              const Icon(Icons.access_time, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Waiting for houseworker to confirm',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Payment info
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Amount',
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey,
      ),
    ),
    RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${order.price!} THB',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.green, // Make "800 THB" green
            ),
          ),
          TextSpan(
            text: ' - '+order.payment!,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black, // Keep the default color for "- QR Payment"
            ),
          ),
        ],
      ),
    ),
  ],
),

              ],
            ),
          ),
const SizedBox(height: 30),
          // Finding worker section
         Expanded(
  child: Container(
    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 150), // Adds a margin to the bottom
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 10,
          offset: const Offset(0, 3), // Changes position of shadow
        ),
      ],
      borderRadius: BorderRadius.circular(10), // Rounded corners for the box
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        // Searching animation
        SizedBox(
          width: 80,
          height: 80,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animationController.value * 2 * math.pi,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 3,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: const Icon(
                      Icons.access_time,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Waiting for the houseworker to confirm...',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please wait while the worker reviews and confirms within 7 minutes,\n'
          'You will be notified once the confirmation is complete.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 60),
        // Cancel button
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5, // 80% of the screen width
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                                context: context,
                                builder: (BuildContext context) => UserCancelOrderDialog(orderID: order.id.toString(),),
                              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'CANCEL',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      ],
    ),
  ),
),

        ],
      );
            }
        },
      ),
    );
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
}