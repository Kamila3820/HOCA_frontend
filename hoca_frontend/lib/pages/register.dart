import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _image; // Variable to hold the selected image
  final ImagePicker _picker = ImagePicker(); // Create an instance of ImagePicker
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key
  bool _imageSelected = false; // Track if an image is selected

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the selected image
        _imageSelected = true; // Set flag to true when an image is selected
      });
    }
  }

  // Function to validate the form
  void _validateForm() {
  if (_formKey.currentState!.validate()) {
    if (!_imageSelected) {
      // Show an error message if no image is selected
     ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Please upload or take a photo.'),
    backgroundColor: Colors.red, // Set the background color to red
  ),
);

    } else {
      // Show a notification with "Account Created!" message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account Created!'),
          backgroundColor: Colors.green, // Optional: set a background color for the snackbar
        ),
      );

      // Navigate back to the LoginPage
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context); // Go back to the previous screen, which should be the LoginPage
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
          padding: const EdgeInsets.only(left: 5.0), // Adds space in front of the arrow icon
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color.fromARGB(197, 0, 0, 0)),
            iconSize: 50, // Increase the size of the icon
            onPressed: () {
              Navigator.pop(context); // Go back to the login page
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Attach the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0), // Adds space in front of "Create Account"
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
                padding: const EdgeInsets.only(left: 30.0), // Adds space in front of "Register to get started"
                child: Text(
                  "Register to get started",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF7A7777), // Updated color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 11),
              // Firstname
              Padding(
                padding: const EdgeInsets.only(left: 25.0), // Adds space in front of "Firstname"
                child: Text(
                  "Firstname",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7A7777),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust horizontal padding
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your firstname",
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFFA9A8A8),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your firstname';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Lastname
              Padding(
                padding: const EdgeInsets.only(left: 25.0), // Adds space in front of "Lastname"
                child: Text(
                  "Lastname",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7A7777),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust horizontal padding
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your lastname",
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFFA9A8A8),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your lastname';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Phone number
          Padding(
  padding: const EdgeInsets.only(left: 25.0), // Adds space in front of "Phone number"
  child: Text(
    "Phone number",
    style: GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 16,
        color: Color(0xFF7A7777),
      ),
    ),
  ),
),
const SizedBox(height: 8),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust horizontal padding
  child: TextFormField(
    decoration: InputDecoration(
      hintText: "Enter your phone number",
      hintStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Color(0xFFA9A8A8),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    keyboardType: TextInputType.phone,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly, // Allow only digits
      LengthLimitingTextInputFormatter(10), // Limit input to 10 digits
    ],
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number';
      } else if (value.length != 10) { // Validate that the length is exactly 10 digits
        return 'Please enter a valid 10-digit phone number';
      }
      return null;
    },
  ),
),
              const SizedBox(height: 16),
              // Email
              Padding(
                padding: const EdgeInsets.only(left: 25.0), // Adds space in front of "Email"
                child: Text(
                  "Email",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7A7777),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust horizontal padding
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFFA9A8A8),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Password
              Padding(
                padding: const EdgeInsets.only(left: 25.0), // Adds space in front of "Password"
                child: Text(
                  "Password",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7A7777),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust horizontal padding
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFFA9A8A8),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              // ID Card
              Padding(
                padding: const EdgeInsets.only(left: 25.0), // Adds space in front of "ID Card"
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust horizontal padding
                child: GestureDetector(
                  onTap: () {
                    // Show a dialog to choose between camera and gallery
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF87C4FF), width: 2), // Border color and width
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFF87C4FF), // Title background color
                            ),
                            child: Text(
                              'Select Image Source',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Title text color
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
                                color: Colors.grey[450], // Divider color
                                height: 1, // Divider height
                                thickness: 1, // Divider thickness
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
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      border: Border.all(color: const Color(0xFFF0F0F0)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (_image != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Center(
                          child: _image == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.image, // Replace with your desired icon
                                      size: 80, // Adjust the size of the icon
                                      color: Colors.grey, // Icon color
                                    ),
                                    const SizedBox(height: 10), // Space between icon and text
                                    Text(
                                      "Upload or Take a photo",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(), // Empty container if image is present
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Sign Up Button
              Center(
  child: SizedBox(
    width: 345, // Set your desired width here
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF87C4FF),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: _validateForm, // Validate form on press
      child: Text(
        'Sign Up',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),
)

            ],
          ),
        ),
      ),
    );
  }
}
