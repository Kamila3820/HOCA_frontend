import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Create Worker",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(label: "Worker Name"),
              _buildTextField(label: "Working Price"),
              _buildTextField(label: "ID Line"),
              _buildTextField(label: "Phone Number"),
              _buildDropdownField(label: "Gender", items: ["Male", "Female"]),
              SizedBox(height: 16),
              Text(
                "Categories",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildCategoryChips(),
              SizedBox(height: 16),
              _buildTextField(
                label: "Description",
                maxLines: 4,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      {required String label, required List<String> items}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          // Handle change
        },
      ),
    );
  }

  Widget _buildCategoryChips() {
    List<String> categories = [
      "Deep cleaning",
      "Floor care",
      "Window care",
      "Laundry",
      "Sewing",
      "Lawn Mowing",
      "Watering",
      "Yard cleanup",
      "Pet sitting",
    ];

    return Wrap(
      spacing: 8.0,
      children: categories.map((category) {
        return FilterChip(
          label: Text(category),
          onSelected: (bool selected) {
            // Handle chip selection
          },
        );
      }).toList(),
    );
  }
}
