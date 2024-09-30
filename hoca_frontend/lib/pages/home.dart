import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/home/home_components.dart';
import 'package:hoca_frontend/pages/createpost.dart';
import 'package:hoca_frontend/pages/history.dart';
import 'package:hoca_frontend/pages/notification.dart';
import 'package:hoca_frontend/pages/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String currentPage = "Home"; // Set the current page

    return Scaffold(
      body: Stack(
        children: [
          // Background half box decoration
          Container(
            height: 335.0,
            decoration: BoxDecoration(
              color: const Color(0xFF87C4FF).withOpacity(0.6), // 70% opacity
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(90),
              ), // Rounded only top corners
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              children: [
                                const TextSpan(text: 'Welcome!, '),
                                TextSpan(
                                  text: 'Suphanut',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const SizedBox(
                        width: 40,
                        height: 40,
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 35,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotiPage()), // Navigate to NotiPage
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle location selection
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF39A7FF),
                            size: 26,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Choose Your Location',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Service',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildServiceOption('Cleaning', FontAwesomeIcons.broom),
                    buildServiceOption('Clothes', FontAwesomeIcons.shirt),
                    buildServiceOption('Pets', Icons.pets),
                    buildServiceOption('Gardening', FontAwesomeIcons.seedling),
                  ],
                ),
                const SizedBox(height: 65),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Worker Available',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Total Found: 4 in your area',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.58,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return buildWorkerCard();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, -1),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    child: BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildIconWithLabelWithColor(
              FontAwesomeIcons.home,
              "Home",
              currentPage,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to HistoryPage
                );
              },
            ),
            buildIconWithLabelWithColor(
              Icons.history,
              "History",
              currentPage,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()), // Navigate to HistoryPage
                );
              },
            ),
            const SizedBox(width: 40),
            buildIconWithLabelWithColor(
              FontAwesomeIcons.fileAlt,
              "Progress",
              currentPage,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()), // Navigate to HistoryPage
                );
              },
            ),
            buildIconWithLabelWithColor(
              FontAwesomeIcons.userCircle,
              "Profile",
              currentPage,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()), // Navigate to HistoryPage
                );
              },
            ),
          ],
        ),
      ),
    ),
  ),
),

      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(top: 20), // Adjust the value to move it lower
        child: Container(
          width: 70, // Set the desired width
          height: 70, // Set the desired height
          decoration: const BoxDecoration(
            color:
                Colors.transparent, // Set container background to transparent
          ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreatePostPage()), // Navigate to HistoryPage
                );
            },
            backgroundColor: const Color(0xFF7E869E).withOpacity(0.5),
            shape: const CircleBorder(), // Keep the round shape
            elevation: 0,
            child: const Icon(Icons.add,
                size: 50, color: Color.fromARGB(147, 13, 13, 13)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
