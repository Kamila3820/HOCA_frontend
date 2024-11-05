import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/models/profile.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentDialog extends StatefulWidget {
  final String postID;

  const PaymentDialog({super.key, required this.postID});

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _placeTypeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String? _selectedPaymentMethod;
  String? _selectedAddress;
  LatLng? _selectedLocation;

  final _formKey = GlobalKey<FormState>();
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _initializePosition();
    _fetchUserData(); 
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _placeTypeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // Helper method to show SnackBar at the top
  void _showTopSnackBar(String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 10,
      ),
      dismissDirection: DismissDirection.up,
    );

    // Remove current SnackBar if any
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    // Show new SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<Profile> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await Caller.dio.get(
        '/v1/user/profile',
        options: Options(
          headers: {
            'x-auth-token': '$token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Profile.fromJson(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw Exception('Failed to load user data: $error');
    }
  }

  Future<void> _fetchUserData() async {
    try {
      final userContact = await fetchUser();
      print("Fetched User: ${userContact.username}, ${userContact.phonenumber}");
      setState(() {
        _nameController.text = userContact.username!;
        _phoneController.text = userContact.phonenumber!;
      });
    } catch (error) {
      _showTopSnackBar('Failed to load user data: $error', isError: true);
    } 
  }

  void callReservePost(String postID) async {

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print(_nameController.text);
      print(_phoneController.text);
      print(_selectedPaymentMethod);
      print(_placeTypeController.text);
      print(_noteController.text);


      final response = await Caller.dio.post(
        '/v1/order/create/$postID',
        data: {
          "contact_name": _nameController.text,
          "contact_phone": _phoneController.text,
          "payment_type": _selectedPaymentMethod,
          "specific_place": _placeTypeController.text,
          "note": _noteController.text
        },
        options: Options(
          headers: {
            'x-auth-token': '$token',
          },
        ),    
      );

      if (response.statusCode == 200) {
        _showTopSnackBar('Place your order successfully');
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProgressPage()),
      );
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (error) {
      _showTopSnackBar('Failed to update profile: $error', isError: true);
    } 
  }

  // static const LatLng _initialPosition = LatLng(13.736717, 100.523186); // Default to Bangkok
  LatLng _currentPosition = LatLng(13.736717, 100.523186);

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
              _buildTextField('Name', controller: _nameController),
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
              _buildTextField('', controller: _placeTypeController),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Note to a worker (if any)'),
              const SizedBox(height: 8.0),
              _buildTextField(
                '',
                controller: _noteController,
                maxLength: 500,
                validator: (value) {
                  if (value != null && value.length > 500) {
                    return 'Note should not exceed 500 characters';
                  }
                  return null;
                },
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
      style: GoogleFonts.poppins(color: Colors.red,fontWeight: FontWeight.bold,),
    ),
  ),
  ElevatedButton(
    onPressed: _selectedPaymentMethod == null
        ? null  // Disable the button if no payment method is selected
        : () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              _showSuccessAlertAndNavigate(context);
              callReservePost(widget.postID);
            }
          },
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF87C4FF), // Set your desired color here
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Optional: round the button
      ),
    ),
    child:Text(
  'Submit',
  style: GoogleFonts.poppins(
    color: Colors.white,
    fontWeight: FontWeight.bold, // Make the text bold
  ),
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
    TextEditingController? controller,
    String? Function(String?)? validator,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      maxLength: maxLength,
      validator: validator,
    );
  }

  Widget _buildPhoneField() {
    return _buildTextField(
      'Phone Number',
      controller: _phoneController,
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
