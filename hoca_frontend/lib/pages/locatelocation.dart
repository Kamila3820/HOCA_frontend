import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocateLocationPage extends StatefulWidget {
  final LatLng? location;

  const LocateLocationPage({super.key, this.location});

  @override
  _LocateLocationPageState createState() => _LocateLocationPageState();
}

class _LocateLocationPageState extends State<LocateLocationPage> {
  LatLng? _selectedLocation;
  String? _selectedAddress;
  GoogleMapController? _mapController; 

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.location ?? LatLng(13.6523, 100.4940);
    _getAddress(_selectedLocation!);
    _checkPermissions();
  }

  void _showTopSnackBar(String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 10,
      ),
      dismissDirection: DismissDirection.up,
    );

    // Remove current SnackBar if any
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    // Show new SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateLocationUser() async {
      try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await Caller.dio.patch(
        '/v1/user/location/edit',
        data: {
          "location": _selectedAddress,
          "latitude": _selectedLocation?.latitude.toString(),
          "longtitude": _selectedLocation?.longitude.toString(),
        },
        options: Options(
          headers: {
            'x-auth-token': '$token',
          },
        ),    
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child: MainScreen(
              latitude: _selectedLocation!.latitude.toString(),
              longitude: _selectedLocation!.longitude.toString(),
              address: _selectedAddress,
            ),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          ),
        );
      } else {
        throw Exception('Failed to update location');
      }
    } catch (error) {
      _showTopSnackBar('Failed to update location: $error', isError: true);
    } 
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
    
    print("Placemark results: $placemarks"); // Print the placemark results for debugging

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      
      // Check what fields are available
      String fullAddress = [
        place.subLocality, 
        place.locality, 
        place.administrativeArea,
        place.postalCode,
        place.country // Include country as a fallback
      ].where((element) => element != null && element.isNotEmpty).join(", ");

      setState(() {
        _selectedAddress = fullAddress.isNotEmpty ? fullAddress : "Address not found";
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
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(
        Icons.location_on, // Choose the icon you want
        color: Colors.blue,
      ),
      SizedBox(width: 8), // Space between icon and text
      Text(
        'Location Details',
        style: TextStyle(
          color: Color.fromARGB(191, 0, 0, 0),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
  backgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.black),
  elevation: 0,
  centerTitle: true,
),

    body: _selectedAddress == null
        ? Center(child: CircularProgressIndicator()) // Loading indicator while fetching address
        : Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
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

                    // Move camera to the new location
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
                          updateLocationUser();
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
