import 'package:flutter/material.dart';
import 'package:hoca_frontend/models/placetype.dart';

class InfoList extends StatelessWidget {
  final String? location;
  final String? phoneNumber;
  List<PlaceType>? placeTypes;
  final String? amountPeople;
  final String? duration;
  final double? price;

  InfoList({
    super.key,
    required this.location,
    required this.phoneNumber,
    required this.placeTypes,
    required this.amountPeople,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    String placeTypeNames = placeTypes != null && placeTypes!.isNotEmpty
        ? placeTypes!.map((placeType) => placeType.name ?? "Unknown").join(" / ")
        : "Unknown";

    return Column(
      children: [
        buildInfoTile(Icons.location_on, location!),
        buildInfoTile(Icons.phone, phoneNumber!),
        buildInfoTile(Icons.home, placeTypeNames),
        buildInfoTile(Icons.people, 'Acceptable range of family size: $amountPeople'),
         buildInfoTile(Icons.av_timer, 'Max: ${duration}'),
        const SizedBox(height: 10), // Add some spacing
        Row(
          children: [
            Spacer(), // Pushes the price to the right
            Text(
              '฿ ${price?.toStringAsFixed(2) ?? "0.00"}', // Thai baht sign and price
              style: const TextStyle(
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 22, // Adjust the size as needed
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildInfoTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
