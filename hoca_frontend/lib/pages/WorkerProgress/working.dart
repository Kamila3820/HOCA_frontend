import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/workerorder.dart';
import 'package:hoca_frontend/pages/WorkerProgress/complete.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerdonePage extends StatefulWidget {
  final String orderID;

  final String? latitude;
  final String? longitude;
  final String? address;

  const WorkerdonePage({
    super.key,
    required this.orderID,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  State<WorkerdonePage> createState() => _WorkerdonePageState();
}

class _WorkerdonePageState extends State<WorkerdonePage> {
  late Future<WorkerOrder?> orderFuture;

  @override
  void initState() {
    super.initState();

    orderFuture = fetchWorkerOrder(widget.orderID);
  }

   Future<void> _refreshData() async {
    setState(() {
      orderFuture = fetchWorkerOrder(widget.orderID);
    });
  }

  Future<Map<String, String>> _getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'latitude': prefs.getString('latitude') ?? '',
      'longitude': prefs.getString('longitude') ?? '',
      'address': prefs.getString('address') ?? '',
    };
  }

  Future<WorkerOrder?> fetchWorkerOrder(String orderID) async {
    String url = "/v1/order/worker/$orderID";
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

      return WorkerOrder.fromJson(
          response.data); // Continue with parsing if data exists
    } catch (e) {
      debugPrint('Error fetching worker order: $e');
      return null;
    }
  }

  void callCompleteOrder(String orderID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      await Caller.dio.patch(
        "/v1/order/update/$orderID",
        data: {"status": "complete"},
        options: Options(
          headers: {
            'x-auth-token': '$token',
          },
        ),
      );

     final locationData = await _getSavedLocation();
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
    } on DioException catch (error) {
      // Handle error
      Caller.handle(context, error);
    }
  }

  void handleNavigation(WorkerOrder? order) {
    if (order == null || order.status == "cancelled") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProgressPage()),
      );
    } else if (order.status == "complete") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WorkerCompletionPage(
                  orderID: widget.orderID,
                )),
      );
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: const Color(0xFF87C4FF),
        child: FutureBuilder<WorkerOrder?>(
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
                          isActive: false, isCompleted: false),
                      _buildProgressStep('Working',
                          isActive: true, isCompleted: true),
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
                                  text: ' - ${order.payment}',
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
                      const SizedBox(
                          height: 8), // Add some space between the texts
                      const SizedBox(height: 16),
// New Circle Checkboxes Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircleCheckbox(
                            label: 'Received',
                            isChecked: true,
                            color: Color(0xFF90D26D),
                          ),
                          _buildCircleCheckbox(
                            label: 'Preparing',
                            isChecked: true,
                            color: Color(0xFF90D26D),
                          ),
                          _buildCircleCheckbox(
                            label: 'On Process',
                            isChecked: false,
                            color: Color(0xFF87C4FF),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Add some space before the image
                // Runman Image
                Center(
                  child: Image.asset(
                    'assets/images/workload.png', // Path to your image
                    height: 180, // Set the height as needed
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
                const SizedBox(
                    height: 40), // Optional: Add some space before the button
                ElevatedButton(
                  onPressed: () {
                    bool isChecked1 = false; // First checkbox state
                    bool isChecked2 = false; // Second checkbox state

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: const Color(0xFF87C4FF),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Confirm Working',
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
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isChecked1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked1 = value ?? false;
                                          });
                                        },
                                        shape:
                                            CircleBorder(), // Circular shape for checkbox
                                        activeColor: const Color(
                                            0xFF87C4FF), // Checkbox color
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "I am honored to have never taken anything that isn't mine.",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: 8), // Add spacing between rows
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isChecked2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked2 = value ?? false;
                                          });
                                        },
                                        shape:
                                            CircleBorder(), // Circular shape for checkbox
                                        activeColor: const Color(
                                            0xFF87C4FF), // Checkbox color
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "I assure you that I took great care to leave everything in your space exactly as it was, without any damage.",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: (isChecked1 && isChecked2)
                                      ? () {
                                          // Navigate to the next page if both checkboxes are checked
                                          callCompleteOrder(widget.orderID);
                                        }
                                      : null, // Disable button if either checkbox is unchecked
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: (isChecked1 && isChecked2)
                                        ? const Color(
                                            0xFF87C4FF) // Enabled color
                                        : Colors.white, // Disabled color
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
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF90D26D),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Complete',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
                )
            );
          }
        },
      ),
      )
    );
  }
}

Widget _buildCircleCheckbox({
  required String label,
  required bool isChecked,
  required Color color,
}) {
  return Column(
    children: [
      Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 2,
          ),
          color: isChecked ? color : Colors.white,
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
            : null,
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
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
