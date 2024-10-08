import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/createpostcon/CreatePostButton%20Widget.dart';
import 'package:hoca_frontend/components/createpostcon/FamilyAmountSelector%20Widget.dart';
import 'package:hoca_frontend/components/createpostcon/LocationBox%20Widget.dart';
import 'package:hoca_frontend/components/createpostcon/WorkTypeSelector%20Widget.dart';
import 'package:hoca_frontend/pages/home.dart';

class CreatePostCon extends StatefulWidget {
  const CreatePostCon({super.key});

  @override
  _CreatePostConState createState() => _CreatePostConState();
}

class _CreatePostConState extends State<CreatePostCon> {
  final List<int> _selectedBoxIndices = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedFamilyAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 370.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF87C4FF).withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 160, left: 20, right: 10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Center(
                        child: Text(
                          'Create Worker',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          LocationBox(),
          WorkTypeSelector(
            selectedBoxIndices: _selectedBoxIndices,
            onBoxTapped: _onBoxTapped,
          ),
          FamilyAmountSelector(
            formKey: _formKey,
            selectedFamilyAmount: _selectedFamilyAmount,
            onFamilyAmountChanged: (value) {
              setState(() {
                _selectedFamilyAmount = value;
              });
            },
          ),
          Positioned(
            top: 170,
            right: 30,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF87C4FF).withOpacity(0.6),
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          CreatePostButton(
            formKey: _formKey,
            selectedBoxIndices: _selectedBoxIndices,
            onPressed: () {
              if (_formKey.currentState!.validate() && _selectedBoxIndices.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              } else if (_selectedBoxIndices.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select at least one type of place to work'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _onBoxTapped(int index) {
    setState(() {
      if (_selectedBoxIndices.contains(index)) {
        _selectedBoxIndices.remove(index);
      } else {
        _selectedBoxIndices.add(index);
      }
    });
  }
}