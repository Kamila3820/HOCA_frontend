import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/login/login_components.dart';



class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LogoSection(),
            const SizedBox(height: 30),
            const WelcomeText(),
            const SizedBox(height: 10),
            const EmailTextField(),
            const SizedBox(height: 20),
            const PasswordTextField(),
            const SizedBox(height: 30),
            const LoginButton(),
            const SizedBox(height: 20),
            RegisterText(),
          ],
        ),
      ),
    );
  }
}
