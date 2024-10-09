import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocateLocationPage extends StatefulWidget {
  final LatLng? location;

  const LocateLocationPage({super.key, this.location});

  @override
  _LocateLocationPageState createState() => _LocateLocationPageState();
}

class _LocateLocationPageState extends State<LocateLocationPage> {
  LatLng? _selectedLocation;
  String? _selectedAddress;
  GoogleMapController? _mapController; // เพิ่มตัวแปรสำหรับ GoogleMapController

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.location ?? LatLng(13.7563, 100.5018);
    _getAddress(_selectedLocation!);
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }

  Future<void> _getAddress(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _selectedAddress = "${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''} ${place.postalCode ?? ''}".trim();
          if (_selectedAddress!.isEmpty) {
            _selectedAddress = "Address not found";
          }
        });
      } else {
        setState(() {
          _selectedAddress = "Address not found";
        });
      }
    } catch (e) {
      print("Error fetching address: $e");
      setState(() {
        _selectedAddress = "Address not found";
      });
    }
  }

  // เพิ่มเมธอดนี้เพื่อให้สามารถเก็บ GoogleMapController ได้
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
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
              onMapCreated: _onMapCreated, // ตั้งค่า controller
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
                  _getAddress(tappedLocation);
                });

                // ใช้ animateCamera เพื่อเลื่อนกล้องไปที่ตำแหน่งใหม่
                _mapController?.animateCamera(
                  CameraUpdate.newLatLng(tappedLocation),
                );
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
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF87C4FF),
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
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
