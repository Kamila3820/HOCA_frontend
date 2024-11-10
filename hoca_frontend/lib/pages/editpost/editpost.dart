import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/createpost/FormContainer.dart';
import 'package:hoca_frontend/components/createpost/HeaderSection.dart';
import 'package:hoca_frontend/models/categories.dart';
import 'package:hoca_frontend/models/placetype.dart';
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
  
  // Controllers for form fields
  final TextEditingController _workerNameController = TextEditingController();
  final TextEditingController _workingPriceController = TextEditingController();
  final TextEditingController _idLineController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  // Time variables
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  
  // Variables for data state and UI
  String? location;
  String? latitude;
  String? longitude;
  List<PlaceType>? placeTypes;
  String? amntFamily;
  String? duration;
  String? imageUrl;
  String _selectedGender = "Male";
  List<Categories?> availableCategories = [];
  List<Categories?> selectedCategories = []; // Updated to track selected categories
  bool _isLoading = true; // Add loading state
  bool _hasError = false; // Add error state
  final List<Categories> mockCategories = [
  Categories(id: 1, groupID: 1, name: 'Deep cleaning', description: 'Cleaning'),
  Categories(id: 2, groupID: 1, name: 'Floor care', description: 'Cleaning'),
  Categories(id: 3, groupID: 1, name: 'Window care', description: 'Cleaning'),
  Categories(id: 4, groupID: 2, name: 'Laundry', description: 'Clothes'),
  Categories(id: 5, groupID: 2, name: 'Sewing', description: 'Clothes'),
  Categories(id: 6, groupID: 3, name: 'Lawn Mowing', description: 'Garden'),
  Categories(id: 7, groupID: 3, name: 'Watering', description: 'Garden'),
  Categories(id: 8, groupID: 3, name: 'Yard cleanup', description: 'Garden'),
  Categories(id: 9, groupID: 4, name: 'Pet sitting', description: 'Pets'),
];

  TimeOfDay parseTime(String timeString) {
    // Split time and period (AM/PM)
    final timeParts = timeString.split(' ');
    final time = timeParts[0];
    final period = timeParts[1];

    // Split hour and minute
    final timeSplit = time.split(':');
    int hour = int.parse(timeSplit[0]);
    int minute = int.parse(timeSplit[1]);

    // Convert to 24-hour format if needed
    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void initState() {
    super.initState();
    // Initialize with default times
     _startTime = const TimeOfDay(hour: 9, minute: 0);
    _endTime = const TimeOfDay(hour: 17, minute: 0);
    _fetchPostData(widget.postID);
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
            'x-auth-token': '$token',
          },
        ),
      );
      print("API Response: ${response.data}");
      final data = response.data;
      if (data == null) throw Exception('No data received');

      List<Categories> categories = (response.data['categories'] as List)
        .map((category) => Categories(
              id: category['id'],
              groupID: category['group_id'],
              name: category['name'],
              description: category['description'],
            ))
        .toList();

    // Convert place types from API response
    List<PlaceType> placeTypesList = (response.data['place_types'] as List)
        .map((placeType) => PlaceType(
              id: placeType['id'],
              name: placeType['name'],
              description: placeType['description'],
            ))
        .toList();

      // Update state with safe null checks
    setState(() {
      try {
        _workerNameController.text = data['name']?.toString() ?? '';
        _workingPriceController.text = (data['price']?.toString() ?? '0');
        _idLineController.text = data['prompt_pay']?.toString() ?? '';
        _phoneNumberController.text = data['phone_number']?.toString() ?? '';
        _descriptionController.text = data['description']?.toString() ?? '';
        _selectedGender = data['gender']?.toString() ?? 'Male';
        
        selectedCategories = List<Categories>.from(categories);
        availableCategories = mockCategories;
        
        location = data['location']?.toString();
        latitude = data['latitude']?.toString();
        longitude = data['longitude']?.toString();
        placeTypes = List<PlaceType>.from(placeTypesList);
        amntFamily = data['amount_family']?.toString();
        duration = data['duration']?.toString();
        imageUrl = data['avatar']?.toString();

        // Safely parse times
        if (data['available_start'] != null) {
          try {
            _startTime = parseTime(data['available_start']);
          } catch (e) {
            print('Error parsing start time: $e');
            _startTime = const TimeOfDay(hour: 9, minute: 0);
          }
        }

        if (data['available_end'] != null) {
          try {
            _endTime = parseTime(data['available_end']);
          } catch (e) {
            print('Error parsing end time: $e');
            _endTime = const TimeOfDay(hour: 17, minute: 0);
          }
        }

        _isLoading = false;
        _hasError = false;
      } catch (e) {
        print('Error in setState: $e');
        _isLoading = false;
        _hasError = true;
      }
    });
    } on DioError catch (dioError) {
        // Handle Dio-specific error
        Caller.handle(context, dioError);
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      } catch (error) {
        // Handle any other type of error, including RangeError
        print('Unexpected error: $error');
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
  }

 void toggleCategory(int categoryId) {
  setState(() {
    // Check if the category is already selected
    final exists = selectedCategories.any((cat) => cat?.id == categoryId);

    if (exists) {
      // Remove the category if it already exists
      selectedCategories.removeWhere((cat) => cat?.id == categoryId);
    } else if (selectedCategories.length < 3) {
      // Safely return a default category or just skip if not found
      final category = availableCategories.firstWhere(
        (cat) => cat?.id == categoryId,
        orElse: () => Categories(id: -1, groupID: -1, name: 'Unknown', description: 'N/A'),
      );

      // Only add the category if it is not the placeholder with id -1
      if (category?.id != -1) {
        selectedCategories.add(category);
      }
    }
  });
}





  void _submitForm() {
    if (selectedCategories.isEmpty || _workerNameController.text.isEmpty) {
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

    String categoriesString = selectedCategories.map((cat) => cat?.id.toString()).join(',');

    Map<String, dynamic> formData = {
      "name": _workerNameController.text,
      "price": _workingPriceController.text,
      "idLine": _idLineController.text,
      "phoneNumber": _phoneNumberController.text,
      "description": _descriptionController.text,
      "gender": _selectedGender,
      "categories": categoriesString,
    };

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
          duration: duration,
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
          selectedCategories: selectedCategories.map((cat) => cat?.id).toList(),
          toggleCategory: toggleCategory,
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
    final bool isButtonEnabled = selectedCategories.isNotEmpty;

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