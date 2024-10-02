import 'package:flutter/material.dart';

class ReservePaymentPage extends StatefulWidget {
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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Reserve Payment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment method selection
            Text("Select a payment method", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            RadioListTile(
              title: Text("Cash"),
              value: 'Cash',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("QR code Payment"),
              value: 'QR code Payment',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                });
              },
            ),
            SizedBox(height: 20),
            // Place type input
            Text("Specify a type of your place", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                placeType = value;
              },
              decoration: InputDecoration(
                labelText: "Type of place",
                hintText: "Dormitory room 17",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Note input
            Text("Note to a worker (if any)", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                workerNote = value;
              },
              decoration: InputDecoration(
                labelText: "Note",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the page
                  },
                  child: Text("Cancel", style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle order placement logic here
                    Navigator.pop(context); // Close the page after placing order
                    // You can add logic here to send the order data to a backend
                  },
                  child: Text("Place order"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
