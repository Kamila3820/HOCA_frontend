import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import the dotenv package

import 'pages/login.dart'; // Import your login page

Future<void> main() async {
  // Ensure Flutter is initialized before loading environment variables
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables from the .env file located in the assets folder
  await dotenv.load(fileName: "assets/.env");

  // Run the app
  runApp(const HOCAApp());
}

class HOCAApp extends StatelessWidget {
  const HOCAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOCA', // Title of the app
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary color for the app
      ),
      home: const LoginPage(), // Start with the login page
    );
  }
}
