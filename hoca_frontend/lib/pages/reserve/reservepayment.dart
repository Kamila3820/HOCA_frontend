import 'package:flutter/material.dart';

class ReservePaymentPage extends StatefulWidget {
  const ReservePaymentPage({super.key});

  @override
  _ReservePaymentPageState createState() => _ReservePaymentPageState();
}

class _ReservePaymentPageState extends State<ReservePaymentPage> {
  String paymentMethod = 'Cash'; // Default selected payment method
  String placeType = ''; // User input for place type
  String workerNote = ''; // User input for note

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Reserve Payment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment method selection
            const Text("Select a payment method", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            RadioListTile(
              title: const Text("Cash"),
              value: 'Cash',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                });
              },
            ),
            RadioListTile(
              title: const Text("QR code Payment"),
              value: 'QR code Payment',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                });
              },
            ),
            const SizedBox(height: 20),
            // Place type input
            const Text("Specify a type of your place", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                placeType = value;
              },
              decoration: const InputDecoration(
                labelText: "Type of place",
                hintText: "Dormitory room 17",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Note input
            const Text("Note to a worker (if any)", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                workerNote = value;
              },
              decoration: const InputDecoration(
                labelText: "Note",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the page
                  },
                  child: const Text("Cancel", style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle order placement logic here
                    Navigator.pop(context); // Close the page after placing order
                    // You can add logic here to send the order data to a backend
                  },
                  child: const Text("Place order"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
