import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/workerorder.dart';
import 'package:hoca_frontend/pages/WorkerProgress/cancel.dart';
import 'package:hoca_frontend/pages/WorkerProgress/preparing.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerProgressPage extends StatefulWidget {
  final String orderID;

  final String? latitude;
  final String? longitude;
  final String? address;

  const WorkerProgressPage({
    super.key, required this.orderID,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  State<WorkerProgressPage> createState() => _WorkerProgressPageState();
}

class _WorkerProgressPageState extends State<WorkerProgressPage> {
  late Future<WorkerOrder?> orderFuture;

  @override
  void initState() {
    super.initState();

    orderFuture = fetchWorkerOrder(widget.orderID);
  }

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

void callConfirmOrder(String orderID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      await Caller.dio.patch("/v1/order/update/$orderID", 
      data: {
        "status": "preparing"
      }, 
      options: Options(
        headers: {
          'x-auth-token': '$token', 
        },
      ),);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorkerArrivalPage(orderID: orderID,)),
      );
    } on DioException catch (error) {
      // Handle error
      Caller.handle(context, error);
    }
  }

  void handleNavigation(WorkerOrder? order) {
    if (order == null || order.status == "complete" || order.status == "cancelled") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProgressPage()),
      );
    } else if (order.status == "preparing") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorkerArrivalPage(orderID: order.id.toString(),)),
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
            // Progress steps at the top
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
            // Worker Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      order.userAvatar != null && order.userAvatar!.isNotEmpty
        ? CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(order.userAvatar!),
            backgroundColor: Colors.transparent, // Optional
          )
        : const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
                      const SizedBox(width: 12),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 16,
                                      color: Color(0xFF90D26D),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      order.contactPhone!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Time: ${order.createdAt?.replaceAll("-", "/")}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Client ',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'needs your help',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.location_pin, size: 20, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Look like ${order.contactName} needs your help...',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 240,
              width: 320,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Details',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Location :',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    order.location!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Specific Place :',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    order.specPlace ?? "-",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Note from a customer :',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    order.note ?? '-',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => WorkerCancelOrderDialog(orderID: widget.orderID,),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red[400],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'CANCEL',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
  onPressed: () {
    showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.check_circle_outline, // Choose an appropriate icon
            color: const Color(0xFF87C4FF), // Icon color
          ),
          const SizedBox(width: 8), // Add some spacing between icon and text
          Text(
            'Confirm Arrival',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to confirm your arrival?',
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.black54
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFE12525),
            backgroundColor: Colors.white, // "No" button color
          ),
          child: Text(
            'No',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            callConfirmOrder(order.id.toString());
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF87C4FF), // "Yes" button color
          ),
          child: Text(
            'Yes',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
      ],
    );
  },
);

  },
  style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF90D26D),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'CONFIRM',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Timer Display
           Container(
  margin: const EdgeInsets.only(top: 1),
  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
  child: Text(
    'Please confirm the order before: ${order.endedAt?.replaceAll("-", "/")}',
    style: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(252, 237, 90, 90),
    ),
  ),
)

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
