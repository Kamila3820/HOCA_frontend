import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpost/FormContainer.dart';
import 'package:hoca_frontend/components/createpost/HeaderSection.dart';
import 'package:hoca_frontend/pages/createpost/createpostcon.dart';
import 'package:page_transition/page_transition.dart';

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
  final List<int> _selectedCategories = [];
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

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
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleCategory(int category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else if (_selectedCategories.length < 3) {
        _selectedCategories.add(category);
      }
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else if (_selectedCategories.length < 3) {
        _selectedCategories.add(category);
      }
    });
  }

// In CreatePostPage class, update the _submitForm method:

void _submitForm() {
  final formState = _formKey.currentState;
  if (formState == null) return;

  // Validate time selections
  bool isStartTimeValid = _startTime.hour != 0 || _startTime.minute != 0;
  bool isEndTimeValid = _endTime.hour != 0 || _endTime.minute != 0;
  
  setState(() {
    if (!isStartTimeValid) {
      // Handle start time error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a start time'),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (!isEndTimeValid) {
      // Handle end time error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an end time'),
          backgroundColor: Colors.red,
        ),
      );
    }
  });

  if (!formState.validate() || !isStartTimeValid || !isEndTimeValid) {
    return;
  }

    final formData = {
      "name": _controllers['workerName']!.text,
      "price": _controllers['workingPrice']!.text,
      "idLine": _controllers['idLine']!.text,
      "phoneNumber": _controllers['phoneNumber']!.text,
      "description": _controllers['description']!.text,
      "gender": _selectedGender,
      "categories": _selectedCategories.join(','),
      "availableStart": _startTime.toString(),
      "availableEnd": _endTime.toString(),
    };
Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.rightToLeft,
    child: CreatePostCon(formData: formData),
    duration: const Duration(milliseconds: 550),
    curve: Curves.easeInOut,
  ),
);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          selectedCategories: _selectedCategories,
          toggleCategory: _toggleCategory,
          startTime: _startTime,
          endTime: _endTime,
          onStartTimeChanged: (TimeOfDay time) {
            setState(() => _startTime = time);
          },
          onEndTimeChanged: (TimeOfDay time) {
            setState(() => _endTime = time);
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    final bool isButtonEnabled = _selectedCategories.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: isButtonEnabled ? _submitForm : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: isButtonEnabled 
            ? const Color(0xFF87C4FF)
            : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(200, 50),
        ),
        child: Text(
          'Next',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: isButtonEnabled ? Colors.white : Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
