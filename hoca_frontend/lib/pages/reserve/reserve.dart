import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/reserve/buildinfotitle.dart';
import 'package:hoca_frontend/components/reserve/buildreviewtitle.dart';
import 'package:hoca_frontend/components/reserve/buildtaskbutton.dart';

import 'reservepayment.dart';  // Import the reservepayment.dart file

class ReservePage extends StatelessWidget {
  const ReservePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("CleanerProfile_page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture and Name
            const CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(
                  'https://www.example.com/profile_picture_url'), // Replace with actual image URL or asset
            ),
            const SizedBox(height: 10),
            const Text(
              "Artiwara Kongmalai",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text("(5 times)", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            // Rating
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 5),
                Text("8.0", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),
            // Task Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTaskButton("Iron the clothes"),
                buildTaskButton("Mop the floor"),
                buildTaskButton("Wash dishes"),
              ],
            ),
            const SizedBox(height: 20),
            // Verified badge
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified, color: Colors.green),
                SizedBox(width: 5),
                Text("verified", style: TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 20),
            // Location, Gender, Contact Information
            buildInfoTile(
                "Thung Khru, Bangkok", Icons.location_on, Colors.blue),
            buildInfoTile("Gender: Male", Icons.person, Colors.blue),
            buildInfoTile("098-765-4321", Icons.phone, Colors.blue),
            buildInfoTile("LINE ID: lawyer7", Icons.message, Colors.blue),
            const SizedBox(height: 20),
            // Acceptable places and family size
            buildInfoTile(
                "Acceptable type of place: House/Dormitory room",
                Icons.home,
                Colors.blue),
            buildInfoTile("Acceptable range of family size: 3-5 people",
                Icons.people, Colors.blue),
            const SizedBox(height: 20),
            // Description
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: const Text(
                "I'm available to do the task jobs listed below. Now I'm staying in Thung Khru, BKK:\n- Mop the floor\n- Wash dishes\n- Iron clothes",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            // Reviews
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "John Mayer's Review:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            buildReviewTile("Karl Anthony", "8/04/2024"),
            const SizedBox(height: 20),
            // Reserve Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the payment page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReservePaymentPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                child: Text("Reserve", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
