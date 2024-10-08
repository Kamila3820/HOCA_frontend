import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LatLng? selectedLocation;

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(13.736717, 100.523186), // Default location in Bangkok
    zoom: 12,
  );

  GoogleMapController? _mapController;

  Future<void> _locateMe() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print('Location permission denied');
        return;
      }
    }

    try {
      LocationData currentLocation = await location.getLocation();
      setState(() {
        selectedLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(selectedLocation!),
        );
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _confirmLocation() {
    if (selectedLocation != null) {
      Navigator.of(context).pushNamed(
        '/confirm',
        arguments: selectedLocation,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for your location'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCameraPosition,
              onTap: (LatLng position) {
                setState(() {
                  selectedLocation = position;
                });
              },
              markers: selectedLocation != null
                  ? {
                      Marker(
                        markerId: MarkerId('selectedLocation'),
                        position: selectedLocation!,
                      ),
                    }
                  : {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                selectedLocation != null
                    ? Text(
                        'Your Location is: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}',
                        style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                      )
                    : Text(
                        'Select a location on the map',
                        style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                      ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: selectedLocation == null ? null : _confirmLocation,
                  child: Text('Confirm'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color(0xFF87C4FF), // ใช้ backgroundColor แทน primary
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
}
