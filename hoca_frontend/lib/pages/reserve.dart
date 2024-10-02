import 'package:flutter/material.dart';
import 'reservepayment.dart';  // Import the reservepayment.dart file

class ReservePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("CleanerProfile_page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture and Name
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(
                  'https://www.example.com/profile_picture_url'), // Replace with actual image URL or asset
            ),
            SizedBox(height: 10),
            Text(
              "Artiwara Kongmalai",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("(5 times)", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 5),
                Text("8.0", style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 20),
            // Task Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTaskButton("Iron the clothes"),
                _buildTaskButton("Mop the floor"),
                _buildTaskButton("Wash dishes"),
              ],
            ),
            SizedBox(height: 20),
            // Verified badge
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified, color: Colors.green),
                SizedBox(width: 5),
                Text("verified", style: TextStyle(color: Colors.green)),
              ],
            ),
            SizedBox(height: 20),
            // Location, Gender, Contact Information
            _buildInfoTile(
                "Thung Khru, Bangkok", Icons.location_on, Colors.blue),
            _buildInfoTile("Gender: Male", Icons.person, Colors.blue),
            _buildInfoTile("098-765-4321", Icons.phone, Colors.blue),
            _buildInfoTile("LINE ID: lawyer7", Icons.message, Colors.blue),
            SizedBox(height: 20),
            // Acceptable places and family size
            _buildInfoTile(
                "Acceptable type of place: House/Dormitory room",
                Icons.home,
                Colors.blue),
            _buildInfoTile("Acceptable range of family size: 3-5 people",
                Icons.people, Colors.blue),
            SizedBox(height: 20),
            // Description
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Text(
                "I'm available to do the task jobs listed below. Now I'm staying in Thung Khru, BKK:\n- Mop the floor\n- Wash dishes\n- Iron clothes",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            // Reviews
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "John Mayer's Review:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildReviewTile("Karl Anthony", "8/04/2024"),
            Spacer(),
            // Reserve Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the payment page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReservePaymentPage()),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                child: Text("Reserve", style: TextStyle(fontSize: 18)),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for the Task Buttons
  Widget _buildTaskButton(String taskName) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,  // Use backgroundColor instead of primary
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(taskName),
    );
  }

  // Widget for the Info Tiles
  Widget _buildInfoTile(String info, IconData icon, Color iconColor) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(info),
    );
  }

  // Widget for the Review Tile
  Widget _buildReviewTile(String reviewerName, String reviewDate) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(reviewerName[0]),
      ),
      title: Text(reviewerName),
      subtitle: Text(reviewDate),
    );
  }
}
