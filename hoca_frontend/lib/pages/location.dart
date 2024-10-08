import 'package:flutter/material.dart';
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
    Navigator.of(context).pop({
      'latitude': selectedLocation!.latitude,
      'longitude': selectedLocation!.longitude
    }); // Close the map after selection
  }

  Future<void> _showMap() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: GoogleMap(
            initialCameraPosition: _initialCameraPosition,
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
  Location location = Location();
  PermissionStatus permissionStatus = await location.requestPermission();

  if (permissionStatus == PermissionStatus.granted) {
    LocationData currentLocation = await location.getLocation();
    setState(() {
      selectedLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
    // Return the location back to HomePage
    Navigator.of(context).pop({
      'latitude': selectedLocation!.latitude,
      'longitude': selectedLocation!.longitude
    });
  } else {
    // Handle permission denied
    print('Location permission denied');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Back arrow in AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Choose Your Location',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Location icon using Image.asset
            Image.asset(
              'assets/images/location_icon.png', // Ensure this file exists in your assets
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'After clicking Locate Me, your location\nwill automatically find you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _locateMe, // Locate the user
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Locate Me',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _showMap, // Open map for manual selection
              child: const Text(
                'Add location manually',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
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
    );
  }
}
