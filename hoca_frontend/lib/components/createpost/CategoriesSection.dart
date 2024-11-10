import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpost/buildCategoryChip.dart';
import 'package:hoca_frontend/components/createpost/buildRequiredLabel.dart';

class CategoriesSection extends StatefulWidget {
  final List<int?> selectedCategories;
  final Function(int) toggleCategory;

  const CategoriesSection({
    super.key,
    required this.selectedCategories,
    required this.toggleCategory,
  });

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final GlobalKey _tooltipKey = GlobalKey();

  void _showTooltip() {
    final dynamic tooltip = _tooltipKey.currentState;
    tooltip?.ensureTooltipVisible();
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            buildRequiredLabel('Categories'),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _showTooltip,
              child: Tooltip(
                key: _tooltipKey,
                message: "Select the service categories maximum 3", // Customize this message
                preferBelow: false,
                verticalOffset: -5,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(16),
                triggerMode: TooltipTriggerMode.manual,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                textStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(192, 0, 0, 0),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: MouseRegion(
                  cursor: SystemMouseCursors.help,
                  child: FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    size: 17,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            buildCategoryChip(
                widget.selectedCategories, 'Deep cleaning', FontAwesomeIcons.broom, 1, widget.toggleCategory),
            buildCategoryChip(
                widget.selectedCategories, 'Floor care', FontAwesomeIcons.broom, 2, widget.toggleCategory),
            buildCategoryChip(
                widget.selectedCategories, 'Window care', FontAwesomeIcons.broom, 3, widget.toggleCategory),
            buildCategoryChip(
                widget.selectedCategories, 'Laundry', FontAwesomeIcons.shirt, 4, widget.toggleCategory),
            buildCategoryChip(
                widget.selectedCategories, 'Sewing', FontAwesomeIcons.shirt, 5, widget.toggleCategory),
            buildCategoryChip(
                widget.selectedCategories, 'Lawn Mowing', FontAwesomeIcons.seedling, 6, widget.toggleCategory),
            buildCategoryChip(
                widget.selectedCategories, 'Watering', FontAwesomeIcons.seedling, 7, widget.toggleCategory),
            buildCategoryChip(
                widget.selectedCategories, 'Yard cleanup', FontAwesomeIcons.seedling, 8, widget.toggleCategory),
            buildCategoryChip(
                widget.selectedCategories, 'Pet sitting', FontAwesomeIcons.paw, 9, widget.toggleCategory),
          ],
        ),
      ],
    );
  }
}