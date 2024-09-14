import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/login/login_components.dart';

import 'home.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    void _validateAndLogin() {
      if (_formKey.currentState?.validate() ?? false) {
        // Handle login logic here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data')),
        );
        
        // Navigate to HomePage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50), // Optional space from top
                // Replace with your logo section widget
                const LogoSection(),
                const SizedBox(height: 30),
                // Replace with your welcome text widget
                const WelcomeText(),
                const SizedBox(height: 10),
                EmailTextField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    // Additional email validation can go here
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                PasswordTextField(
                  controller: _passwordController,
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
                LoginButton(onPressed: _validateAndLogin),
                const SizedBox(height: 20),
                // Replace with your register text widget
                const RegisterText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
