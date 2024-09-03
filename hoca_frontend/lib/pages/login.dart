import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/login/login_components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogoSection(),
            SizedBox(height: 30),
            WelcomeText(),
            SizedBox(height: 10),
            EmailTextField(),
            SizedBox(height: 20),
            PasswordTextField(),
            SizedBox(height: 30),
            LoginButton(),
            SizedBox(height: 20),
            RegisterText(),
          ],
        ),
      ),
    );
  }
}
