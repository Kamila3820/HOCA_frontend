import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/models/login.dart';
import 'package:hoca_frontend/pages/home.dart';
import 'package:hoca_frontend/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  Future navigate() async {
    // Get user token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";

    if (token == "") {
      return const LoginPage();
    }

    // Set caller token value
    Caller.setToken(token);
    return const HomePage();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () async {
      Widget target = await navigate();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => target),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFF87C4FF),
      body: Center(
        child: Text(
          'HOCA',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}