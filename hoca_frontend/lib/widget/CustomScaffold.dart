import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/navbar/creatpostbutton.dart';
import 'package:hoca_frontend/components/navbar/customnavbar.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final int currentIndex;
  final Function(int) onItemTapped;

  const CustomScaffold({
    Key? key,
    required this.body,
    required this.title,
    required this.currentIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onItemTapped: onItemTapped,
      ),
      floatingActionButton: const CustomFloatingActionButton(
        onPressed: null, // Implement your onPressed logic here
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}