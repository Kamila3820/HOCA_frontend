import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/reserve/PortraitLine.dart';
import 'package:hoca_frontend/components/reserve/ReviewDescription.dart';
import 'package:hoca_frontend/components/reserve/ReviewHeader.dart';
import 'package:hoca_frontend/components/reserve/ReviewTile.dart';
import 'package:hoca_frontend/components/reserve/SecurityRating.dart';
import 'package:hoca_frontend/components/reserve/WorkRating.dart';
import 'package:hoca_frontend/models/userrating.dart';

class BuildReviews extends StatelessWidget {
  final List<UserRating>? rating; // Changed to final since it's passed in constructor

  const BuildReviews({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewHeader(), // Static review header
        const SizedBox(height: 10),

        rating != null && rating!.isNotEmpty
            ? SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: rating!.length,
                  itemBuilder: (context, index) {
                    final userRating = rating![index];
                    return Column(
                      children: [
                        ReviewTile(
                          name: userRating.username!, // Dynamic name from the rating data
                          date: userRating.createdAt!, // Dynamic date from the rating data
                        ),
                        const SizedBox(height: 10),
                        WorkRating(score: userRating.workScore,), // Dynamic work rating
                        const SizedBox(height: 5),
                        SecurityRating(score: userRating.securityScore,), // Dynamic security rating
                        const SizedBox(height: 10),
                        ReviewDescription(comment: userRating.comment,), // Dynamic description
                        const SizedBox(height: 10),
                        PortraitLine(), // Static portrait line
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              )
            : const Center(
                child: Text('No reviews available'),
              ), // Show if no reviews
      ],
    );
  }
}
