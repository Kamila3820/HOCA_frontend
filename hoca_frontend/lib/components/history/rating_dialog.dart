import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'rating_section.dart';

void showRatingDialog(BuildContext context) {
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
              )),
              const SizedBox(height: 16),
              Center(child: RatingSectionWithIcon(
                title: 'Security',
                tooltipMessage: 'Rate how safe and secure you felt during the service',
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
                    Navigator.of(context).pop();
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

class RatingSectionWithIcon extends StatefulWidget {
  final String title;
  final String tooltipMessage;

  const RatingSectionWithIcon({
    Key? key, 
    required this.title,
    required this.tooltipMessage,
  }) : super(key: key);

  @override
  State<RatingSectionWithIcon> createState() => _RatingSectionWithIconState();
}

class _RatingSectionWithIconState extends State<RatingSectionWithIcon> {
  final GlobalKey _tooltipKey = GlobalKey();
  
  void _showTooltip() {
    final dynamic tooltip = _tooltipKey.currentState;
    tooltip?.ensureTooltipVisible();
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
            RatingSection(title: ''),
          ],
        ),
      ],
    );
  }
}