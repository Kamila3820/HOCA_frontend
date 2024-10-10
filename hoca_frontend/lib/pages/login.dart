import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/login/login_components.dart';
import 'package:hoca_frontend/pages/locatelocation.dart';
import 'package:page_transition/page_transition.dart'; // Import the page_transition package
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

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
    Caller.dio.post("/v1/account/login", data: {
      "email": emailController.text,
      "password": passwordController.text,
    }).then((response) async {
      // * Parse response
      final Map<String, dynamic> responseData = jsonDecode(response.toString());

    // Retrieve the token from the response
    final token = responseData["token"];
    print(token);

      // * Load shared preferences
      final prefs = await SharedPreferences
          .getInstance(); //shared_preferences same as cookies
      prefs.setString('token', token);

      // * Set caller token value
      Caller.setToken(token);

      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LocateLocationPage(),
          duration: const Duration(milliseconds: 550),
          curve: Curves.easeInOut,
        ),
      );
    }).onError((DioException error, _) {
      // * Apply default error handling
      Caller.handle(context, error);
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    void validateAndLogin() {
      if (formKey.currentState?.validate() ?? false) {
        // Call the login function
        callLogin();
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
                const LogoSection(),
                const SizedBox(height: 30),
                const WelcomeText(),
                const SizedBox(height: 10),
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
                LoginButton(onPressed: validateAndLogin),
                const SizedBox(height: 20),
                const RegisterText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
