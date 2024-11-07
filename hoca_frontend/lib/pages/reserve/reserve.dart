import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/reserve/Description%20Component.dart';
import 'package:hoca_frontend/components/reserve/InfoList%20Component.dart';
import 'package:hoca_frontend/components/reserve/NameRating%20Component.dart';
import 'package:hoca_frontend/components/reserve/ProfilePicture%20Component.dart';
import 'package:hoca_frontend/components/reserve/ReserveButton%20Component.dart';
import 'package:hoca_frontend/components/reserve/Reviews.dart';
import 'package:hoca_frontend/components/reserve/TaskButtons%20Component.dart';
import 'package:hoca_frontend/components/reserve/VerifiedBadge%20Component.dart';
import 'package:hoca_frontend/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservePage extends StatefulWidget {
  final String postID;
  final double workPrice;
  final int distancePrice;

  const ReservePage({super.key, required this.postID, required this.workPrice, required this.distancePrice});

  @override
  _ReservePageState createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {
  late Future<Post> postFuture;

  @override
  void initState() {
    super.initState();
    postFuture = fetchPostById(widget.postID);
  }

  Future<Post> fetchPostById(String postID) async {
    String url = "/v1/post/$postID";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await Caller.dio.get(
        url,
        options: Options(
          headers: {
            'x-auth-token': '$token', // Add token to header
          },
        ),
      );
      return Post.fromJson(response.data); 
    } catch (error) {
      Caller.handle(context, error as DioError); 
      rethrow; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Post>(
        future: postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No post found'));
          } else {
            final post = snapshot.data!;

            return Column(
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
                                    ProfilePicture(postID: post.postID.toString(), imageUrl: post.avatarUrl, rating: post.totalScore,),
                                    const SizedBox(height: 15),
                                    NameRating(name: post.name, taskCount: 0,),
                                    const SizedBox(height: 20),
                                    TaskButtons(categories: post.categoryID!,),
                                    const SizedBox(height: 10),
                                    VerifiedBadge(availableStart: post.availableStart, availableEnd: post.availableEnd,),
                                    const SizedBox(height: 20),
                                    InfoList(location: post.location, phoneNumber: post.phoneNumber, placeTypes: post.placeTypeID, amountPeople: post.amountFamily, price: post.price, duration: post.duration,),
                                    const SizedBox(height: 20),
                                    Description(description: post.description, create: post.createdAt, update: post.updatedAt,),
                                    const SizedBox(height: 20),
                                    BuildReviews(rating: post.userRatings, name: post.name,),
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
                ReserveButton(postID: post.postID.toString(), workPrice: widget.workPrice, distancePrice: widget.distancePrice,),
              ],
            );
          }
        },
      ),
    );
  }
}
