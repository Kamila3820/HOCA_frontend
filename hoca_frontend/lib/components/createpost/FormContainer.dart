import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/createpost/CategoriesSection.dart';
import 'package:hoca_frontend/components/createpost/DescriptionField.dart';
import 'package:hoca_frontend/components/createpost/GenderDropdown.dart';
import 'package:hoca_frontend/components/createpost/PhoneNumberField.dart';
import 'package:hoca_frontend/components/createpost/PromptPayField.dart';
import 'package:hoca_frontend/components/createpost/WorkerNameField.dart';
import 'package:hoca_frontend/components/createpost/WorkingPriceField.dart';

class FormContainer extends StatelessWidget {
  final TextEditingController workerNameController;
  final TextEditingController workingPriceController;
  final TextEditingController idLineController;
  final TextEditingController phoneNumberController;
  final TextEditingController descriptionController;
  final String selectedGender;
  final Function(String?) onGenderChanged;
  final List<int>? selectedCategories;
  final Function(int) toggleCategory;

  const FormContainer({
    Key? key,
    required this.workerNameController,
    required this.workingPriceController,
    required this.idLineController,
    required this.phoneNumberController,
    required this.descriptionController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.selectedCategories,
    required this.toggleCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            WorkerNameField(controller: workerNameController),
            const SizedBox(height: 16.0),
            // First row with Working Price and ID Line
            Row(
              children: [
                Expanded(
                  child: WorkingPriceField(controller: workingPriceController),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: PromptPayField(controller: idLineController),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Second row with Gender and Phone Number
            Row(
              children: [
                Expanded(
                  child: GenderDropdown(
                    gender: selectedGender,
                    onChanged: onGenderChanged,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: PhoneNumberField(controller: phoneNumberController),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Categories section with proper spacing
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CategoriesSection(
                selectedCategories: selectedCategories!,
                toggleCategory: toggleCategory,
              ),
            ),
            const SizedBox(height: 16.0),
            // Description field at the bottom
            DescriptionField(controller: descriptionController),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}