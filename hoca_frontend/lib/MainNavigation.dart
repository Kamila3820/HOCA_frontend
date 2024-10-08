import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/navbar/creatpostbutton.dart';
import 'package:hoca_frontend/components/navbar/customnavbar.dart';
import 'package:hoca_frontend/pages/createpost/createpost.dart';
import 'package:hoca_frontend/pages/history.dart';
import 'package:hoca_frontend/pages/home.dart';
import 'package:hoca_frontend/pages/profile.dart';
import 'package:hoca_frontend/pages/progress.dart';


class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0; // Keeps track of the selected tab

  // List of pages to display, including ProgressPage
  final List<Widget> _pages = [
    const HomePage(),
    HistoryPage(),
    const ProgressPage(), 
    const ProfilePage(),
   
  ];

  // Function to handle tapping on navigation bar items
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          // Handle the floating action button tap here
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostPage(), // Replace with your CreatePostPage
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
