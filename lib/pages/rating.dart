import 'package:flutter/material.dart';

class RatingDialogPage extends StatelessWidget {
  final String workerName;

  RatingDialogPage({required this.workerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating your experience!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'To gives recommend to a worker',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(workerName, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            _buildRatingStars('Work'),
            _buildRatingStars('Security'),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Share your experience',
                hintText: 'Let us know your great experience!',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle rating submission
                Navigator.pop(context);
              },
              child: Text('Send rating'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: TextStyle(fontSize: 16)),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              Icons.star_border,
              color: Colors.amber,
            );
          }),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
