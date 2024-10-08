import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class PostLocation extends StatefulWidget {
  final LatLng? initialLocation; // Nullable to allow default

  const PostLocation({Key? key, this.initialLocation}) : super(key: key);

  @override
  _PostLocationState createState() => _PostLocationState();
}

class _PostLocationState extends State<PostLocation> {
  LatLng _selectedLocation = const LatLng(13.7563, 100.5018); // Default Bangkok coordinates
  String? _selectedAddress;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    // If initialLocation is passed, use it; otherwise, default to Bangkok
    if (widget.initialLocation != null) {
      _selectedLocation = widget.initialLocation!;
    }
    _getAddressFromLatLng(_selectedLocation);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _selectedAddress =
              "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Use animateCamera to move the camera smoothly to the selected location
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    // Animate the camera to move to the selected location (Bangkok)
    _mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(_selectedLocation, 14.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Location Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _selectedLocation, // Use the selected location (Bangkok by default)
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('selected-location'),
                  position: _selectedLocation,
                ),
              },
              onTap: (LatLng tappedLocation) {
                setState(() {
                  _selectedLocation = tappedLocation;
                });
                _getAddressFromLatLng(tappedLocation);
              },
              onMapCreated: _onMapCreated, // Animate camera when the map is created
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_selectedLocation != null && _selectedAddress != null) {
                  Navigator.of(context).pop({
                    'location': _selectedLocation,
                    'address': _selectedAddress,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Confirm', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
