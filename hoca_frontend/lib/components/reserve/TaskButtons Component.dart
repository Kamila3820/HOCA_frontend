import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/reserve/reservesubservice.dart';

class TaskButtons extends StatelessWidget {
  final int? categoryID;

  const TaskButtons({super.key, required this.categoryID});

  @override
  Widget build(BuildContext context) {
    String categoryType = "";

    if (categoryID == 1) {
      categoryType = "Deep cleaning";
    }
    if (categoryID == 2) {
      categoryType = "Floor care";
    }
    if (categoryID == 3) {
      categoryType = "Window care";
    }
    if (categoryID == 4) {
      categoryType = "Laundry";
    }
    if (categoryID == 5) {
      categoryType = "Sewing";
    }
    if (categoryID == 6) {
      categoryType = "Lawn mowing";
    }
    if (categoryID == 7) {
      categoryType = "Watering";
    }
    if (categoryID == 8) {
      categoryType = "Yard cleanup";
    }
    if (categoryID == 9) {
      categoryType = "Pet sitting";
    }


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReSubserviceWidget(text: categoryType),
        ],
      ),
    );
  }
}