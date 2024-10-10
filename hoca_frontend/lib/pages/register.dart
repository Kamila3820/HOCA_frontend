import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../components/register/register_components.dart';



class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _imageSelected = false;
  bool _termsAccepted = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imageSelected = true;
      });
    }
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      if (!_imageSelected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload or take a photo.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account Created!'),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color.fromARGB(197, 0, 0, 0)),
            iconSize: 50,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF87C4FF),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "Register to get started",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF7A7777),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 11),
              const TextFormFieldSection(
                label: "Firstname",
                hintText: "Enter your firstname",
                validator: Validators.validateName,
              ),
              const SizedBox(height: 16),
              const TextFormFieldSection(
                label: "Lastname",
                hintText: "Enter your lastname",
                validator: Validators.validateName,
              ),
              const SizedBox(height: 16),
              TextFormFieldSection(
                label: "Phone number",
                hintText: "Enter your phone number",
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: Validators.validatePhoneNumber,
              ),
              const SizedBox(height: 16),
              const TextFormFieldSection(
                label: "Email",
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 16),
              const TextFormFieldSection(
                label: "Password",
                hintText: "Enter your password",
                obscureText: true,
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "ID Card",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7A7777),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ImagePickerSection(
                image: _image,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF87C4FF), width: 2),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF87C4FF),
                          ),
                          child: Text(
                            'Select Image Source',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: Text(
                                'Take a Photo',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF7A7777),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                            ),
                            Divider(
                              color: Colors.grey[450],
                              height: 1,
                              thickness: 1,
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: Text(
                                'Choose from Gallery',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF7A7777),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          onChanged: (bool? value) {
                            setState(() {
                              _termsAccepted = value!;
                            });
                          },
                          activeColor: const Color(0xFF87C4FF),
                        ),
                        Expanded(
                          child: Text(
                            "I agree to the terms and conditions",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF7A7777),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => const TermsAndConditionsDialog(),
                        ),
                        child: Text(
                          "Read more",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF87C4FF),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: 345,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _termsAccepted ? const Color(0xFF87C4FF) : Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _termsAccepted ? _validateForm : null,
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: _termsAccepted ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}