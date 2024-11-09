import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/models/userorder.dart';
import 'package:hoca_frontend/models/workerorder.dart';
import 'package:hoca_frontend/pages/UserProgress/confirm.dart';
import 'package:hoca_frontend/pages/UserProgress/payment.dart';
import 'package:hoca_frontend/pages/UserProgress/paymentsucces.dart';
import 'package:hoca_frontend/pages/UserProgress/preparing.dart';
import 'package:hoca_frontend/pages/WorkerProgress/comfirm.dart';
import 'package:hoca_frontend/pages/WorkerProgress/preparing.dart';
import 'package:hoca_frontend/pages/WorkerProgress/working.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {

  @override
  void initState() {
    super.initState();
    _checkActiveOrders();
  }

  Future<void> _checkActiveOrders() async {
    UserOrder? customerOrder = await fetchCustomerOrder();
    WorkerOrder? workerOrder = await fetchWorkerOrder();

    if (customerOrder != null) {
      switch (customerOrder.status) {
      case 'confirmation':
        Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.rightToLeft, // Choose the transition type
    child: UserProgressPage(orderID: customerOrder.id.toString()),
    duration: Duration(milliseconds: 300), // Optional: set duration
    reverseDuration: Duration(milliseconds: 300), // Optional: set reverse duration
  ),
);

        break;
      case 'preparing':
        Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.rightToLeft, // Customize the transition type as desired
    child: UserArrivalPage(orderID: customerOrder.id.toString()),
    duration: Duration(milliseconds: 400), // Optional: customize transition speed
    reverseDuration: Duration(milliseconds: 400), // Optional: customize reverse transition
  ),
);

        break;
      case 'working':
        if (customerOrder.paid == true) {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserPaymentPage(orderID: customerOrder.id.toString()),
            ),
          );
        } else if (customerOrder.paid == false) {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSuccessPage(orderID: customerOrder.id.toString()),
            ),
          );
        }
        break;
      default:
        break;
    }
    return;
    }

    if (workerOrder != null) {
      // Route based on the order status
    switch (workerOrder.status) {
      case 'confirmation':
        Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.rightToLeft, // Choose the desired transition type
    alignment: Alignment.bottomCenter, // Optional: set the origin point for scaling
    child: WorkerProgressPage(orderID: workerOrder.id.toString()),
    duration: Duration(milliseconds: 300), // Optional: adjust duration
    reverseDuration: Duration(milliseconds: 300), // Optional: adjust reverse duration
  ),
);

        break;
      case 'preparing':
        Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.rightToLeft, // Choose your preferred transition type
    child: WorkerArrivalPage(orderID: workerOrder.id.toString()),
    duration: Duration(milliseconds: 300), // Optional: transition duration
    reverseDuration: Duration(milliseconds: 300), // Optional: reverse transition duration
  ),
);

        break;
      case 'working':
        Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.rightToLeft, // Choose the transition type (fade, scale, etc.)
    child: WorkerdonePage(orderID: workerOrder.id.toString()),
    duration: Duration(milliseconds: 300), // Set transition duration
    reverseDuration: Duration(milliseconds: 300), // Set reverse transition duration
  ),
);

        break;
      default:
        break;
    }
    return;
    }
  }
  
  Future<UserOrder?> fetchCustomerOrder() async {
  String url = "/v1/order/active";
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

    return UserOrder.fromJson(response.data); // Continue with parsing if data exists
  } catch (e) {
    debugPrint('Error fetching customer order: $e');
    return null;
  }
}


Future<WorkerOrder?> fetchWorkerOrder() async {
  String url = "/v1/order/worker/active";
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header container with the title
          Container(
            height: 120.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF87C4FF).withOpacity(0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20,left: 20, right: 10),
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
                
              ],
            ),
          ),
          // Add additional content below the progress steps
          Expanded(
            child: Center(
              child: Text(
                'Your order will be show here soon..',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(String label, {required bool isActive, required bool isCompleted}) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 4,
          color: isCompleted ? Colors.blue : (isActive ? Colors.blue : const Color.fromARGB(255, 255, 255, 255)),
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