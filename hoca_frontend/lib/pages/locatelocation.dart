import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateLocationPage extends StatelessWidget {
  final LatLng? location; // Accept location as a parameter

  const LocateLocationPage({super.key, this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (location != null) ...[
              Text(
                'Selected Location:',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Latitude: ${location!.latitude}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Longitude: ${location!.longitude}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // You can implement further actions, such as saving the location
                  Navigator.of(context).pop(); // Navigate back
                },
                child: const Text('Done'),
              ),
            ] else ...[
              const Text(
                'No location selected.',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
