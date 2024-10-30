import 'package:flutter/material.dart';

class RatingSection extends StatefulWidget {
  final String title;
  final Function(int) onRatingUpdate;

  const RatingSection({super.key, required this.title, required this.onRatingUpdate});

  @override
  _RatingSectionState createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  int _rating = 0; // Combined rating for both rows (0 to 10)

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // First row of stars (1-5)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: index < _rating ? Colors.yellow : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1; // Update rating to the selected star
                     widget.onRatingUpdate(_rating);
                  });
                },
              );
            }),
          ),
          // Second row of stars (6-10)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  (index + 5) < _rating ? Icons.star : Icons.star_border,
                  color: (index + 5) < _rating ? Colors.yellow : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 6; // Update rating to the selected star (6-10)
                     widget.onRatingUpdate(_rating);
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
