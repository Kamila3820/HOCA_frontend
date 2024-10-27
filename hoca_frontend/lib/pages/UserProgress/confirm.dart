import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/pages/UserProgress/cancel.dart';

class UserProgressPage extends StatefulWidget {
  const UserProgressPage({super.key});

  @override
  State<UserProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<UserProgressPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                            'Artiwara Kongmalai',
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
            text: '800 THB',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.green, // Make "800 THB" green
            ),
          ),
          TextSpan(
            text: ' - QR Payment',
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
        // Distance indicator
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.grey),
            Expanded(
              child: Container(
                height: 2,
                color: Colors.grey.shade300,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '15 km',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
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
          'Finding your worker...',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'On it! We will find as soon as possible',
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
                          builder: (BuildContext context) => const UserCancelOrderDialog(),
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