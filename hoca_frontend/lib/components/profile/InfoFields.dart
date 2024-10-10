import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoFields extends StatefulWidget {
  final Map<String, String> originalInfo;
  final Map<String, TextEditingController> controllers;
  final VoidCallback onSaveChanges;

  const InfoFields({
    super.key,
    required this.originalInfo,
    required this.controllers,
    required this.onSaveChanges,
  });

  @override
  _InfoFieldsState createState() => _InfoFieldsState();
}

class _InfoFieldsState extends State<InfoFields> {
  bool _isInfoChanged = false;
  bool _isPhoneNumberValid = false;

  @override
  void initState() {
    super.initState();
    widget.controllers.forEach((key, controller) {
      controller.addListener(() => _onTextChanged(key));
    });
    _checkPhoneNumberValidity();
  }

  @override
  void dispose() {
    widget.controllers.forEach((key, controller) {
      controller.removeListener(() => _onTextChanged(key));
    });
    super.dispose();
  }

  void _onTextChanged(String field) {
    setState(() {
      _isInfoChanged = widget.controllers.entries.any(
        (entry) => entry.value.text != widget.originalInfo[entry.key]
      );
      if (field == 'Phone number') {
        _checkPhoneNumberValidity();
      }
    });
  }

  void _checkPhoneNumberValidity() {
    setState(() {
      _isPhoneNumberValid = widget.controllers['Phone number']!.text.length == 10;
    });
  }

  Widget _buildInfoField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: widget.controllers[label],
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
          keyboardType: label == 'Phone number' ? TextInputType.phone : TextInputType.text,
          inputFormatters: label == 'Phone number'
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(10),
                  _PhoneNumberFormatter(),
                ]
              : null,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildInfoField('First name'),
          _buildInfoField('Last name'),
          _buildInfoField('Email'),
          _buildInfoField('Phone number'),
          ElevatedButton(
            onPressed: (_isInfoChanged && _isPhoneNumberValid) ? widget.onSaveChanges : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  (_isInfoChanged && _isPhoneNumberValid) ? const Color(0xFF292B5C) : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              'Save Changes',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Ensure the phone number starts with '0'
    if (newValue.text.length == 1 && newValue.text != '0') {
      return oldValue;
    }

    return newValue;
  }
}