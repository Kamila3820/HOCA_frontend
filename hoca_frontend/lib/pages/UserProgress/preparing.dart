import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/prepareorder.dart';
import 'package:hoca_frontend/pages/UserProgress/payment.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserArrivalPage extends StatefulWidget {
  final String orderID;

  const UserArrivalPage({super.key, required this.orderID});

  @override
  State<UserArrivalPage> createState() => _UserArrivalPageState();
}

class _UserArrivalPageState extends State<UserArrivalPage> {
  late Future<PrepareOrder?> orderFuture;

  @override
  void initState() {
    super.initState();
    orderFuture = fetchOrder(widget.orderID);
  }

  Future<PrepareOrder?> fetchOrder(String orderID) async {
    String orderID = widget.orderID;
    String url = "/v1/order/prepare/$orderID";
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
        return PrepareOrder.fromJson(response.data);
      } else if (response.statusCode == 404 || response.statusCode == 500) {
        return null;
      } else {
        throw Exception('Failed to load order');
      } 
    } catch (error) {
      Caller.handle(context, error as DioError); 
      rethrow; 
    }
  }

  void handleNavigation(PrepareOrder? order) {
    if (order == null || order.orderStatus == "complete" || order.orderStatus == "cancelled") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProgressPage()),
      );
    } else if (order.orderStatus == "working") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserPaymentPage(orderID: widget.orderID)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PrepareOrder?>(
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


              return  Column(
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
                        onPressed: () {
                          showDialog(
                                      context: context,
                                      builder: (BuildContext context) => const MainScreen(),
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
                  _buildProgressStep('Confirm', isActive: false, isCompleted: false),
                  _buildProgressStep('Preparing', isActive: true, isCompleted: false),
                  _buildProgressStep('Working', isActive: false, isCompleted: false),
               
                ],
              ),
            ),

            // Worker Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
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
                  // Worker Profile Section
                  Row(
                    children: [
                      // Worker Image
                      order.workerAvatar != null && order.workerAvatar!.isNotEmpty
        ? CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(order.workerAvatar!),
            backgroundColor: Colors.transparent, // Optional
          )
        : const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
                      const SizedBox(width: 12),
                      // Worker Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.workerName,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.directions_walk,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Arriving to the destination',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Amount Section
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
            text: '${order.price} THB',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.green, // Make "800 THB" green
            ),
          ),
          TextSpan(
            text: ' - ${order.paymentType}',
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
                  const SizedBox(height: 16),
                  // Worker Status Section
                  Text(
                    'Worker on the way!',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Progress Bar
                  // Progress Bar with Icons
Row(
  children: [
    // Human Icon at the start
    const Icon(Icons.person, size: 20, color: Color.fromARGB(255, 0, 0, 0)), // Adjust the size and color as needed

    const SizedBox(width: 8), // Space between icon and progress bar

    Expanded(
      child: Stack(
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            height: 4,
            width: MediaQuery.of(context).size.width * 0.5, // 50% progress
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    ),

    const SizedBox(width: 8), // Space between progress bar and icon

    // Pin Icon at the end
    const Icon(Icons.location_pin, size: 20, color: Color.fromARGB(255, 0, 0, 0)), // Adjust the size and color as needed
  ],
),

                  const SizedBox(height: 8),
                  // Time and Worker Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Phone Number: ',
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.bold, // Make "Worker" text bold
          color: Color(0xFF87C4FF), // Apply the color
        ),
      ),
      TextSpan(
        text: order.workerPhone,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: Color(0xFF87C4FF), // Color for the rest of the text
        ),
      ),
    ],
  ),
),

                      Text(
                        order.distance!.first.legs!.first.duration!.text!,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
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
            // Map Icon and Message
Expanded(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start, // Align children at the start (top)
    children: [
      Image.asset(
        'assets/images/userload.png',
      
        height: 180, // Set height as needed
      ),
      const SizedBox(height: 20),
      Text(
        'Please wait a moment, Worker on the way!',
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 20), // Optional space below the text
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
          width: 100,
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
