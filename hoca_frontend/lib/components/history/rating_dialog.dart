import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'rating_section.dart';

void showRatingDialog(BuildContext context, String historyID, Function reloadData) {
  int? workScore; // For work score rating
  int? securityScore; // For security score rating
  final TextEditingController commentController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF87C4FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Rating your experience!\nTo give recommend to a worker',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.close, color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(child: RatingSectionWithIcon(
                title: 'Work',
                tooltipMessage: 'Rate the quality and efficiency of the work performed',
                onRatingUpdate: (rating) {
                    workScore = rating; // Update work score
                },
              )),
              const SizedBox(height: 16),
              Center(child: RatingSectionWithIcon(
                title: 'Security',
                tooltipMessage: 'Rate how safe and secure you felt during the service',
                onRatingUpdate: (rating) {
                    securityScore = rating; // Update security score
                },
              )),
              const SizedBox(height: 16),
              Text(
                'Share your experience',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Let us know your great experience!',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (workScore != null && securityScore != null) {
                      _submitRating(context, historyID, workScore!, securityScore!, commentController.text, reloadData);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please provide ratings for both Work and Security.'))
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF87C4FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Send rating',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _submitRating(BuildContext context, String historyID, int workScore, int securityScore, String comment, Function reloadData) async {
  try {
    final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      await Caller.dio.post("/v1/rating/create/$historyID", 
      data: {
        "work_score": workScore,
        "security_score": securityScore,
        "comment": comment
      }, 
      options: Options(
        headers: {
          'x-auth-token': '$token', 
        },
      ),);

      Navigator.of(context).pop();
      Future.delayed(Duration(seconds: 3));
      _showSuccessPopup(context);
      reloadData();

  } on DioException catch (error) {
      // Handle error
      Caller.handle(context, error);
  }
}

void _showSuccessPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissal by tapping outside
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Close the dialog automatically
      });

      return AlertDialog(
        title: Text('Success'),
        content: Text('Your rating has been submitted successfully.'),
      );
    },
  );
}

class RatingSectionWithIcon extends StatefulWidget {
  final String title;
  final String tooltipMessage;
  final Function(int) onRatingUpdate; // Add callback to get rating

  const RatingSectionWithIcon({
    Key? key, 
    required this.title,
    required this.tooltipMessage,
    required this.onRatingUpdate
  }) : super(key: key);

  @override
  State<RatingSectionWithIcon> createState() => _RatingSectionWithIconState();
}

class _RatingSectionWithIconState extends State<RatingSectionWithIcon> {
  final GlobalKey _tooltipKey = GlobalKey();
  int _rating = 0;
  
  void _showTooltip() {
    final dynamic tooltip = _tooltipKey.currentState;
    tooltip?.ensureTooltipVisible();
  }

  void _updateRating(int rating) {
    setState(() {
      _rating = rating;
    });
    widget.onRatingUpdate(_rating); // Pass rating to parent via callback
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _showTooltip,
                  child: Tooltip(
                    key: _tooltipKey,
                    message: widget.tooltipMessage,
                    preferBelow: false,
                    verticalOffset: -5,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(16),
                    triggerMode: TooltipTriggerMode.manual, // Make tooltip manual
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    textStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(192, 0, 0, 0),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.help,
                      child: FaIcon(
                        FontAwesomeIcons.circleQuestion,
                        size: 17,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            RatingSection(title: '', onRatingUpdate: _updateRating,),
          ],
        ),
      ],
    );
  }
}