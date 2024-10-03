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
    _selectedLocation = widget.location ?? LatLng(13.652494, 100.494949); // Default to Thung Kru, Bangkok
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Location Details',
          style: TextStyle(color: Colors.black, fontSize: 18), // Align with prototype
        ),
        backgroundColor: Colors.white, // Match prototype background
        iconTheme: const IconThemeData(color: Colors.black), // Set icon color to black
        elevation: 0, // Remove app bar shadow
        centerTitle: true, // Center the title
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding to match the prototype
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for your location',
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                filled: true,
                fillColor: Colors.grey[200], // Match prototype background for the search bar
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
              child: const Text('Confirm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue, // Use light blue as in prototype
                minimumSize: const Size(double.infinity, 50), // Set button size to match the prototype
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded button as in prototype
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
