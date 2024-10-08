import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'buildIcon.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildIconWithLabelWithColor(
                  icon: FontAwesomeIcons.home,
                  label: "Home",
                  isSelected: currentIndex == 0,
                  onTap: () => onItemTapped(0),
                ),
                buildIconWithLabelWithColor(
                  icon: Icons.history,
                  label: "History",
                  isSelected: currentIndex == 1,
                  onTap: () => onItemTapped(1),
                ),
                const SizedBox(width: 40),
                buildIconWithLabelWithColor(
                  icon: FontAwesomeIcons.fileAlt,
                  label: "Progress",
                  isSelected: currentIndex == 2,
                  onTap: () => onItemTapped(2),
                ),
                buildIconWithLabelWithColor(
                  icon: FontAwesomeIcons.userCircle,
                  label: "Profile",
                  isSelected: currentIndex == 3,
                  onTap: () => onItemTapped(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}