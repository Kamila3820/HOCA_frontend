import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/home/home_components.dart';
import 'package:hoca_frontend/pages/location/location.dart';
import 'package:hoca_frontend/pages/notification.dart';
import 'package:hoca_frontend/pages/service/cleaning.dart';
import 'package:hoca_frontend/pages/service/clothes.dart';
import 'package:hoca_frontend/pages/service/gardening.dart';
import 'package:hoca_frontend/pages/service/pets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationPage(),
                      ),
                    );
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
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CleanPage(),
                      ),
                    );
                      },
                      child: buildServiceOption(
                          'Cleaning', FontAwesomeIcons.broom),
                    ),
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClothesPage(),
                      ),
                    );
                      },
                      child:
                          buildServiceOption('Clothes', FontAwesomeIcons.shirt),
                    ),
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PetsPage(),
                      ),
                    );
                      },
                      child: buildServiceOption('Pets', Icons.pets),
                    ),
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GardeningPage(),
                      ),
                    );
                      },
                      child: buildServiceOption(
                          'Gardening', FontAwesomeIcons.seedling),
                    ),
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
                      return buildWorkerCard(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const CustomBottomNavigationBar(
      //     currentPage: 'Home'), // Add the bottom navigation bar
      // floatingActionButton:
      //     const CustomFloatingActionButton(), // Add the floating action button
      // floatingActionButtonLocation: FloatingActionButtonLocation
      //     .centerDocked, // Center the floating action button
    );
  }
}
