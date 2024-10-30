import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/profile/InfoFields.dart';
import 'package:hoca_frontend/components/profile/LogoutButton.dart';
import 'package:hoca_frontend/components/profile/ProfileHeader.dart';
import 'package:hoca_frontend/models/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  String? _imageUrl;
  String? _originalImageUrl;
  final ImagePicker _picker = ImagePicker();

  Map<String, String> _originalInfo = {
    'Email': '',
    'Username': '',
    'Phone number': '',
  };

  final Map<String, TextEditingController> _controllers = {};

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

  bool get _hasChanges {
    bool infoChanged = _controllers.entries.any(
      (entry) => entry.value.text != _originalInfo[entry.key],
    );
    bool imageChanged = _imageUrl != _originalImageUrl;
    return infoChanged || imageChanged;
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _fetchUserData();
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
    setState(() {
      _isLoading = true;
    });

    try {
      final profile = await fetchUser();

      setState(() {
        _originalInfo['Email'] = profile.email ?? '';
        _originalInfo['Username'] = profile.username ?? '';
        _originalInfo['Phone number'] = profile.phonenumber ?? '';
        _imageUrl = profile.avatarUrl;
        _originalImageUrl = profile.avatarUrl;

        _controllers['Email']?.text = profile.email ?? '';
        _controllers['Username']?.text = profile.username ?? '';
        _controllers['Phone number']?.text = profile.phonenumber ?? '';
      });
    } catch (error) {
      _showTopSnackBar('Failed to load user data: $error', isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> callEditProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      FormData formData = FormData.fromMap({
        'user_name': _controllers['Username']?.text,
        'phone_number': _controllers['Phone number']?.text,
      });

      if (_imageUrl != null && _imageUrl != _originalImageUrl) {
        formData.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(_imageUrl!),
          ),
        );
      }

      final response = await Caller.dio.patch(
        '/v1/user/profile/edit',
        data: formData,
        options: Options(
          headers: {
            'x-auth-token': '$token',
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          _originalInfo = Map.fromEntries(
            _controllers.entries.map((e) => MapEntry(e.key, e.value.text)),
          );
          _originalImageUrl = _imageUrl;
        });
        _showTopSnackBar('Profile updated successfully');
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (error) {
      _showTopSnackBar('Failed to update profile: $error', isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _showImageSourceDialog() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context, 'camera');
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context, 'gallery');
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    ).then((value) async {
      if (value != null) {
        await _pickImage(value == 'camera' ? ImageSource.camera : ImageSource.gallery);
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_isLoading) return;

    try {
      setState(() {
        _isLoading = true;
      });

      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (image != null) {
        setState(() {
          _imageUrl = image.path;
        });
      }
    } catch (e) {
      _showTopSnackBar(
        'Failed to ${source == ImageSource.camera ? 'take photo' : 'pick image'}: ${e.toString()}',
        isError: true,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleSaveChanges() async {
    await callEditProfile();
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
                  onPickImage: _showImageSourceDialog,
                  imageUrl: _imageUrl,
                ),
                InfoFields(
                  originalInfo: _originalInfo,
                  controllers: _controllers,
                  onSaveChanges: _handleSaveChanges,
                  hasChanges: _hasChanges,
                  isLoading: _isLoading,
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