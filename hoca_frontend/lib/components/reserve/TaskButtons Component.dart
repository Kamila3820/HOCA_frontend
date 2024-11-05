import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/reserve/reservesubservice.dart';
import 'package:hoca_frontend/models/categories.dart';

class TaskButtons extends StatelessWidget {
 final List<Categories> categories;

  const TaskButtons({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReSubserviceWidget(categories: categories,),
        ],
      ),
    );
  }
}