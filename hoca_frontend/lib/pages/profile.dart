import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/profile/InfoFields.dart';
import 'package:hoca_frontend/components/profile/LogoutButton.dart';
import 'package:hoca_frontend/components/profile/ProfileHeader.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;

  // Original user info
  Map<String, String> _originalInfo = {
    'First name': 'Thanadol',
    'Last name': 'Saojarkaval',
    'Email': 'thanadonsaojarkaval@gmail.com',
    'Phone number': '0958505514',
  };

  // Controllers for each info field
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _originalInfo.forEach((key, value) {
      _controllers[key] = TextEditingController(text: value);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    // Add your image picking logic here...
    setState(() {
      _isLoading = false;
    });
  }

  void _handleSaveChanges() {
    // Implement your save changes logic here
    print('Save changes');
    // You might want to update _originalInfo with the new values here
    setState(() {
      _originalInfo = Map.fromEntries(
        _controllers.entries.map((e) => MapEntry(e.key, e.value.text))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ProfileHeader(
                  isLoading: _isLoading,
                  onPickImage: () => _pickImage(context),
                ),
                InfoFields(
                  originalInfo: _originalInfo,
                  controllers: _controllers,
                  onSaveChanges: _handleSaveChanges,
                ),
              ],
            ),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}