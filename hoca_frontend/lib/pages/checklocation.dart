import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/location.dart';
import 'package:hoca_frontend/pages/locatelocation.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';

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
      // Replace with your API endpoint
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
      }

      setState(() {
        _isLoading = false;
      });

      // Delay for 2 seconds, then navigate to another page based on location availability
      if (userLo != null && userLo!.location!.isNotEmpty) {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child: MainScreen(
              latitude: userLo?.latitude!,
              longitude: userLo?.longtitude!,
              address: userLo?.location!,
            ),
            duration: const Duration(milliseconds: 10000),
            curve: Curves.easeInOut,
          ),
        );
      } else {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocateLocationPage(),
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error checking user location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (userLo != null && userLo!.location!.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('User Location'),
        ),
        body: Center(
          child: Text(
            'Your current location:\n${userLo!.location}\nLatitude: ${userLo!.latitude}\nLongitude: ${userLo!.longtitude}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Locate Your Location!'),
        ),
        body: Center(
          child: Text(
            'Please choose the area to find worker.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
