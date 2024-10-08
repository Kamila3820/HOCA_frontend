import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Google Maps
import 'package:hoca_frontend/components/createpostcon/CreatePostButton%20Widget.dart';
import 'package:hoca_frontend/components/createpostcon/FamilyAmountSelector%20Widget.dart';
import 'package:hoca_frontend/components/createpostcon/HeaderContainer.dart';
import 'package:hoca_frontend/components/createpostcon/LocationBox%20Widget.dart';
import 'package:hoca_frontend/components/createpostcon/WorkTypeSelector%20Widget.dart';
import 'package:hoca_frontend/pages/createpost/postlocation.dart'; // Import the new screen
import 'package:hoca_frontend/pages/home.dart';
import 'package:location/location.dart';

class CreatePostCon extends StatefulWidget {
  const CreatePostCon({super.key});

  @override
  _CreatePostConState createState() => _CreatePostConState();
}

class _CreatePostConState extends State<CreatePostCon> {
  final List<int> _selectedBoxIndices = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedFamilyAmount;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationData = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
    });
  }

  void _onLocationButtonPressed() async {
    if (_currentLocation == null) {
      // ตรวจสอบและขอตำแหน่งอีกครั้ง หาก _currentLocation เป็น null
      try {
        Location location = Location();
        LocationData _locationData = await location.getLocation();
        setState(() {
          _currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostLocation(initialLocation: _currentLocation!),
        ),
      );
    } else {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to get current location'),
        ),
      );
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
                onBackPressed: () {
                  Navigator.pop(context); // Go back to the previous page
                },
              ),

            ],
          ),
          LocationBox(),
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
          ),
          Positioned(
            top: 170,
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
          CreatePostButton(
            formKey: _formKey,
            selectedBoxIndices: _selectedBoxIndices,
            onPressed: () {
              if (_formKey.currentState!.validate() && _selectedBoxIndices.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              } else if (_selectedBoxIndices.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select at least one type of place to work'),
                  ),
                );
              }
            },
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
