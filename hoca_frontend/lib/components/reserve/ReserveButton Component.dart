import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/pages/reserve/reservepayment.dart';

class ReserveButton extends StatefulWidget {
  final String postID;
  final double workPrice;
  final int distancePrice;

  const ReserveButton({super.key, required this.postID, required this.workPrice, required this.distancePrice});

  @override
  _ReserveButtonState createState() => _ReserveButtonState();
}

class _ReserveButtonState extends State<ReserveButton> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PaymentDialog(postID: widget.postID, workPrice: widget.workPrice, distancePrice: widget.distancePrice,); // Use the new dialog widget here
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF87C4FF),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        child: Text(
          'Reserve',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }
}
