import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FamilyAmountSelector extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String? selectedFamilyAmount;
  final Function(String?) onFamilyAmountChanged;
  final Function(bool) onDurationSelected;

  const FamilyAmountSelector({
    super.key,
    required this.formKey,
    required this.selectedFamilyAmount,
    required this.onFamilyAmountChanged,
    required this.onDurationSelected,
  });

  @override
  _FamilyAmountSelectorState createState() => _FamilyAmountSelectorState();
}

class _FamilyAmountSelectorState extends State<FamilyAmountSelector> {
  String? _selectedArea;
  int? _selectedTaskers;
  int? _selectedHours;
  bool _isDurationSelected = false;

  void _showDurationSelectorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DurationSelectorDialog(
          onDurationSelected: (area, taskers, hours) {
            setState(() {
              _selectedArea = area;
              _selectedTaskers = taskers;
              _selectedHours = hours;
              _isDurationSelected = true;
            });
            widget.onDurationSelected(true);
          },
        );
      },
    );
  }

Widget _buildSelectedDurationInfo() {
    if (_selectedArea != null) {
      return Container(
        margin: const EdgeInsets.only(top: 8, right: 30), // Added right margin to move it left
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF87C4FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF87C4FF),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF87C4FF),
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              "$_selectedArea m²\n$_selectedTaskers Taskers\n$_selectedHours hours",
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 465,
      left: 20,
      right: 20,
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select acceptable family size',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: DropdownButtonFormField<String>(
                          value: widget.selectedFamilyAmount,
                          items: [
                            DropdownMenuItem(
                              value: '1-2 Members',
                              child: Text(
                                '1-2 Members',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: '3-4 Members',
                              child: Text(
                                '3-4 Members',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: '5+ Members',
                              child: Text(
                                '5+ Members',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                          ],
                          onChanged: widget.onFamilyAmountChanged,
                          decoration: InputDecoration(
                            hintText: "Select family size",
                            hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an amount';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'It will relate to the amount of work',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: _showDurationSelectorDialog,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF87C4FF),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.av_timer,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Duration",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (!_isDurationSelected)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 5.0),
                        child: Text(
                          'Please select duration',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    _buildSelectedDurationInfo(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DurationSelectorDialog extends StatefulWidget {
  final Function(String, int, int) onDurationSelected;

  const DurationSelectorDialog({
    super.key,
    required this.onDurationSelected,
  });

  @override
  _DurationSelectorDialogState createState() => _DurationSelectorDialogState();
}

class _DurationSelectorDialogState extends State<DurationSelectorDialog> {
  String? selectedArea;
  final List<Map<String, dynamic>> durations = [
    {"area": "60", "taskers": 2, "hours": 3},
    {"area": "80", "taskers": 2, "hours": 4},
    {"area": "100", "taskers": 3, "hours": 3},
    {"area": "150", "taskers": 3, "hours": 4},
    {"area": "200", "taskers": 4, "hours": 4},
    {"area": "400", "taskers": 4, "hours": 8},
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Duration',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: durations.length,
              itemBuilder: (context, index) {
                final duration = durations[index];
                bool isSelected = selectedArea == duration["area"];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedArea = duration["area"];
                    });
                    widget.onDurationSelected(
                      duration["area"],
                      duration["taskers"],
                      duration["hours"],
                    );
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF87C4FF)
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                      color: isSelected
                          ? const Color(0xFF87C4FF).withOpacity(0.1)
                          : Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Max ${duration["area"]} m²",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const Divider(
                          color: Color(0xFF87C4FF),
                          thickness: 2,
                        ),
                        const SizedBox(height: 5),
                        Text.rich(
                          TextSpan(
                            text: "${duration["taskers"]} Taskers\n",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: const Color(0xFF7A7777),
                            ),
                            children: [
                              TextSpan(
                                text: "${duration["hours"]} hours",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: const Color(0xFF7A7777),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFFFB74D),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "The service only supports tasks within the scope of household chores. Please consult the task description before scheduling.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}