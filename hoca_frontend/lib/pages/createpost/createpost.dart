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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Controllers
  late final Map<String, TextEditingController> _controllers;
  
  // Form state
  String _selectedGender = '';
  int? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _controllers = {
      'workerName': TextEditingController(),
      'workingPrice': TextEditingController(),
      'idLine': TextEditingController(),
      'phoneNumber': TextEditingController(),
      'description': TextEditingController(),
    };
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _toggleCategory(int category) {
    setState(() {
      _selectedCategory = _selectedCategory == category ? null : category;
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final formData = {
      "name": _controllers['workerName']!.text,
      "price": _controllers['workingPrice']!.text,
      "idLine": _controllers['idLine']!.text,
      "phoneNumber": _controllers['phoneNumber']!.text,
      "description": _controllers['description']!.text,
      "gender": _selectedGender,
      "categories": _selectedCategory,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePostCon(formData: formData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Stack(
          children: [
            const HeaderSection(title: "Create Worker"),
            
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildFormContainer(),
                    const SizedBox(height: 1),
                    _buildSubmitButton(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    
  }

  Widget _buildFormContainer() {
    return Container(
      // height: 690,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: FormContainer(
          workerNameController: _controllers['workerName']!,
          workingPriceController: _controllers['workingPrice']!,
          idLineController: _controllers['idLine']!,
          phoneNumberController: _controllers['phoneNumber']!,
          descriptionController: _controllers['description']!,
          selectedGender: _selectedGender,
          onGenderChanged: (value) {
            if (value != null) {
              setState(() => _selectedGender = value);
            }
          },
          selectedCategories: _selectedCategory,
          toggleCategory: _toggleCategory,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    final bool isButtonEnabled = _selectedCategory != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: isButtonEnabled ? _submitForm : null, // Button is null (disabled) when no category is selected
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: isButtonEnabled 
            ? const Color(0xFF87C4FF)  // Original color when enabled
            : Colors.grey.shade300,    // Grey color when disabled
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(200, 50),
        ),
        child: Text(
          'Next',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: isButtonEnabled ? Colors.white : Colors.grey.shade500, // Different text color when disabled
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}