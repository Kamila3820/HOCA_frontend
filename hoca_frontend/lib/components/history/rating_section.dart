import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingSection extends StatefulWidget {
  final String title;

  const RatingSection({Key? key, required this.title}) : super(key: key);

  @override
  _RatingSectionState createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  int _firstRowRating = 0; // Rating for the first row (0 to 5)
  int _secondRowRating = 0; // Rating for the second row (0 to 5)

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // First row of stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _firstRowRating ? Icons.star : Icons.star_border,
                  color: index < _firstRowRating ? Colors.yellow : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (_firstRowRating == 5 && index < _firstRowRating) {
                      // If reducing stars and already at max, reduce count
                      _firstRowRating = index;
                    } else if (_firstRowRating < 5) {
                      // Allow increasing stars until max of 5
                      _firstRowRating = index + 1;
                    }

                    // Adjust second row rating if total exceeds 10
                    if (_firstRowRating + _secondRowRating > 10) {
                      _secondRowRating = 10 - _firstRowRating; // Cap second row rating
                    }
                  });
                },
              );
            }),
          ),
          // Second row of stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _secondRowRating ? Icons.star : Icons.star_border,
                  color: index < _secondRowRating ? Colors.yellow : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (_secondRowRating == 5 && index < _secondRowRating) {
                      // If reducing stars and already at max, reduce count
                      _secondRowRating = index;
                    } else if (_secondRowRating < 5) {
                      // Allow increasing stars until max of 5
                      _secondRowRating = index + 1;
                    }

                    // Adjust first row rating if total exceeds 10
                    if (_firstRowRating + _secondRowRating > 10) {
                      _firstRowRating = 10 - _secondRowRating; // Cap first row rating
                    }
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
