import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/pages/WorkerProgress/working.dart';

class WorkerArrivalPage extends StatelessWidget {
  const WorkerArrivalPage({super.key});

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
                  _buildProgressStep('Confirm',
                      isActive: false, isCompleted: false),
                  _buildProgressStep('Preparing',
                      isActive: true, isCompleted: true),
                  _buildProgressStep('Working',
                      isActive: false, isCompleted: false),
                  _buildProgressStep('Complete',
                      isActive: false, isCompleted: false),
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
                      const CircleAvatar(
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
                                // Time text added here
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
                                color: Colors
                                    .black, // Keep the default color for "- QR Payment"
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Worker Status Section
                  Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: 'Client ',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w700, // Bold weight
        ),
      ),
      TextSpan(
        text: 'need your help',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500, // Normal weight
        ),
      ),
    ],
  ),
),
                  const SizedBox(height: 8),
                  // Progress Bar
                  // Progress Bar with Icons
                  Row(
                    children: [
                      // Human Icon at the start
                      const Icon(Icons.person,
                          size: 20,
                          color: Color.fromARGB(255, 0, 0, 0)), // Adjust the size and color as needed

                      const SizedBox(
                          width: 8), // Space between icon and progress bar

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
                              width: MediaQuery.of(context).size.width *
                                  0.5, // 50% progress
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          width: 8), // Space between progress bar and icon

                      // Pin Icon at the end
                      const Icon(Icons.location_pin,
                          size: 20,
                          color: Color.fromARGB(255, 0, 0, 0)), // Adjust the size and color as needed
                    ],
                  ),

                  const SizedBox(height: 8),
                  // Time and Worker Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end, // Aligns items to the end (right side)
                    children: [
                      Text(
                        'Arriving in 20 mins',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
             const SizedBox(height: 10),
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
                  const SizedBox(height: 40), // Optional: Add some space before the button
ElevatedButton(
  onPressed: () {
     showDialog(
                          context: context,
                          builder: (BuildContext context) => const WorkerdonePage(),
                        );
  },
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Color(0xFF90D26D), // Text color of the button
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12), // Button padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Rounded corners
    ),
  ),
  child: Text(
    'Ready to Work',
    style: GoogleFonts.poppins(
      fontSize: 20, // Font size of the button text
      fontWeight: FontWeight.w600,
    ),
  ),
),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(String label,
      {required bool isActive, required bool isCompleted}) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 4,
          color: isCompleted
              ? Colors.blue
              : (isActive
                  ? Colors.blue
                  : const Color.fromARGB(255, 255, 255, 255)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive
                  ? Colors.blue
                  : const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ],
    );
  }
}
