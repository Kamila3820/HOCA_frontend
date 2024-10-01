import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/login/login_components.dart';
import 'package:page_transition/page_transition.dart'; // Import the page_transition package

import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void validateAndLogin() {
      if (formKey.currentState?.validate() ?? false) {
        // Handle login logic here

        // Navigate to HomePage with right-to-left page transition
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft, // Right-to-left transition
            child: HomePage(),
            duration: const Duration(milliseconds: 550), // Duration of the transition
            curve: Curves.easeInOut, // Animation curve
          ),
        );
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
