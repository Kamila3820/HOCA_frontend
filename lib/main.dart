import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/profile.dart';

void main() => runApp(HOCAApp());

class HOCAApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: LoginPage(), // Start with the login page
    );
  }
}
