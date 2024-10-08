import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LocationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 170,
      right: 30,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF87C4FF).withOpacity(0.6),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.penToSquare,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
