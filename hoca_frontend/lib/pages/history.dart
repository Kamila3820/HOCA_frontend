import 'package:flutter/material.dart';

import 'rating.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> historyItems = [
    {
      'name': 'Ratanaporn Yong',
      'date': '28/04/2024 12:30',
      'status': 'Completed',
      'statusColor': Colors.green,
      'ratingStatus': 'Rating',
      'ratingColor': Colors.yellow,
    },
    {
      'name': 'Ploypailin Saethong',
      'date': '28/04/2024 18:45',
      'status': 'Canceled',
      'statusColor': Colors.red,
      'ratingStatus': 'Bad weather',
      'ratingColor': Colors.grey,
    },
    {
      'name': 'Jinda Saeum',
      'date': '25/04/2024 10:30',
      'status': 'Completed',
      'statusColor': Colors.green,
      'ratingStatus': 'Rated',
      'ratingColor': Colors.grey,
    },
    {
      'name': 'Artivara Kong',
      'date': '12/04/2024 11:45',
      'status': 'Completed',
      'statusColor': Colors.green,
      'ratingStatus': '',
      'ratingColor': Colors.transparent,
    },
  ];

HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text(item['date']),
            trailing: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: item['ratingColor'],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(item['ratingStatus']),
            ),
            onTap: () {
              if (item['ratingStatus'] == 'Rating') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RatingDialogPage(workerName: item['name']),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
