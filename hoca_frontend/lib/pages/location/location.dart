import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart'; // Add this import for location services

import 'locatelocation.dart'; // Import locatelocation.dart

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LatLng? selectedLocation;

  // Initial position of the map
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(13.736717, 100.523186), // Example: Central Bangkok, Thailand
    zoom: 12,
  );

  // Navigate to the locate location screen
  void _navigateToLocateLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocateLocationPage(location: selectedLocation),
      ),
    );
  }

  void _onSelectLocation(LatLng location) {
    setState(() {
      selectedLocation = location;
    });
    Navigator.of(context).pop(); // Close the map after selection
  }

  Future<void> _showMap() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: GoogleMap(
            initialCameraPosition: _initialCameraPosition, // ใช้ _initialCameraPosition ที่นี่
            onTap: _onSelectLocation, // Allow selecting location by tapping
            markers: selectedLocation != null
                ? {
                    Marker(
                      markerId: const MarkerId('selected-location'),
                      position: selectedLocation!,
                    ),
                  }
                : {},
          ),
        );
      },
    );
  }

  Future<void> _locateMe() async {
    // Create an instance of the Location class
    Location location = Location();

    // Request permission
    PermissionStatus permissionStatus = await location.requestPermission();

    if (permissionStatus == PermissionStatus.granted) {
      // Get the current location
      LocationData currentLocation = await location.getLocation();
      setState(() {
        selectedLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
      // Navigate to locatelocation.dart after simulating "Locate Me"
      _navigateToLocateLocation();
    } else {
      // Handle permission denied
      print('Location permission denied');
      // Optionally, show a dialog or a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            height: 150.0,
            width: double.infinity,
            decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6), // 60% opacity
                ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color.fromARGB(255, 0, 0, 0), size: 35.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      'Choose Your Location',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Locate Me section
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Location icon using Image.asset
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/location_icon.png', // Ensure this file exists in your assets
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'After clicking Locate Me, your location\nwill automatically find you',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _locateMe, // Locate the user
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF87C4FF),
                      padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Locate Me',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (selectedLocation != null)
                    Text(
                      'Selected Location: (${selectedLocation!.latitude}, ${selectedLocation!.longitude})',
                      style: const TextStyle(fontSize: 14),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
