import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/pages/login.dart';
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
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
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
      } else if (_password.text != _confirmPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        callRegister();
      }
    }
  }

  void callRegister() async {
    try {
      // Prepare image file if selected
      MultipartFile? imageFile;
      if (_image != null) {
        imageFile = await MultipartFile.fromFile(_image!.path);
      }

      FormData formData = FormData.fromMap({
        "username": _username.text,
        "password": _password.text,
        "confirmPassword": _confirmPassword.text,
        "email": _email.text,
        "phone_number": _phoneNumber.text,
        "file": imageFile,
      });

      await Caller.dio.post("/v1/account/register", data: formData);

      // Navigate to login page after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on DioException catch (error) {
      // Handle error
      Caller.handle(context, error);
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
              const SizedBox(height: 16),
              TextFormFieldSection(
                controller: _username,
                label: "Username",
                hintText: "Enter your username",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldSection(
                controller: _phoneNumber,
                label: "Phone number",
                hintText: "Enter your phone number",
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldSection(
                controller: _email,
                label: "Email",
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldSection(
                controller: _password,
                label: "Password",
                hintText: "Enter your password",
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldSection(
                controller: _confirmPassword,
                label: "Confirm Password",
                hintText: "Re-enter your password",
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  return null;
                },
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _termsAccepted,
                            onChanged: (value) {
                              setState(() {
                                _termsAccepted = value!;
                              });
                            },
                          ),
                          Flexible(
                            child: Text(
                              "I agree to the Terms and Conditions",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 12,
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const TermsAndConditionsDialog();
                              },
                            );
                          },
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

              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _termsAccepted ? _validateForm : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF87C4FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Create Account",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
