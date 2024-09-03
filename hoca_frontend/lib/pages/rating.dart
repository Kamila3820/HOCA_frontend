import 'package:flutter/material.dart';

class RatingDialogPage extends StatelessWidget {
  final String workerName;

  const RatingDialogPage({super.key, required this.workerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating your experience!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'To gives recommend to a worker',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(workerName, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            _buildRatingStars('Work'),
            _buildRatingStars('Security'),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Share your experience',
                hintText: 'Let us know your great experience!',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle rating submission
                Navigator.pop(context);
              },
              child: const Text('Send rating'),
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
        Text(category, style: const TextStyle(fontSize: 16)),
        Row(
          children: List.generate(5, (index) {
            return const Icon(
              Icons.star_border,
              color: Colors.amber,
            );
          }),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
