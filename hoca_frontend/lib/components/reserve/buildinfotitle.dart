  // Widget for the Info Tiles
  import 'package:flutter/material.dart';

Widget buildInfoTile(String info, IconData icon, Color iconColor) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(info),
    );
  }