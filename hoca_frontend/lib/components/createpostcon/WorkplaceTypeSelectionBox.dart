import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkplaceTypeSelectionBox extends StatelessWidget {
  final int? selectedIndex;
  final Function(int) onBoxTapped;

  const WorkplaceTypeSelectionBox({
    super.key,
    required this.selectedIndex,
    required this.onBoxTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 320,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose acceptable type of place to work',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => onBoxTapped(0),
                child: _buildBox('House', 'assets/images/House.png', 0),
              ),
              GestureDetector(
                onTap: () => onBoxTapped(1),
                child: _buildBox('Room of condo or apartment', 'assets/images/Room.png', 1),
              ),
              GestureDetector(
                onTap: () => onBoxTapped(2),
                child: _buildBox('Dormitory room', 'assets/images/Domi.png', 2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBox(String label, String imagePath, int index) {
    bool isSelected = selectedIndex == index;
    return Container(
      width: 110,
      height: 100,
      decoration: BoxDecoration(
        color: isSelected ? const Color.fromARGB(255, 135, 195, 255) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: isSelected ? Colors.white : const Color.fromARGB(255, 0, 0, 0),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
