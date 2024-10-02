 // Widget for the Review Tile
  import 'package:flutter/material.dart';

Widget buildReviewTile(String reviewerName, String reviewDate) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(reviewerName[0]),
      ),
      title: Text(reviewerName),
      subtitle: Text(reviewDate),
    );
  }
