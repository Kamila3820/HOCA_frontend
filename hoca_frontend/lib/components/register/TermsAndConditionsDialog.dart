import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsDialog extends StatelessWidget {
  const TermsAndConditionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Terms and Conditions',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF87C4FF),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Text(
          'By using our service, you agree to the following terms and conditions:\n\n'
          '1. User Registration: You must provide accurate and complete information when creating an account.\n\n'
          '2. Privacy: We respect your privacy and handle your personal information as described in our Privacy Policy.\n\n'
          '3. User Conduct: You agree to use our service responsibly and not engage in any unlawful or prohibited activities.\n\n'
          '4. Intellectual Property: All content and materials available through our service are protected by intellectual property rights.\n\n'
          '5. Termination: We reserve the right to terminate or suspend your account for violations of these terms.\n\n'
          '6. Changes to Terms: We may modify these terms at any time. Continued use of our service constitutes acceptance of the modified terms.\n\n'
          '7. Limitation of Liability: We are not liable for any indirect, incidental, or consequential damages arising from your use of our service.\n\n'
          'For the full terms and conditions, please visit our website.',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF7A7777),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Close',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFF87C4FF),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}