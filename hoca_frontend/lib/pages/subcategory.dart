import 'package:flutter/material.dart';

class SubCategoryPage extends StatelessWidget {
  final String categoryTitle;

  SubCategoryPage({required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Text('This is the $categoryTitle page'),
      ),
    );
  }
}
