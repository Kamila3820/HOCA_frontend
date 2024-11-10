import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpost/CategoriesSection.dart';
import 'package:hoca_frontend/components/createpost/DescriptionField.dart';
import 'package:hoca_frontend/components/createpost/GenderDropdown.dart';
import 'package:hoca_frontend/components/createpost/PhoneNumberField.dart';
import 'package:hoca_frontend/components/createpost/PromptPayField.dart';
import 'package:hoca_frontend/components/createpost/WorkerNameField.dart';
import 'package:hoca_frontend/components/createpost/WorkingPriceField.dart';
import 'package:hoca_frontend/components/createpost/timefield.dart';

class FormContainer extends StatelessWidget {
  final TextEditingController workerNameController;
  final TextEditingController workingPriceController;
  final TextEditingController idLineController;
  final TextEditingController phoneNumberController;
  final TextEditingController descriptionController;
  final String selectedGender;
  final Function(String?) onGenderChanged;
  final List<int> selectedCategories;
  final Function(int) toggleCategory;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Function(TimeOfDay) onStartTimeChanged;
  final Function(TimeOfDay) onEndTimeChanged;

  const FormContainer({
    super.key,
    required this.workerNameController,
    required this.workingPriceController,
    required this.idLineController,
    required this.phoneNumberController,
    required this.descriptionController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.selectedCategories,
    required this.toggleCategory,
    required this.startTime,
    required this.endTime,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged, 
  });

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
            // Time selection row
           Row(
  crossAxisAlignment: CrossAxisAlignment.end, 
  children: [
    Expanded(
      child: TimeField(
        selectedTime: startTime,
        onTimeChanged: onStartTimeChanged,
        label: 'Time Available',
      ),
    ),
    const SizedBox(width: 10),
    Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        '-',
        style: GoogleFonts.poppins(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.grey[500],
        ),
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: TimeField(
        selectedTime: endTime,
        onTimeChanged: onEndTimeChanged,
        label: '',
      ),
    ),
  ],
),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CategoriesSection(
                selectedCategories: selectedCategories,
                toggleCategory: toggleCategory,
              ),
            ),
            const SizedBox(height: 16.0),
            DescriptionField(controller: descriptionController),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}