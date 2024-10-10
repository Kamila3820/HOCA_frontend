import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hoca_frontend/components/createpost/buildCategoryChip.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class CategoriesSection extends StatelessWidget {
  final List<String> selectedCategories;
  final Function(String) toggleCategory;

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
          spacing: 5.0,
          runSpacing: 4.0,
          children: [
            buildCategoryChip(
                selectedCategories, 'Deep cleaning', FontAwesomeIcons.broom, toggleCategory),
            buildCategoryChip(
                selectedCategories, 'Floor care', FontAwesomeIcons.broom, toggleCategory),
            buildCategoryChip(
                selectedCategories, 'Window care', FontAwesomeIcons.broom, toggleCategory),
            buildCategoryChip(
                selectedCategories, 'Laundry', FontAwesomeIcons.shirt, toggleCategory),
            buildCategoryChip(
                selectedCategories, 'Sewing', FontAwesomeIcons.shirt, toggleCategory),
            buildCategoryChip(
                selectedCategories, 'Lawn Mowing', FontAwesomeIcons.seedling, toggleCategory),
            buildCategoryChip(
                selectedCategories, 'Watering', FontAwesomeIcons.seedling, toggleCategory),
            buildCategoryChip(
                selectedCategories, 'Yard cleanup', FontAwesomeIcons.seedling, toggleCategory),
            buildCategoryChip(
                selectedCategories, 'Pet sitting', FontAwesomeIcons.paw, toggleCategory),
          ],
        ),
      ],
    );
  }
}