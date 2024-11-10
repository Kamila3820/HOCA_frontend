import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/models/inquirypayment.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentServiceFeePage extends StatefulWidget {
  final String postID;

  const PaymentServiceFeePage({super.key, required this.postID});

  @override
  _PaymentServiceFeePageState createState() => _PaymentServiceFeePageState();
}

class _PaymentServiceFeePageState extends State<PaymentServiceFeePage> {
  String? qrImageBase64; // To store the base64 image data
  int? orderCount;
  int? amount;
  String? startFrom;
  String? endFrom;
  String? endedAt;
  Timer? _timer;


  @override
  void initState() {
    super.initState();
    _initializePaymentProcess(widget.postID);
  }

  Future<void> _initializePaymentProcess(String postID) async {
  String? transactionId = await _fetchQRPayment(postID);
  if (transactionId != null) {
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
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      checkPaymentStatus(transactionId);
    });
  }

  Future<String?> _fetchQRPayment(String orderID) async {
  try {
    final response = await callQRpayment(orderID);
    if (response != null && response['transactionId'] != null) {
      setState(() {
        qrImageBase64 = response['qrImageBase64']; // Set QR code data if applicable
      });
      orderCount = response['order_count'];
      amount = response['amount'];
      startFrom = response['start_from'];
      endFrom = response['end_from'];
      endedAt = response['ended_at'];
      return response['transactionId']; // Return the transaction ID
    }
  } catch (e) {
    print('Error fetching QR payment: $e');
  }
  return null;
}


  Future<Map<String, dynamic>?> callQRpayment(String postID) async {
    String url = "/v1/order/worker/fee/$postID";
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
          'order_count': response.data['order_count'],
          'amount': response.data['amount'],
          'start_from': response.data['start_from'],
          'end_from': response.data['end_from'],
          'ended_at': response.data['ended_at'],
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
    String url = "/v1/order/payment/fee"; // Adjust the endpoint accordingly
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
              
              // Optionally, navigate to another page
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF87C4FF).withOpacity(0.6), // 60% opacity
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        'Service Fee Payment',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 25,
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Fee Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service Fee Details',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Amount: \$${amount}',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'This fee details:',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildFeatureItem('Period: ${startFrom?.replaceAll("-", "/") ?? "N/A"} - ${endFrom?.replaceAll("-", "/") ?? "N/A"}'),
_buildFeatureItem('Cash order amount: ${orderCount ?? "N/A"} '),
_buildFeatureItem('A fee collected to pay for services \nrelated to the order by cash'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Payment Methods Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        
                          // QR Code Image

                        if (qrImageBase64 != null && qrImageBase64!.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image.asset(
                              'assets/images/promptpay.png',
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 10),
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
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'This QR Code can use only 1 time',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Text(
                            'Please confirm the order before: ${endedAt!.replaceAll("-", "/") ?? "N/A"}',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ] else ... [
                          Container(
                            height: 300,
                            alignment: Alignment.center,
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
                            child: Text(
                              'No Overdue balance Available',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          ]
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
    );
  }

  void _showPaymentConfirmationDialog() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Column(
            children: [
              const Icon(Icons.payment, color: Color(0xFF87C4FF), size: 50),
              const SizedBox(height: 10),
              Text(
                'Confirm Payment',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Amount: ',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: '\$${amount}',
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 8),
    RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Payment Method: ',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'PromptPay',
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  ],
),

          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Colors.red,
                ),
                
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF87C4FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Confirm',
                style: GoogleFonts.poppins(
                   color: Colors.white,
                   fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Payment successful!',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                // Return to previous screen
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
