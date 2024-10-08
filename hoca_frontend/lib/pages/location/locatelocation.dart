import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateLocationPage extends StatefulWidget {
  final LatLng? location; // Accept location as a parameter

  const LocateLocationPage({super.key, this.location});

  @override
  _LocateLocationPageState createState() => _LocateLocationPageState();
}

class _LocateLocationPageState extends State<LocateLocationPage> {
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    
    _selectedLocation = widget.location ?? LatLng(13.7563, 100.5018); 
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
        iconTheme: const IconThemeData(color: Colors.black), // Set icon color to black
        elevation: 0, // Remove app bar shadow
        centerTitle: true, // Center the title
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding to match the Figma
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for your location',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)), // Adjust hint text color
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                filled: true,
                fillColor: Colors.grey[200], // Match Figma background for the search bar
                contentPadding: const EdgeInsets.symmetric(vertical: 12), // Add padding inside text field
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
                target: _selectedLocation!, 
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
                  _selectedLocation = tappedLocation; 
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_selectedLocation != null) {
                  Navigator.of(context).pop(_selectedLocation); 
                }
              },
              child: const Text('Confirm', style: TextStyle(fontSize: 16)), // Adjust text size
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue, // Use light blue as in Figma
                minimumSize: const Size(double.infinity, 48), // Adjust button height slightly
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Match border radius from Figma
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
