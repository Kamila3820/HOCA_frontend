import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/reserve/PortraitLine.dart';
import 'package:hoca_frontend/components/reserve/ReviewDescription.dart';
import 'package:hoca_frontend/components/reserve/ReviewHeader.dart';
import 'package:hoca_frontend/components/reserve/ReviewTile.dart';
import 'package:hoca_frontend/components/reserve/SecurityRating.dart';
import 'package:hoca_frontend/components/reserve/WorkRating.dart';

class BuildReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewHeader(),
        const SizedBox(height: 10),
        Container(
          height: 150,
          child: ListView(
            children: [
              ReviewTile(name: 'Karl Anthony', date: '8/04/2024'),
              const SizedBox(height: 10),
              WorkRating(),
              const SizedBox(height: 5),
              SecurityRating(),
              const SizedBox(height: 10),
              ReviewDescription(),
              const SizedBox(height: 10),
              PortraitLine(),
              const SizedBox(height: 10),
              ReviewTile(name: 'James588', date: '20/03/2024'),
              const SizedBox(height: 10),
              WorkRating(),
              const SizedBox(height: 5),
              SecurityRating(),
            ],
          ),
        ),
      ],
    );
  }
}
