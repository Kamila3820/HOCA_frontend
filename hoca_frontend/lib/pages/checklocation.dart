import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/location.dart';
import 'package:hoca_frontend/pages/locatelocation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckUserLocationPage extends StatefulWidget {
  @override
  _CheckUserLocationPageState createState() => _CheckUserLocationPageState();
}

class _CheckUserLocationPageState extends State<CheckUserLocationPage> {
  bool _isLoading = true;
  Location? userLo;
  String? location;
  String? latitude;
  String? longtitude;

  @override
  void initState() {
    super.initState();
    _checkUserLocation();
  }

  Future<void> _checkUserLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    try {
      final response = await Caller.dio.get(
        '/v1/user/location',
        options: Options(
          headers: {
            'x-auth-token': '$token',
          },
        ),
      );

      if (response.statusCode == 200) {
        userLo = Location.fromJson(response.data);
        if (userLo != null) {
          setState(() {
            location = userLo?.location!;
            latitude = userLo?.latitude!;
            longtitude = userLo?.longtitude!;
          });
        }

        // Navigate based on whether location exists
        if (userLo != null && userLo!.location!.isNotEmpty) {
          if (mounted) {  // Check if widget is still mounted
            Navigator.of(context).pushReplacement(
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: MainScreen(
                  latitude: userLo?.latitude!,
                  longitude: userLo?.longtitude!,
                  address: userLo?.location!,
                ),
                duration: const Duration(milliseconds: 300),  // Reduced duration
                curve: Curves.easeInOut,
              ),
            );
          }
        } else {
          if (mounted) {  // Check if widget is still mounted
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LocateLocationPage(),
              ),
            );
          }
        }
      } else {
        // Handle non-200 status code
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LocateLocationPage(),
            ),
          );
        }
      }
    } catch (e) {
      print('Error checking user location: $e');
      // Navigate to LocateLocationPage on error
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LocateLocationPage(),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Text(
                'Please choose the area to find worker.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}