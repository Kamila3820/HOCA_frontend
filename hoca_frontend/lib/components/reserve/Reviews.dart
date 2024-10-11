import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/reserve/PortraitLine.dart';
import 'package:hoca_frontend/components/reserve/ReviewDescription.dart';
import 'package:hoca_frontend/components/reserve/ReviewHeader.dart';
import 'package:hoca_frontend/components/reserve/ReviewTile.dart';
import 'package:hoca_frontend/components/reserve/SecurityRating.dart';
import 'package:hoca_frontend/components/reserve/WorkRating.dart';
import 'package:hoca_frontend/models/userrating.dart';

class BuildReviews extends StatelessWidget {
  final List<UserRating>? rating; // List of user ratings
  final String? name; // Name to be passed to ReviewHeader

  const BuildReviews({super.key, required this.rating, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pass the name to ReviewHeader
        ReviewHeader(name: name ?? 'No Name Provided'), 
        const SizedBox(height: 10),

        // Check if rating is available and non-empty
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
                          name: userRating.username!, // Dynamic name from user rating
                          date: userRating.createdAt!, // Dynamic date from user rating
                        ),
                        const SizedBox(height: 10),
                        WorkRating(score: userRating.workScore,), // Dynamic work rating
                        const SizedBox(height: 5),
                        SecurityRating(score: userRating.securityScore,), // Dynamic security rating
                        const SizedBox(height: 10),
                        ReviewDescription(comment: userRating.comment,), // Dynamic review description
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
              ), // Fallback if no reviews are present
      ],
    );
  }
}

