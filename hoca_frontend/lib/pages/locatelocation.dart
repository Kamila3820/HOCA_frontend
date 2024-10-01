import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add back button functionality here
          },
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search for your location',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          ),
        ),
        backgroundColor: Colors.lightBlue[200], // Matches the blue background
        elevation: 0, // Removes shadow below AppBar
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.black),
            title: Text('Thung Kru, Bangkok'),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200], // Matches the background color
    );
  }
}
