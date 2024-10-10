import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/createpost/CategoriesSection.dart';
import 'package:hoca_frontend/components/createpost/DescriptionField.dart';
import 'package:hoca_frontend/components/createpost/GenderDropdown.dart';
import 'package:hoca_frontend/components/createpost/IdLineField.dart';
import 'package:hoca_frontend/components/createpost/PhoneNumberField.dart';
import 'package:hoca_frontend/components/createpost/WorkerNameField.dart';
import 'package:hoca_frontend/components/createpost/WorkingPriceField.dart';

class FormContainer extends StatelessWidget {
  final List<String> selectedCategories;
  final Function(String) toggleCategory;

  const FormContainer({
    super.key,
    required this.selectedCategories,
    required this.toggleCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 720,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WorkerNameField(),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WorkingPriceField(),
                const SizedBox(width: 20.0),
                IdLineField(),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderDropdown(),
                const SizedBox(width: 20.0),
                PhoneNumberField(),
              ],
            ),
            const SizedBox(height: 15.0),
            CategoriesSection(
              selectedCategories: selectedCategories,
              toggleCategory: toggleCategory,
            ),
            const SizedBox(height: 5.0),
            DescriptionField(),
          ],
        ),
      ),
    );
  }
}