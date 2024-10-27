import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpost/FormContainer.dart';
import 'package:hoca_frontend/components/createpost/HeaderSection.dart';
import 'package:hoca_frontend/pages/createpost/createpostcon.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  // Define controllers for the form fields in FormContainer
  final TextEditingController _workerNameController = TextEditingController();
  final TextEditingController _workingPriceController = TextEditingController();
  final TextEditingController _idLineController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedGender = "Male";
  int? selectedCategory; 

  // Function to toggle category selection
  void toggleCategory(int category) {
    setState(() {
      selectedCategory = selectedCategory == category ? null : category;
    });
  }

  // Method to handle form submission
  void _submitForm() {
    // Check if a category is selected
    if (selectedCategory == null) {
      // Show an error if the category is not selected
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color.fromARGB(255, 221, 78, 78),
          content: Text(
            'Please select a category.',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
      return;
    }

    // Create a formData map to pass the collected form data
    Map<String, dynamic> formData = {
      "name": _workerNameController.text,
      "price": _workingPriceController.text,
      "idLine": _idLineController.text,
      "phoneNumber": _phoneNumberController.text,
      "description": _descriptionController.text,
      "gender": _selectedGender,
      "categories": selectedCategory,
    };

    // If form is valid, navigate to CreatePostCon and pass form data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePostCon(
          formData: formData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HeaderSection(title: "Create Worker",), // Your existing header section
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 80),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FormContainer(
                      workerNameController: _workerNameController,
                      workingPriceController: _workingPriceController,
                      idLineController: _idLineController,
                      phoneNumberController: _phoneNumberController,
                      descriptionController: _descriptionController,
                      selectedGender: _selectedGender,
                      onGenderChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                      selectedCategories: selectedCategory,
                      toggleCategory: toggleCategory,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _submitForm, // Directly call _submitForm
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  backgroundColor: const Color(0xFF87C4FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Next',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}