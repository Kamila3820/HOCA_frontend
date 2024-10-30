import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/pages/WorkerProgress/cancel.dart';
import 'package:hoca_frontend/pages/WorkerProgress/preparing.dart';

class WorkerProgressPage extends StatefulWidget {
  final String orderID;

  const WorkerProgressPage({super.key, required this.orderID});

  @override
  State<WorkerProgressPage> createState() => _WorkerProgressPageState();
}

class _WorkerProgressPageState extends State<WorkerProgressPage> {
  Timer? _timer;
  int _remainingSeconds = 7 * 60; // 7 minutes in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String get timerDisplay {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
                  // Worker Profile Section
                  Row(
                    children: [
                      const CircleAvatar(
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
                              'Jintara Maliwan',
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
                                      '098-765-4321',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Time: 7 MAR 2024 19.03',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 0, 0, 0),
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
                          text: 'need your help',
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
                        'Look like someone need your help...',
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
                    '679/210 Prachauthit 45 Thung Khru , Bangkok',
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
                    'Condominium floor 4 room23',
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
                    '-',
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
                          builder: (BuildContext context) => const WorkerArrivalPage(),
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                timerDisplay,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: _remainingSeconds <= 30 ? Colors.red : Colors.blue,
                ),
              ),
            ),
          ],
        ),
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