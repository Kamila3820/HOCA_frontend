import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/createpost/FormContainer.dart';
import 'package:hoca_frontend/components/createpost/HeaderSection.dart';
import 'package:hoca_frontend/models/categories.dart';
import 'package:hoca_frontend/models/placetype.dart';
import 'package:hoca_frontend/models/post.dart';
import 'package:hoca_frontend/pages/editpost/editpostcon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPostPage extends StatefulWidget {
  final String postID;

  const EditPostPage({super.key, required this.postID});

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _workerNameController = TextEditingController();
  final TextEditingController _workingPriceController = TextEditingController();
  final TextEditingController _idLineController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? location;
  String? latitude;
  String? longitude;
  List<PlaceType>? placeTypes; // Capture place types as a list of PlaceType objects
  String? amntFamily;
  String? imageUrl;
  String _selectedGender = "Male";
  List<Categories> availableCategories = [];
  List<Categories> selectedCategories = []; // Updated to track selected categories
  bool _isLoading = true; // Add loading state
  bool _hasError = false; // Add error state

  @override
  void initState() {
    super.initState();
    _fetchPostData(widget.postID); // Fetch the post data when the page loads
  }

  Future<void> _fetchPostData(String postID) async {
    String url = "/v1/post/$postID";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await Caller.dio.get(
        url,
        options: Options(
          headers: {
            'x-auth-token': '$token', // Add token to header
          },
        ),
      );
      final post = Post.fromJson(response.data);

      // Populate the form fields with fetched post data
      _workerNameController.text = post.name ?? '';
      _workingPriceController.text = post.price.toString();
      _idLineController.text = post.promptPay ?? '';
      _phoneNumberController.text = post.phoneNumber ?? '';
      _descriptionController.text = post.description ?? '';
      _selectedGender = post.gender ?? "Male";
      selectedCategories = post.categoryID!.where((cat) => post.categoryID!.contains(cat.id)).toList();
      availableCategories = post.categoryID!;
      location = post.location;
      latitude = post.locationLat;
      longitude = post.locationLong;
      placeTypes = post.placeTypeID; // Capture place types as a list of PlaceType objects
      amntFamily = post.amountFamily;
      imageUrl = post.avatarUrl; // Capture image

      setState(() {
        _isLoading = false;
        _hasError = false;
      });
    } catch (error) {
      Caller.handle(context, error as DioError); // Handle error gracefully
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void toggleCategory(int categoryId) {
  setState(() {
    // Find the category by its ID
    final category = availableCategories.firstWhere((cat) => cat.id == categoryId);

    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else if (selectedCategories.length < 3) {
      selectedCategories.add(category);
    }
  });
}

  // Method to handle form submission
  void _submitForm() {
    // Check if a category is selected
    if (selectedCategories == null) {
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
      "categories": selectedCategories,
    };

    // If form is valid, navigate to EditPostCon and pass form data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPostCon(
          formData: formData,
          postID: widget.postID,
          location: location,
          latitude: latitude,
          longtitude: longitude,
          placeTypes: placeTypes,
          amountFamily: amntFamily,
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HeaderSection(title: "Edit Worker Post"),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _hasError
                  ? const Center(child: Text('Error loading post data'))
                  : Padding(
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
          workerNameController: _workerNameController,
          workingPriceController: _workingPriceController,
          idLineController: _idLineController,
          phoneNumberController: _phoneNumberController,
          descriptionController: _descriptionController,
          selectedGender: _selectedGender,
          onGenderChanged: (value) {
            if (value != null) {
              setState(() => _selectedGender = value);
            }
          },
          selectedCategories: selectedCategories.map((cat) => cat.id).toList(),
          toggleCategory: toggleCategory,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    final bool isButtonEnabled = selectedCategories != null;

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
