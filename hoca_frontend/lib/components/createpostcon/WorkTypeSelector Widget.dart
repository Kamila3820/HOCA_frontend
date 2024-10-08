import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkTypeSelector extends StatelessWidget {
  final List<int> selectedBoxIndices;
  final Function(int) onBoxTapped;

  const WorkTypeSelector({
    required this.selectedBoxIndices,
    required this.onBoxTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 280,
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
          const SizedBox(height: 10.0),
          if (selectedBoxIndices.isEmpty) 
            Center(
              child: Text(
                'Please select at least one type of place to work',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.red, 
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          else
            const SizedBox(height: 18.0),
        ],
      ),
    );
  }

  Widget _buildBox(String label, String imagePath, int index) {
    final bool isSelected = selectedBoxIndices.contains(index);

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
        border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}