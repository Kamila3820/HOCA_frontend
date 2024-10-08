import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/reserve/Description%20Component.dart';
import 'package:hoca_frontend/components/reserve/InfoList%20Component.dart';
import 'package:hoca_frontend/components/reserve/NameRating%20Component.dart';
import 'package:hoca_frontend/components/reserve/ProfilePicture%20Component.dart';
import 'package:hoca_frontend/components/reserve/ReserveButton%20Component.dart';
import 'package:hoca_frontend/components/reserve/Reviews.dart';
import 'package:hoca_frontend/components/reserve/TaskButtons%20Component.dart';
import 'package:hoca_frontend/components/reserve/VerifiedBadge%20Component.dart';

class ReservePage extends StatelessWidget {
  const ReservePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  // Background Decoration
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 380,
                      decoration: BoxDecoration(
                        color: const Color(0xFF87C4FF).withOpacity(0.6),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Button
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 20),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 40.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        // Profile Picture and other content
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProfilePicture(),
                              const SizedBox(height: 15),
                              NameRating(),
                              const SizedBox(height: 20),
                              TaskButtons(),
                              const SizedBox(height: 10),
                              VerifiedBadge(),
                              const SizedBox(height: 20),
                              InfoList(),
                              const SizedBox(height: 20),
                              Description(),
                              const SizedBox(height: 20),
                              BuildReviews(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Reserve Button
          ReserveButton(),
        ],
      ),
    );
  }
}

class Reviews {
}