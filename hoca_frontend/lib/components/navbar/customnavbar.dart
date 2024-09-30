import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hoca_frontend/components/navbar/buildIcon.dart';
import 'package:hoca_frontend/pages/createpost.dart';
import 'package:hoca_frontend/pages/history.dart';
import 'package:hoca_frontend/pages/home.dart';
import 'package:hoca_frontend/pages/profile.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String currentPage;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
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
                      MaterialPageRoute(
                        builder: (context) => HistoryPage(),
                      ),
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
                      MaterialPageRoute(
                        builder: (context) => HistoryPage(),
                      ),
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
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20), // Adjust the value to move it lower
      child: Container(
        width: 70, // Set the desired width
        height: 70, // Set the desired height
        decoration: const BoxDecoration(
          color: Colors.transparent, // Set container background to transparent
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreatePostPage()),
            );
          },
          backgroundColor: const Color(0xFF7E869E).withOpacity(0.5),
          shape: const CircleBorder(), // Keep the round shape
          elevation: 0,
          child: const Icon(Icons.add,
              size: 50, color: Color.fromARGB(147, 13, 13, 13)),
        ),
      ),
    );
  }
}
