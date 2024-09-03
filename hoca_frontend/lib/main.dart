import 'package:flutter/material.dart';

import 'pages/login.dart';

void main() => runApp(const HOCAApp());

class HOCAApp extends StatelessWidget {
  const HOCAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: LoginPage(), // Start with the login page
    );
  }
}
