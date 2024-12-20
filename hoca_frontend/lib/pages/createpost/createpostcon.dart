import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Google Maps
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/createpostcon/FamilyAmountSelector%20Widget.dart';
import 'package:hoca_frontend/components/createpostcon/HeaderContainer.dart';
import 'package:hoca_frontend/components/createpostcon/LocationBox%20Widget.dart';
import 'package:hoca_frontend/components/createpostcon/WorkTypeSelector%20Widget.dart';
import 'package:hoca_frontend/components/register/image_picker_section.dart';
import 'package:hoca_frontend/pages/createpost/postlocation.dart'; // Import the new screen
import 'package:hoca_frontend/pages/mngPost.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostCon extends StatefulWidget {
  final Map<String, dynamic>? formData;

  const CreatePostCon({super.key, this.formData});

  @override
  _CreatePostConState createState() => _CreatePostConState();
}

class _CreatePostConState extends State<CreatePostCon> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _imageSelected = false;
  final List<int> _selectedBoxIndices = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedFamilyAmount;
  String? _selectedDuration;
  LatLng? _currentLocation;
  String _locationName = "Choose Your Location"; // Default location text
  bool _isDurationSelected = false;
  

  String convertIndicesToPlacetypeIDs(List<int> selectedIndices) {
    return selectedIndices.map((index) => (index + 1).toString()).join(',');
  }


  @override
  void initState() {
    super.initState();

     WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getCurrentLocation();
    });
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    locationData = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });
  }

  void _onLocationButtonPressed() async {
    if (_currentLocation == null) {
      // ตรวจสอบและขอตำแหน่งอีกครั้ง หาก _currentLocation เป็น null
      try {
        Location location = Location();
        LocationData locationData = await location.getLocation();
        setState(() {
          _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to get current location'),
          ),
        );
        return; // ออกจากฟังก์ชันหากไม่สามารถหาตำแหน่งได้
      }
    }

    if (_currentLocation != null) {
      // Navigate to PostLocation page and wait for result
      final result = await Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.topToBottom,
    child: PostLocation(initialLocation: _currentLocation!),
    duration: const Duration(milliseconds: 550),
    curve: Curves.easeInOut,
  ),
);


      // Check if result is not null and update _locationName
      if (result != null) {
        setState(() {
          _locationName = result['address']; // Update the location name with the selected address
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to get current location'),
        ),
      );
    }
  }

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
      if (_selectedBoxIndices.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one type of place to work'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (!_imageSelected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload or take a photo.'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (!_isDurationSelected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select duration'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (_locationName == "Choose Your Location") {  // Add this condition
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your location'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        callCreatePost();
      }
    }
  }


  void callCreatePost() async {
    try {
      // Prepare image file if selected
      MultipartFile? imageFile;
      if (_image != null) {
        imageFile = await MultipartFile.fromFile(_image!.path);
      }

      String placetypeIDs = convertIndicesToPlacetypeIDs(_selectedBoxIndices);

      FormData formData = FormData.fromMap({
        "name": widget.formData?["name"],
        "description": widget.formData?["desciption"],
        "file": imageFile,
        "category_ids": widget.formData?["categories"],
        "placetype_ids": placetypeIDs,
        "phone_number": widget.formData?["phoneNumber"],
        "location": _locationName,  // Updated to use selected location name
        "latitude": _currentLocation?.latitude.toString() ?? "13.7563",  // Updated to use actual latitude
        "longtitude": _currentLocation?.longitude.toString() ?? "100.5018",  // Updated to use actual longitude
        "price": widget.formData?["price"],
        "prompt_pay": widget.formData?["idLine"],
        "gender": widget.formData?["gender"],
        "amount_family": _selectedFamilyAmount,
        "duration": _selectedDuration,
        "available_start": widget.formData?["availableStart"],
        "available_end": widget.formData?["availableEnd"],
      });

      print(widget.formData?["categories"]);
      print(widget.formData?["availableStart"]);
      print(widget.formData?["availableEnd"]);
      print(_locationName);
      print(_currentLocation?.latitude.toString());
      print( _currentLocation?.longitude.toString());
      print(_selectedDuration);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      await Caller.dio.post("/v1/post/create", data: formData, options: Options(
        headers: {
          'x-auth-token': '$token', 
        },
      ),);


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ManagePostPage()),
      );
    } on DioException catch (error) {
      // Handle error
      Caller.handle(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderContainer(
              title: "Create Worker",
              onBackPressed: () {
                Navigator.pop(context); // Go back to the previous page
              },
            ),
          ],
        ),
        // Show the selected location name in the LocationBox widget
        LocationBox(locationName: _locationName),
        WorkTypeSelector(
          selectedBoxIndices: _selectedBoxIndices,
          onBoxTapped: _onBoxTapped,
        ),
         FamilyAmountSelector(
            formKey: _formKey,
            selectedFamilyAmount: _selectedFamilyAmount,
            onFamilyAmountChanged: (value) {
              setState(() {
                _selectedFamilyAmount = value;
              });
            },
            onDurationSelected: (selected) {
              setState(() {
                _isDurationSelected = selected;
                print("Testttttttt Duration");
                print(_isDurationSelected);
              });
            },
            durationForm: (value) {
              setState(() {
                _selectedDuration = value;
                print("Testttttttt Duration");
                print(_selectedDuration);
              });
            },
          ),
        Positioned(
          top: 155,
          right: 30,
          child: GestureDetector(
            onTap: _onLocationButtonPressed, // Navigate to PostLocation page
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF87C4FF).withOpacity(0.6),  
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        // Positioned ImagePicker and Create Post Button at the bottom
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Upload worker avatar",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7A7777),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ImagePickerSection(
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
              ),
              const SizedBox(height: 16),
              Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: (_imageSelected && _isDurationSelected && _locationName != "Choose Your Location") 
          ? _validateForm 
          : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: (_imageSelected && _isDurationSelected && _locationName != "Choose Your Location")
              ? const Color(0xFF87C4FF)
              : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          "Create Post",
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
            ],
          ),
        ),
      ],
    ),
  );
}


  void _onBoxTapped(int index) {
    setState(() {
      if (_selectedBoxIndices.contains(index)) {
        _selectedBoxIndices.remove(index);
      } else {
        _selectedBoxIndices.add(index);
      }
    });
  }
}
