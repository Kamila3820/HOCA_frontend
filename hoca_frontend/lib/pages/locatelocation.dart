import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'; // Add geocoding package for reverse geocoding
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocateLocationPage extends StatefulWidget {
  final LatLng? location; // Accept location as a parameter

  const LocateLocationPage({super.key, this.location});

  @override
  _LocateLocationPageState createState() => _LocateLocationPageState();
}

class _LocateLocationPageState extends State<LocateLocationPage> {
  LatLng? _selectedLocation;
  String? _selectedAddress;

  @override
  void initState() {
    super.initState();
    // Set the initial location to Bangkok if no location is provided
    _selectedLocation = widget.location ?? LatLng(13.7563, 100.5018);
    _getAddress(_selectedLocation!); // Get address for the initial location
    _checkPermissions(); // Check for location permissions
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }

  // Reverse geocode the location to get the address
  Future<void> _getAddress(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _selectedAddress =
              "${place.name}, ${place.locality}, ${place.country}";
        });
      }
    } catch (e) {
      print("Error fetching address: $e");
      setState(() {
        _selectedAddress = "Unknown location";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Location Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16, // Adjust font size
            fontWeight: FontWeight.w600, // Use a bolder weight to match Figma
          ),
        ),
        backgroundColor: Colors.white, // Match Figma background
        iconTheme:
            const IconThemeData(color: Colors.black), // Set icon color to black
        elevation: 0, // Remove app bar shadow
        centerTitle: true, // Center the title
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0), // Padding to match the Figma
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for your location',
                hintStyle: TextStyle(
                    color: Colors.black
                        .withOpacity(0.5)), // Adjust hint text color
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                filled: true,
                fillColor: Colors
                    .grey[200], // Match Figma background for the search bar
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12), // Add padding inside text field
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _selectedLocation!, // Use the selected location
                zoom: 14.0,
              ),
              markers: _selectedLocation != null
                  ? {
                      Marker(
                        markerId: const MarkerId('selected-location'),
                        position: _selectedLocation!,
                      ),
                    }
                  : {},
              onTap: (LatLng tappedLocation) {
                setState(() {
                  _selectedLocation = tappedLocation; // Update on map tap
                  _getAddress(
                      tappedLocation); // Fetch address for the new location
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_selectedLocation != null && _selectedAddress != null) {
                  Navigator.of(context).pop({
                    'latitude': _selectedLocation!.latitude,
                    'longitude': _selectedLocation!.longitude,
                    'address': _selectedAddress,
                  }); // Confirm with all necessary details
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF87C4FF), // Use light blue as in Figma
                minimumSize: const Size(
                    double.infinity, 48), // Adjust button height slightly
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8), // Match border radius from Figma
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontFamily: 'Poppins', // Set font to Poppins
                  fontSize: 25, // Adjust text size
                  fontWeight: FontWeight.bold, // Set text to bold
                  color: Color.fromARGB(
                      255, 255, 255, 255), // Set desired text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
