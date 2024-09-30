import 'package:flutter/material.dart';

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
                    Icon(Icons.location_on),
                    SizedBox(width: 10),
                    Text('Choose Your Location'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Service',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildServiceOption('Cleaning', Icons.cleaning_services),
                _buildServiceOption('Clothes', Icons.local_laundry_service),
                _buildServiceOption('Pets', Icons.pets),
                _buildServiceOption('Gardening', Icons.grass),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Worker Available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: 4, // Number of workers
                itemBuilder: (context, index) {
                  return _buildWorkerCard();
                },
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
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle bottom navigation taps
        },
      ),
    );
  }

  Widget _buildServiceOption(String title, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 5),
        Text(title),
      ],
    );
  }

  Widget _buildWorkerCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  'https://via.placeholder.com/150', // Placeholder for worker's image
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Verified',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Teerasil Dangda',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                const Text('Male, 2.4 km'),
                const SizedBox(height: 5),
                const Text('House/Dormitory room'),
                const SizedBox(height: 10),
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
