import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeField extends StatefulWidget {
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeChanged;
  final String label;
  final bool isRequired;
  final String? errorText;

  const TimeField({
    super.key,
    required this.selectedTime,
    required this.onTimeChanged,
    required this.label,
    this.isRequired = true,
    this.errorText,
  });

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  bool _hasSelectedTime = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    // Initialize error text from widget if provided
    _errorText = widget.errorText;
  }

  bool _isValidTime(TimeOfDay time) {
    return !(time.hour == 0 && time.minute == 0);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Invalid Time',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            message,
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF87C4FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<TimeOfDay>(
      validator: (value) {
        if (widget.isRequired && !_hasSelectedTime) {
          return 'Please select a time';
        }
        if (_hasSelectedTime && !_isValidTime(widget.selectedTime)) {
          return 'Please select a time other than 00:00';
        }
        return null;
      },
      builder: (FormFieldState<TimeOfDay> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.label,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (widget.isRequired)
                    TextSpan(
                      text: ' ',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: widget.selectedTime,
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        timePickerTheme: TimePickerThemeData(
                          backgroundColor: Colors.white,
                          hourMinuteShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        colorScheme: const ColorScheme.light(
                          primary: Color(0xFF87C4FF),
                          onPrimary: Colors.white,
                          surface: Colors.white,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                
                if (picked != null) {
                  if (_isValidTime(picked)) {
                    setState(() {
                      _hasSelectedTime = true;
                      _errorText = null;
                    });
                    widget.onTimeChanged(picked);
                    field.didChange(picked); // Update form field state
                  } else {
                    setState(() {
                      _errorText = 'Please select a time other than 00:00';
                    });
                    _showErrorDialog('Please select a time other than 00:00');
                    field.validate(); // Trigger validation
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: (field.hasError || _errorText != null)
                            ? Colors.red
                            : Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _hasSelectedTime
                              ? '${widget.selectedTime.hour.toString().padLeft(2, '0')}:${widget.selectedTime.minute.toString().padLeft(2, '0')}'
                              : 'Select Time',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: _hasSelectedTime ? Colors.black87 : Colors.grey[600],
                          ),
                        ),
                        Icon(
                          Icons.access_time,
                          color: (field.hasError || _errorText != null)
                              ? Colors.red
                              : Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                  if (field.hasError || _errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        field.hasError ? field.errorText! : _errorText!,
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}