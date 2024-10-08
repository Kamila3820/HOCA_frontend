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
  final _formKey = GlobalKey<FormState>();
  List<String> selectedCategories = [];

  void toggleCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        if (selectedCategories.length < 3) {
          selectedCategories.add(category);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HeaderSection(),
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 80),
                  FormContainer(
                    selectedCategories: selectedCategories,
                    toggleCategory: toggleCategory,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10, // Adjust as needed to overlap with the container
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Check if at least one category is selected
                    if (selectedCategories.isEmpty) {
                      // Show a dialog indicating the user should select at least one category
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Color.fromARGB(255, 221, 78,
                              78), // Set the background color of the dialog
                          content: Text(
                            'Please select at least one category.',
                            style: GoogleFonts.poppins(
                              // Use GoogleFonts.poppins for the text style
                              textStyle: TextStyle(
                                fontSize: 18, // Set the font size
                                color: Colors.white, // Set the text color
                                fontWeight: FontWeight
                                    .w600, // Optional: Set the font weight
                              ),
                            ),
                          ),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context)
                            .pop(); // Close the dialog after 2 seconds
                      });
                      return; // Exit the method if no category is selected
                    }
                    _formKey.currentState?.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePostCon(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
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