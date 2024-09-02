import 'package:flutter/material.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/hoca-logo.png',
        height: 100,
      ),
    );
  }
}
