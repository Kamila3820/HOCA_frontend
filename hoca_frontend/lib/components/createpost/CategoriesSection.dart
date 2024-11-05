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
            buildCategoryChip(selectedCategories, 'Deep cleaning', FontAwesomeIcons.broom, 1, toggleCategory),
            buildCategoryChip(selectedCategories, 'Floor care', FontAwesomeIcons.broom, 2, toggleCategory),
            buildCategoryChip(selectedCategories, 'Window care', FontAwesomeIcons.broom, 3, toggleCategory),
            buildCategoryChip(selectedCategories, 'Laundry', FontAwesomeIcons.shirt, 4, toggleCategory),
            buildCategoryChip(selectedCategories, 'Sewing', FontAwesomeIcons.shirt, 5, toggleCategory),
            buildCategoryChip(selectedCategories, 'Lawn Mowing', FontAwesomeIcons.seedling, 6, toggleCategory),
            buildCategoryChip(selectedCategories, 'Watering', FontAwesomeIcons.seedling, 7, toggleCategory),
            buildCategoryChip(selectedCategories, 'Yard cleanup', FontAwesomeIcons.seedling, 8, toggleCategory),
            buildCategoryChip(selectedCategories, 'Pet sitting', FontAwesomeIcons.paw, 9, toggleCategory),
          ],
        ),
      ],
    );
  }
}
