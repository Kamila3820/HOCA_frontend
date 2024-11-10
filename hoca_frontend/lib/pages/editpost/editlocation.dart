import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PostLocation extends StatefulWidget {
  final LatLng? initialLocation;

  const PostLocation({super.key, this.initialLocation});

  @override
  _PostLocationState createState() => _PostLocationState();
}

class _PostLocationState extends State<PostLocation> {
static const LatLng _bangkokLocation = LatLng(13.6523, 100.4940);
  late LatLng _selectedLocation;
  String? _selectedAddress;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation ?? _bangkokLocation;
    _getAddressFromLatLng(_selectedLocation);
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
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
          _selectedAddress = "${place.subLocality} ${place.locality}, ${place.administrativeArea} ${place.postalCode}";
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        _selectedAddress = "Unknown location";
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.animateCamera(CameraUpdate.newLatLngZoom(_bangkokLocation, 14.0));
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
                target: _selectedLocation,
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
              onMapCreated: _onMapCreated,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_selectedAddress != null) {
                  Navigator.of(context).pop({
                    'latitude': _selectedLocation.latitude,
                    'longitude': _selectedLocation.longitude,
                    'address': _selectedAddress,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF87C4FF),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
