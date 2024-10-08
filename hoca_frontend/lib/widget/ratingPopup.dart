import 'package:flutter/material.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  final TextEditingController _experienceController = TextEditingController();
  bool _isExperienceFieldFocused = false;

  // Star rating states
  int _workRating = 0;
  int _securityRating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background container with rounded corners
          Container(
            margin: const EdgeInsets.only(top: 30), // Margin for title section overlap
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            width: 320,
            child: SingleChildScrollView( // Scrollable to avoid overflow
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40), // Space for title section overlap
                  // Work Rating
                  const Center(
                    child: Text(
                      'Work',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Centered text
                    ),
                  ),
                  // Row 1 for Work Rating (1 to 5)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < _workRating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            _workRating = index + 1; // Update work rating
                          });
                        },
                      );
                    }),
                  ),
                  // Row 2 for Work Rating (6 to 10)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index + 6 <= _workRating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            _workRating = index + 6; // Update work rating for second row
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  // Security Rating
                  const Center(
                    child: Text(
                      'Security',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Centered text
                    ),
                  ),
                  // Row 1 for Security Rating (1 to 5)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < _securityRating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            _securityRating = index + 1; // Update security rating
                          });
                        },
                      );
                    }),
                  ),
                  // Row 2 for Security Rating (6 to 10)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index + 6 <= _securityRating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            _securityRating = index + 6; // Update security rating for second row
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  // TextField for user experience
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Share your experience',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _experienceController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: _isExperienceFieldFocused
                          ? ''
                          : 'Let us know your great experience!',
                      hintStyle: const TextStyle(
                        fontSize: 14, // Decrease font size of hint text
                        color: Colors.grey, // Make the hint text grey
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    onTap: () {
                      setState(() {
                        _isExperienceFieldFocused = true; // Hide placeholder on focus
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        _isExperienceFieldFocused = false; // Show placeholder again
                      });
                      FocusScope.of(context).unfocus(); // Close the keyboard
                    },
                  ),
                  const SizedBox(height: 20),
                  // Send rating button
                  ElevatedButton(
                    onPressed: () {
                      // Handle send rating action
                      Navigator.pop(context); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor:Color(0xFF87C4FF), // Change the text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Round corners of the button
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Optional padding inside the button
                    ),
                    child: const Text('Send rating', style: TextStyle(
                                                      fontSize: 15, // Change the font size of the button text
                                                      fontWeight: FontWeight.bold, // Optionally make the text bold
                                                    ),),                   
                  ),
                ],
              ),
            ),
          ),
          // Title Section with background
          Positioned(
            top: 0,
            child: Container(
              height: 80,
              width: 320,
              decoration: const BoxDecoration(
                color: Color(0xFF87C4FF), // Blue background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Rating your experience!\nTo give recommend to a worker',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Close Button at the top-right corner
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
          ),
        ],
      ),
    );
  }
}
