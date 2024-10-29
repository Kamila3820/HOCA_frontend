import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoFields extends StatefulWidget {
  final Map<String, String> originalInfo;
  final Map<String, TextEditingController> controllers;
  final VoidCallback onSaveChanges;
  final bool hasChanges;
  final bool isLoading;

  const InfoFields({
    super.key,
    required this.originalInfo,
    required this.controllers,
    required this.onSaveChanges,
    required this.hasChanges,
    required this.isLoading,
  });

  @override
  _InfoFieldsState createState() => _InfoFieldsState();
}

class _InfoFieldsState extends State<InfoFields> {
  bool _isPhoneNumberValid = false;
  bool _hasTextChanges = false;

  @override
  void initState() {
    super.initState();
    widget.controllers.forEach((key, controller) {
      controller.addListener(() {
        if (key == 'Phone number') {
          _checkPhoneNumberValidity();
        }
        _checkTextChanges();
      });
    });
    _checkPhoneNumberValidity();
    _checkTextChanges();
  }

  void _checkPhoneNumberValidity() {
    setState(() {
      _isPhoneNumberValid = widget.controllers['Phone number']!.text.length == 10;
    });
  }

  void _checkTextChanges() {
    setState(() {
      _hasTextChanges = widget.controllers['Username']!.text != widget.originalInfo['Username'] ||
          widget.controllers['Phone number']!.text != widget.originalInfo['Phone number'];
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
          readOnly: label == 'Email',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 16,
              color: label == 'Email' ? const Color.fromARGB(255, 130, 130, 130) : Colors.black87,
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
    bool isButtonEnabled = (_hasTextChanges || widget.hasChanges) && 
                         (!widget.controllers['Phone number']!.text.isNotEmpty || _isPhoneNumberValid) && 
                         !widget.isLoading;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildInfoField('Email'),
          const SizedBox(height: 5),
          _buildInfoField('Username'),
          const SizedBox(height: 5),
          _buildInfoField('Phone number'),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: isButtonEnabled ? widget.onSaveChanges : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonEnabled
                  ? const Color(0xFF292B5C)
                  : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: widget.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
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

    if (newValue.text.length == 1 && newValue.text != '0') {
      return oldValue;
    }

    return newValue;
  }
}