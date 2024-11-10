import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/login/login_components.dart';
import 'package:hoca_frontend/pages/checklocation.dart';
import 'package:page_transition/page_transition.dart'; // Import the page_transition package
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = "/login_page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

void callLogin() async {
  try {
    // Make POST request for login
    Response response = await Caller.dio.post("/v1/account/login", data: {
      "email": emailController.text,
      "password": passwordController.text,
    });

    // * Parse response
    final Map<String, dynamic> responseData = jsonDecode(response.toString());

    // Retrieve token from response
    final token = responseData["token"];

    if (token == null || token.isEmpty) {
      // Handle missing token case
      Caller.error(context, 'Failed to retrieve token. Please try again.');
      return;
    }

    print('Token received: $token'); // Log the received token

    // * Load shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);

    // * Set caller token value
    Caller.setToken(token);

    // Navigate to LocateLocationPage after successful login
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        child: CheckUserLocationPage(),
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
      ),
    );
  } on DioException catch (error) {
    // Custom handling for 401 Unauthorized
    if (error.response?.statusCode == 401) {
      Caller.error(context, 'Invalid email or password.');
      print('Login failed with status code 401: Invalid email or password.');
    } else {
      // Default error handling
      Caller.handle(context, error);
      print('Login failed with status code ${error.response?.statusCode}: ${error.message}');
    }
  } catch (e) {
    // Handle any other unexpected errors
    Caller.error(context, 'An unexpected error occurred.');
    print('Unexpected error: $e'); // Log unexpected errors
  }
}

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    void validateAndLogin() {
      // Validate form and trigger login
      if (formKey.currentState?.validate() ?? false) {
        callLogin();
      } else{
        print('Error: Form validation failed');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                const LogoSection(), // Custom logo widget
                const SizedBox(height: 30),
                const WelcomeText(), // Welcome text widget
                const SizedBox(height: 10),
                // Email input field
                EmailTextField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Password input field
                PasswordTextField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                // Login button
                LoginButton(onPressed: validateAndLogin),
                const SizedBox(height: 20),
                const RegisterText(), // Register link widget
              ],
            ),
          ),
        ),
      ),
    );
  }
}
