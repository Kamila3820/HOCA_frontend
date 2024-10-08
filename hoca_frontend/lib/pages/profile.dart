import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/profile/InfoFields.dart';
import 'package:hoca_frontend/components/profile/LogoutButton.dart';
import 'package:hoca_frontend/components/profile/ProfileHeader.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;

  // Original user info
  Map<String, String> _originalInfo = {
    'First name': 'Thanadol',
    'Last name': 'Saojarkaval',
    'Email': 'thanadonsaojarkaval@gmail.com',
    'Phone number': '0958505514',
  };

  // Controllers for each info field
  Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _originalInfo.forEach((key, value) {
      _controllers[key] = TextEditingController(text: value);
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Image and Basic Info
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              color: Colors.blueAccent,
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/profile_image.png'), // Replace with your image asset
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Artiwara Kongmalai',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        '8.0 (5 times)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Services Offered
            const Padding(
              padding: EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    label: Text('Iron the clothes'),
                  ),
                  Chip(
                    label: Text('Mop the floor'),
                  ),
                  Chip(
                    label: Text('Wash dishes'),
                  ),
                ],
              ),
            ),

            // Contact Information and Location
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Verified',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Thung Khru, Bangkok',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Gender: Male',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Phone: 098-765-4321',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'LINE ID: lawyer7',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Pricing Information
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    '400 THB/hr',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Description and Review Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'I\'m available to do the tasks listed below. I\'m currently staying in Thung Khru, BKK:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 10),
                  BulletList(
                    items: ['Mop the floor', 'Wash dishes', 'Iron clothes'],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Created on 14/03/2024',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Divider(),
                  Text(
                    'Karl Anthony\'s Review:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  ReviewWidget(
                    reviewer: 'Karl Anthony',
                    date: '8/04/2024',
                    review: 'Great work! Highly recommended.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 3, // Profile page is active
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  void dispose() {
    _controllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    // Add your image picking logic here...
    setState(() {
      _isLoading = false;
    });
  }

  void _handleSaveChanges() {
    // Implement your save changes logic here
    print('Save changes');
    // You might want to update _originalInfo with the new values here
    setState(() {
      _originalInfo = Map.fromEntries(
        _controllers.entries.map((e) => MapEntry(e.key, e.value.text))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ProfileHeader(
                  isLoading: _isLoading,
                  onPickImage: () => _pickImage(context),
                ),
                InfoFields(
                  originalInfo: _originalInfo,
                  controllers: _controllers,
                  onSaveChanges: _handleSaveChanges,
                ),
              ],
            ),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}