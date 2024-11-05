import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccessPage extends StatelessWidget {
  final String customerName;
  final String orderId;
  
  const PaymentSuccessPage({
    super.key, 
    this.customerName = "Artiwara Kongmalai",
    this.orderId = "ID344546",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF87C4FF).withOpacity(0.6),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 10, bottom: 20),
                  child: Text(
                    'Progress',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
                    _buildProgressStep('Complete', isActive: false, isCompleted: false),
                  ],
                ),
              ),

              // Customer info
              Padding(
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
                        crossAxisAlignment: CrossAxisAlignment.start, // Corrected property name
                        children: [
                          Text(
                            customerName,
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
                                'Order ID: $orderId',
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
      ),
    );
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
}
