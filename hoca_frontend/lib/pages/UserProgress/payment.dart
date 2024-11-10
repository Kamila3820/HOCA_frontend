import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/inquirypayment.dart';
import 'package:hoca_frontend/models/userorder.dart';
import 'package:hoca_frontend/pages/UserProgress/paymentsucces.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPaymentPage extends StatefulWidget {
  final String orderID;
  final String? latitude;
  final String? longitude;
  final String? address;

  const UserPaymentPage({
    super.key,
    required this.orderID,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  State<UserPaymentPage> createState() => _UserPaymentPageState();
}

class _UserPaymentPageState extends State<UserPaymentPage> {
  late Future<UserOrder?> orderFuture;
  String? qrImageBase64; // To store the base64 image data
  Timer? _timer;

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
    orderFuture = fetchOrderById(widget.orderID);
    _initializePaymentProcess(widget.orderID);
}

  Future<void> _initializePaymentProcess(String orderID) async {
  print('Initializing payment process for order ID: $orderID'); // Debug
  String? transactionId = await _fetchQRPayment(orderID);
  if (transactionId != null) {
    print('Transaction ID obtained: $transactionId'); // Debug
    _startPollingPaymentStatus(transactionId);
  } else {
    print('Transaction ID not available');
  }
}

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startPollingPaymentStatus(String transactionId) {
  _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
    print('Checking payment status for transaction ID: $transactionId'); // Debug
    await checkPaymentStatus(transactionId);
  });
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

  Future<String?> _fetchQRPayment(String orderID) async {
  try {
    final response = await callQRpayment(orderID);
    if (response != null && response['transactionId'] != null) {
      setState(() {
        qrImageBase64 = response['qrImageBase64']; // Set QR code data if applicable
        print("testttt");
        print(qrImageBase64);

      });
      return response['transactionId']; // Return the transaction ID
    }
  } catch (e) {
    print('Error fetching QR payment: $e');
  }
  return null;
}


  Future<Map<String, dynamic>?> callQRpayment(String orderID) async {
  String url = "/v1/order/payment/qr/$orderID";
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  try {
    final response = await Caller.dio.post(
      url,
      options: Options(
        headers: {
          'x-auth-token': '$token',
        },
      ),
    );

    if (response.statusCode == 201) {
      // Assuming the response data includes 'transactionId' and 'qrImageBase64'
      return {
        'transactionId': response.data['transactionId'],
        'qrImageBase64': response.data['qrRawData'],
      };
    } else {
      print('Failed to get QR payment');
    }
  } catch (error) {
    Caller.handle(context, error as DioError);
    print('Error in callQRpayment: $error');
  }
  return null;
}



  Future<void> checkPaymentStatus(String transactionId) async {
    String url = "/v1/order/payment/inquiry"; // Adjust the endpoint accordingly
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await Caller.dio.get(
        url,
        data: {
          "transactionId": transactionId,
        },
        options: Options(
          headers: {
            'x-auth-token': '$token', // Add token to header
          },
        ),
      );

      if (response.statusCode == 200) {
        final inquiry = InquiryPayment.fromJson(response.data);
        // Handle the response data (e.g., payment status, transaction details)
        print("Payment status: ${inquiry.paymentSuccess}");
        if (inquiry.paymentSuccess == true) {
          _timer?.cancel();
          // If payment is successful, handle the success scenario
          showPaymentSuccess();
        }
      } else {
        print('Failed to check payment status');
      }
    } catch (error) {
      Caller.handle(context, error as DioError);
      print('Error in checkPaymentStatus: $error');
    }
  }

  void showPaymentSuccess() {
    // Display a success message or navigate to a success page
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Success'),
        content: Text('The payment has been confirmed.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PaymentSuccessPage(orderID: widget.orderID,)),
          );
              // Optionally, navigate to another page
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  } 

  void handleNavigation(UserOrder? order) {
    if (order == null ||
        order.status == "complete" ||
        order.status == "cancelled") {
      _getSavedLocation().then((locationData) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: MainScreen(
              latitude: locationData['latitude'],
              longitude: locationData['longitude'],
              address: locationData['address'],
            ),
          ),
        );
      });
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

              return Column(
        children: [
          // New Header Container
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

          // Customer Info
          Container(
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
                        const Icon(Icons.cleaning_services, size: 16, color: Color.fromARGB(255, 0, 0, 0)),
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
                    Text(
                      'Order ID: ${order.id}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
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

          const SizedBox(height: 10),

          if (order.payment == 'qrcode' && qrImageBase64 != null && qrImageBase64!.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 4,
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: QrImageView(
                data: qrImageBase64!, // The text to encode
                size: 300.0, // Size of the QR code
              ),
            )
          else
            Icon(
              Icons.monetization_on,
              size: 100,
              color: Colors.green,
            ),


          const SizedBox(height: 10),

          Text(
            'Total: ${order.price} THB',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          if (order.payment == 'qrcode')
            Column(
              children: [
                Text(
                  'This QR Code can be used only 1 time',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Please pay within 30 minutes',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
