import 'package:flutter/material.dart';

class HistoryItemBox extends StatelessWidget {
  final String orderID;
  final String name;
  final String date;
  final String status;
  final String cancellationReason;
  final String price; // New price variable
  final bool ratingStatus; // Updated to boolean
  final VoidCallback? onRate;

  const HistoryItemBox({
    super.key,
    required this.orderID,
    required this.name,
    required this.date,
    required this.status,
    required this.cancellationReason,
    required this.price, // New price parameter
    required this.ratingStatus, // Updated to boolean
    this.onRate,
  });

  Color getStatusColor(String status) {
    if (status == 'Completed') {
      return Colors.green; // Green for completed
    } else if (status == 'Cancelled') {
      return Colors.red; // Red for cancelled
    } else {
      return Colors.grey; // Default color for other statuses
    }
  }

  IconData getStatusIcon(String status) {
    if (status == 'Completed') {
      return Icons.check; // Check icon for completed
    } else if (status == 'Cancelled') {
      return Icons.cancel; // Cancel icon for cancelled
    } else {
      return Icons.info; // Default icon for other statuses
    }
  }

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    child: Row(
      children: [
        // Left icon for Completed or Cancelled
        CircleAvatar(
          backgroundColor: getStatusColor(status),
          child: Icon(
            getStatusIcon(status),
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8), // Spacing between icon and card
        Expanded(
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding( // Added padding around ListTile to control height
              padding: const EdgeInsets.all(8.0), // Adjust padding for more space
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjusted padding
                title: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    // If the status is "Cancelled", show cancellation reason with an info icon
                    if (status == 'Cancelled')
                      Row(
                        children: [
                          const Icon(Icons.info, color: Colors.red, size: 16),
                          const SizedBox(width: 4), // Spacing between icon and text
                          Expanded(
                            child: Text(
                              cancellationReason,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        status,
                        style: TextStyle(
                          color: getStatusColor(status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                trailing: status == 'Cancelled'
                    ? const Text(
                        'Cancelled',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Display price in the button
                          Text(
                            '฿ $price',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 85, // Increased the width a little to accommodate the button
                            child: ElevatedButton(
                              onPressed: ratingStatus == false ? onRate : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ratingStatus == false ? Colors.yellow : Colors.grey,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                ratingStatus == false ? 'Rate' : 'Rated',
                                style: TextStyle(
                                  fontSize: 12, // Slightly smaller font size
                                  color: ratingStatus == false ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}
