import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/pages/progress.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({super.key});

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  String? contactName;
  String? contactPhone;
  String? _selectedPaymentMethod;
  String? _placeType;
  String? _noteToWorker;
  final _formKey = GlobalKey<FormState>();

  void _showSuccessAlertAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF3EA03C),
          title: Text('Success',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              )),
          content: Text(
            'Order placed successfully!',
            style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 17,
            ),
          ),
        );
      },
    );

    // Automatically close the alert and navigate after 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Dismiss the alert dialog
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ProgressPage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Topic text for the new fields
              Align(
  alignment: Alignment.centerLeft,
  child: Text(
    'Location',
    style: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
),

              const SizedBox(height: 16.0),
              // Location text with icon and line underneath
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color(0xFF87C4FF),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          '679/210 Prachauthit 45 Thung Khru, Bangkok',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    height: 1.0,
                    color: const Color.fromARGB(115, 0, 0, 0),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onSaved: (value) {
                  contactName = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
  decoration: InputDecoration(
    labelText: 'Phone Number',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  keyboardType: TextInputType.phone,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly, // Allow only digits
    LengthLimitingTextInputFormatter(10), // Limit to 10 digits
  ],
  validator: (value) {
    if (value == null || value.length != 10) {
      return 'Phone number must be exactly 10 digits';
    }
    return null;
  },
  onSaved: (value) {
    contactPhone = value;
  },
),
              const SizedBox(height: 16.0),
              Text(
                'Select a payment method',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              ListTile(
                leading: Radio(
                  value: 'cash',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
                title: Text(
                  'Cash',
                  style: GoogleFonts.poppins(),
                ),
              ),
              ListTile(
                leading: Radio(
                  value: 'qrcode',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
                title: Text(
                  'QR code Payment',
                  style: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Specify a type of your place',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onSaved: (value) {
                  _placeType = value;
                },
              ),
              const SizedBox(height: 16.0),
              Text(
                'Note to a worker (if any)',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value != null && value.length > 500) {
                    return 'Note should not exceed 500 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _noteToWorker = value;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
              color: Colors.red,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _selectedPaymentMethod != null
              ? () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('Contact Name: $contactName');
                    print('Contact Phone: $contactPhone');
                    print('Selected Payment Method: $_selectedPaymentMethod');
                    print('Place Type: $_placeType');
                    print('Note to Worker: $_noteToWorker');

                    // Show success alert and navigate
                    _showSuccessAlertAndNavigate(context);
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedPaymentMethod != null
                ? const Color(0xFF87C4FF)
                : Colors.grey,
          ),
          child: Text(
            'Place order',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
