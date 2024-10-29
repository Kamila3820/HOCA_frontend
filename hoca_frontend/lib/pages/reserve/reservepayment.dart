import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({super.key});

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  String? contactName;
  String? contactPhone;
  String? _selectedPaymentMethod;
  String? _placeType;
  String? _noteToWorker;
  String? _selectedAddress;
  LatLng? _selectedLocation;

  final _formKey = GlobalKey<FormState>();
  final Completer<GoogleMapController> _controller = Completer();

  // static const LatLng _initialPosition = LatLng(13.736717, 100.523186); // Default to Bangkok
  LatLng _currentPosition = LatLng(13.736717, 100.523186);

@override
  void initState() {
    super.initState();
    _initializePosition(); // Call an async function from here
  }

  Future<void> _initializePosition() async {
    LatLng initialPosition = await _loadPosition();
    setState(() {
      _currentPosition = initialPosition;
    });
    _getAddress(initialPosition); // Any additional logic after setting the position
  }

  Future<LatLng> _loadPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lat = prefs.getString('latitude');
    String? long = prefs.getString('longitude');

    if (lat != null && long != null) {
      return LatLng(double.parse(lat), double.parse(long));
    } else {
      // Return a default location if no stored values are found
      return LatLng(13.736717, 100.523186);
    }
  }


  Future<void> _getAddress(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String fullAddress = [
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.postalCode,
          place.country,
        ].where((element) => element != null && element.isNotEmpty).join(", ");
        setState(() {
          _selectedAddress =
              fullAddress.isNotEmpty ? fullAddress : "Address not found";
        });
      } else {
        setState(() => _selectedAddress = "Address not found");
      }
    } catch (e) {
      setState(() => _selectedAddress = "Error fetching address");
    }
  }

  void _showSuccessAlertAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF3EA03C),
        title: Text(
          'Success',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        content: Text(
          'Order placed successfully!',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ProgressPage()),
        (route) => false,
      );
    });
  }

  void _openMapDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          height: 300,
          width: double.infinity,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 15,
            ),
            onMapCreated: (controller) => _controller.complete(controller),
            markers: _selectedLocation != null
                ? {
                    Marker(
                      markerId: const MarkerId('selected-location'),
                      position: _selectedLocation!,
                    ),
                  }
                : {},
            onTap: (position) {
              setState(() {
                _currentPosition = position;
                _selectedLocation = position;
                _getAddress(position);
              });
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
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
              _buildSectionTitle('Location'),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: _openMapDialog,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Color(0xFF87C4FF)),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            _selectedAddress ??
                                'Selected location: $_currentPosition',
                            style: GoogleFonts.poppins(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Divider(color: Color.fromARGB(115, 0, 0, 0)),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              _buildTextField('Name', onSaved: (value) => contactName = value),
              const SizedBox(height: 16.0),
              _buildPhoneField(),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Select a payment method'),
              const SizedBox(height: 16.0),
              _buildRadioOption('Cash', 'cash'),
              _buildRadioOption('QR code Payment', 'qrcode'),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Specify a type of your place'),
              const SizedBox(height: 8.0),
              _buildTextField('', onSaved: (value) => _placeType = value),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Note to a worker (if any)'),
              const SizedBox(height: 8.0),
              _buildTextField(
                '',
                maxLength: 500,
                validator: (value) {
                  if (value != null && value.length > 500) {
                    return 'Note should not exceed 500 characters';
                  }
                  return null;
                },
                onSaved: (value) => _noteToWorker = value,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              _showSuccessAlertAndNavigate(context);
            }
          },
          child: Text(
            'Submit',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    int? maxLength,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      maxLength: maxLength,
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildPhoneField() {
    return _buildTextField(
      'Phone Number',
      onSaved: (value) => contactPhone = value,
      validator: (value) {
        if (value == null || value.length != 10) {
          return 'Phone number must be exactly 10 digits';
        }
        return null;
      },
    );
  }

  Widget _buildRadioOption(String title, String value) {
    return ListTile(
      leading: Radio<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (newValue) =>
            setState(() => _selectedPaymentMethod = newValue),
      ),
      title: Text(title, style: GoogleFonts.poppins()),
    );
  }
}
