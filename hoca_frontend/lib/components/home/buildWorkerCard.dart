import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/home/Subservice%20Widget.dart';
import 'package:hoca_frontend/pages/reserve/reserve.dart';


Widget buildWorkerCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReservePage()),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://via.placeholder.com/150',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 10,
                        ),
                      ],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '8.0',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 155,
              left: 12,
              child: Container(
                width: 45,
                height: 15,
                decoration: const BoxDecoration(
                  color: Color(0xFF90D26D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Verified',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 190,
              left: 2,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubserviceWidget(text: 'Iron clothes'),
                    const SizedBox(width: 8),
                    SubserviceWidget(text: 'Mop Floor'),
                    const SizedBox(width: 8),
                    SubserviceWidget(text: 'Wash Dishes'),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 210,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Artiwara Kongmalai',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    child: Text(
                      'Male',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF39A7FF),
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '3.6 km',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    child: Text(
                      'Condo room/ House',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 12,
              child: Text(
                '400 THB/ hr.',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}