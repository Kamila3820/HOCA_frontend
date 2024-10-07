import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/reserve/reservesubservice.dart';

class TaskButtons extends StatelessWidget {
  const TaskButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReSubserviceWidget(text: 'Iron clothes'),
          const SizedBox(width: 8),
          ReSubserviceWidget(text: 'Mop Floor'),
          const SizedBox(width: 8),
          ReSubserviceWidget(text: 'Wash Dishes'),
        ],
      ),
    );
  }
}