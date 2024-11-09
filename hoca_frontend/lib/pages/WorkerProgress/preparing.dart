import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/workerprepare.dart';
import 'package:hoca_frontend/pages/WorkerProgress/working.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerArrivalPage extends StatefulWidget {
  final String orderID;

  final String? latitude;
  final String? longitude;
  final String? address;

  const WorkerArrivalPage({
    super.key,
    required this.orderID,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  State<WorkerArrivalPage> createState() => _WorkerArrivalPageState();
}

class _WorkerArrivalPageState extends State<WorkerArrivalPage> {
  late Future<WorkerPrepare?> orderFuture;

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

  Future<WorkerPrepare?> fetchWorkerOrder(String orderID) async {
    String url = "/v1/order/worker/prepare/$orderID";
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

      return WorkerPrepare.fromJson(
          response.data); // Continue with parsing if data exists
    } catch (e) {
      debugPrint('Error fetching worker order: $e');
      return null;
    }
  }

 Future<void> _refreshData() async {
    setState(() {
      orderFuture = fetchWorkerOrder(widget.orderID);
    });
  }

  void callWorkingOrder(String orderID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      await Caller.dio.patch(
        "/v1/order/update/$orderID",
        data: {"status": "working"},
        options: Options(
          headers: {
            'x-auth-token': '$token',
          },
        ),
      );

      Navigator.pushReplacement(
  context,
  PageTransition(
    type: PageTransitionType.rightToLeft, // Choose your desired transition type
    child: WorkerdonePage(orderID: orderID),
  ),
);
    } on DioException catch (error) {
      // Handle error
      Caller.handle(context, error);
    }
  }

  void handleNavigation(WorkerPrepare? order) {
    if (order == null ||
        order.orderStatus == "complete" ||
        order.orderStatus == "cancelled") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProgressPage()),
      );
    } else if (order.orderStatus == "working") {
      Navigator.pushReplacement(
  context,
  PageTransition(
    type: PageTransitionType.rightToLeft, // Choose your preferred transition type
    child: WorkerdonePage(
      orderID: widget.orderID,
    ),
  ),
);
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<WorkerPrepare?>(
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
              return const Center(child: CircularProgressIndicator());
            } else {
              final order = snapshot.data!;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                handleNavigation(order);
              });

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                // Progress steps at the top
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
                          order.userAvatar != null &&
                                  order.userAvatar!.isNotEmpty
                              ? CircleAvatar(
                                  radius: 28,
                                  backgroundImage:
                                      NetworkImage(order.userAvatar!),
                                  backgroundColor:
                                      Colors.transparent, // Optional
                                )
                              : const CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.grey,
                                  child: Icon(Icons.person,
                                      color: Colors.white, size: 30),
                                ),
                          const SizedBox(width: 12),
                          // Worker Details
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Time text added here
                                    Text(
                                      'Time: ${order.createdAt?.replaceAll("-", "/")}',
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
                              text: 'Approx ',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500, // Bold weight
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${order.distance!.first.legs!.first.duration!.text}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700, // Normal weight
                              ),
                            ),
                            TextSpan(
                              text: ' to arriving in',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500, // Bold weight
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
                              color: Color.fromARGB(255, 0, 0,
                                  0)), // Adjust the size and color as needed

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
                              color: Color.fromARGB(255, 0, 0,
                                  0)), // Adjust the size and color as needed
                        ],
                      ),

                  const SizedBox(height: 8),
                  // Time and Worker Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end, // Aligns items to the end (right side)
                    children: [
                      Text(
                        '${order.distance!.first.legs!.first.distance!.text}',
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
              height: 290,
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
    Row(
      children: [
        Icon(
          Icons.receipt_long, // Use an icon of your choice
          color: Colors.blue, // Set the color of the icon
          size: 20,
        ),
        const SizedBox(width: 8), // Add spacing between the icon and text
        Text(
          'Order Details',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(172, 0, 0, 0), // Set the color of the text to match the icon if desired
          ),
        ),
      ],
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
      'Duration :',
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
    Text(
      order.duration ?? "-",
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
                  const SizedBox(height: 40), // Optional: Add some space before the button
ElevatedButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: const Color(0xFF87C4FF),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Confirm Arrival',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Text(
            'Are you ready to start working?',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate to the next page
                callWorkingOrder(widget.orderID);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF87C4FF),
              ),
              child: Text(
                'Confirm',
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
    backgroundColor: Color(0xFF90D26D),
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: Text(
    'Ready to Work',
    style: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
),
          ],
                ),
             );
            }
        },
      ),
      )
    );
  }
}

Widget _buildProgressStep(String label,
    {required bool isActive, required bool isCompleted}) {
  return Column(
    children: [
      Container(
        width: 100,
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
