import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hoca_frontend/components/createpost/buildCategoryChip.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class CategoriesSection extends StatelessWidget {
  final List<int> selectedCategories; // Now stores multiple selected categories as a list of integers
  final Function(int) toggleCategory; // Expects an integer for category selection

  const CategoriesSection({
    super.key,
    required this.selectedCategories,
    required this.toggleCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRequiredLabel('Categories'),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            buildCategoryChip(
                selectedCategory, 'Deep cleaning', FontAwesomeIcons.broom, 1, toggleCategory),
            buildCategoryChip(
                selectedCategory, 'Floor care', FontAwesomeIcons.broom, 2, toggleCategory),
            buildCategoryChip(
                selectedCategory, 'Window care', FontAwesomeIcons.broom, 3, toggleCategory),
            buildCategoryChip(
                selectedCategory, 'Laundry', FontAwesomeIcons.shirt, 4, toggleCategory),
            buildCategoryChip(
                selectedCategory, 'Sewing', FontAwesomeIcons.shirt, 5, toggleCategory),
            buildCategoryChip(
                selectedCategory, 'Lawn Mowing', FontAwesomeIcons.seedling, 6, toggleCategory),
            buildCategoryChip(
                selectedCategory, 'Watering', FontAwesomeIcons.seedling,  7, toggleCategory),
            buildCategoryChip(
                selectedCategory, 'Yard cleanup', FontAwesomeIcons.seedling, 8, toggleCategory),
            buildCategoryChip(
                selectedCategory, 'Pet sitting', FontAwesomeIcons.paw, 9, toggleCategory),
          ],
        ),
      ],
    );
  }
}
