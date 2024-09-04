import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/login/login_components.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30), // Space at the top
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LogoSection(),
                const WelcomeText(),
                const SizedBox(height: 20),
                const EmailTextField(),
                const SizedBox(height: 20),
                const PasswordTextField(),
                const SizedBox(height: 45),
                const LoginButton(),
                const SizedBox(height: 30),
                RegisterText(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
