import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/userorder.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentSuccessPage extends StatefulWidget {
  final String orderID;
  final String? latitude;
  final String? longitude;
  final String? address;

  const PaymentSuccessPage({super.key, required this.orderID,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
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

 void handleNavigation(UserOrder? order) async {
  if (order == null || order.status == "complete" || order.status == "cancelled") {
    final locationData = await _getSavedLocation();
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade, // Choose your preferred transition type
        child: MainScreen(
          latitude: locationData['latitude'],
          longitude: locationData['longitude'],
          address: locationData['address'],
        ),
      ),
    );
  }
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


              return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
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
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white, size: 40.0),
                                onPressed: () async {
                                  final locationData = await _getSavedLocation();
                                  Navigator.pushReplacement(
  context,
  PageTransition(
    type: PageTransitionType.fade, // Choose your preferred transition type
    child: MainScreen(
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

              // Progress Steps
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                color: const Color(0xFF87C4FF).withOpacity(0.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildProgressStep('Confirm', isActive: false, isCompleted: false),
                    _buildProgressStep('Preparing', isActive: false, isCompleted: false),
                    _buildProgressStep('Working', isActive: true, isCompleted: true),
                  ],
                ),
              ),

              // Customer info
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
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
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Corrected property name
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
                              const Icon(Icons.cleaning_services, size: 16, color: Colors.black),
                              const SizedBox(width: 5),
                              Text(
                                'Working time!',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Row( // Moved Order ID and Payment Successful to the same row
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order ID: ${widget.orderID}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Payment Successful',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(
                thickness: 1,
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
              ),

              // PromptPay Logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  'assets/images/promptpay.png',
                  height: 60,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),

              // Success Icon
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF90D26D),
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFF90D26D),
                    size: 150 ,
                  ),
                ),
              ),

              // Success Message
              // Success Message
Padding(
  padding: const EdgeInsets.only(top: 20),
  child: Center( // Center the text
    child: Text(
      'Payment Successful',
      style: GoogleFonts.poppins(
        fontSize: 25,
        color: Colors.green,
      ),
    ),
  ),
),

            ],
          ),
        ),
              );
            }
        },
      ),
    );
  }

            }
      

  Widget _buildProgressStep(String label, {required bool isActive, required bool isCompleted}) {
    return Expanded(
      child: Column(
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
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? Colors.blue : const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ],
      ),
    );
  }

