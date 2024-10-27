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
  final int? selectedCategories;
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WorkerNameField(controller: workerNameController),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WorkingPriceField(controller: workingPriceController),
              const SizedBox(width: 20.0),
              PromptPayField(controller: idLineController),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GenderDropdown(
                gender: selectedGender,
                onChanged: onGenderChanged,
              ),
              const SizedBox(width: 20.0),
              PhoneNumberField(controller: phoneNumberController),
            ],
          ),
          const SizedBox(height: 15.0),
          CategoriesSection(
            selectedCategory: selectedCategories,
            toggleCategory: toggleCategory,
          ),
          const SizedBox(height: 5.0),
          DescriptionField(controller: descriptionController),
        ],
      ),
    );
  }
}
