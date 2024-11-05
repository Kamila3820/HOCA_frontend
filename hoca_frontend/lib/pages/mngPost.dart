import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/reserve/Description%20Component.dart';
import 'package:hoca_frontend/components/reserve/InfoList%20Component.dart';
import 'package:hoca_frontend/components/reserve/NameRating%20Component.dart';
import 'package:hoca_frontend/components/reserve/ProfilePicture%20Component.dart';
import 'package:hoca_frontend/components/reserve/Reviews.dart';
import 'package:hoca_frontend/components/reserve/TaskButtons%20Component.dart';
import 'package:hoca_frontend/components/reserve/VerifiedBadge%20Component.dart';
import 'package:hoca_frontend/main.dart';
import 'package:hoca_frontend/models/post.dart';
import 'package:hoca_frontend/pages/createpost/createpost.dart';
import 'package:hoca_frontend/pages/editpost/editpost.dart';
import 'package:hoca_frontend/pages/mngpayment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagePostPage extends StatefulWidget {
  const ManagePostPage({super.key});

  @override
  _ManagePostPageState createState() => _ManagePostPageState();
}

class _ManagePostPageState extends State<ManagePostPage> {
  late Future<Post?> postFuture;

  @override
  void initState() {
    super.initState();
    postFuture = fetchPostById();
  }

  Future<Post?> fetchPostById() async {
    String url = "/v1/post/me";
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
      if (response.statusCode == 200) {
      // Successfully found post, parse the response
        return Post.fromJson(response.data);
      } else if (response.data == null) {
        // Post not found, return null to indicate no post
        return null;
      } else {
        // Other errors
        throw Exception('Failed to load post');
      } 
    } catch (error) {
      Caller.handle(context, error as DioError); 
      rethrow; 
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, String postID, String? token, String resMessage) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissal by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: const [
            Icon(Icons.warning, color: Colors.red, size: 60),
            SizedBox(height: 10),
            Text('Delete Post', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text("You're going to delete This Post"),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey, // No button color
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('No', style: TextStyle(color: Colors.black),),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Yes button color
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Yes', style: TextStyle(color: Colors.white),),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _callApi("/v1/post/delete/$postID", token, resMessage, shouldNavigate: true); // Call the delete API
            },
          ),
        ],
      );
    },
  );
}

  void _handleMenuItemClick(String value, String postID) async {
  String url = "";
  String resMessage = "";
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  switch (value) {
    case 'edit':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditPostPage(postID: postID,)),
      );
      break;

      case 'payment':
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PaymentServiceFeePage(),
    ),
  );
  break;

    case 'open':
      url = "/v1/post/open/$postID";  
      resMessage = "Post is now open for work!";
      _callApi(url, token, resMessage, shouldNavigate: false);
      break;

    case 'close':
      url = "/v1/post/close/$postID";  
      resMessage = "Post is now closed for work.";
      _callApi(url, token, resMessage, shouldNavigate: false);
      break;

    case 'delete':
      url = "/v1/post/delete/$postID";  
      resMessage = "Post deleted successfully.";
      _showDeleteConfirmationDialog(context, postID, token, resMessage);
      break;
  }
}

Future<void> _callApi(String url, String? token, String resMessage, {bool shouldNavigate = false}) async {
  try {
    // Show a loading indicator while the request is being made
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    print("Resulttttttttttttttttttttttttttttttttttttttttttttttttt");
    print(url);

    final response = await Caller.dio.delete(
      url,
      options: Options(
        headers: {
          'x-auth-token': token, 
        },
      ),
    );

    // Close the loading dialog
    Navigator.of(context, rootNavigator: true).pop();

    // Handle success
    if (response.statusCode == 200) {
      // Show success feedback (e.g., Toast, SnackBar, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resMessage)),
      );

      setState(() {
        postFuture = fetchPostById(); // Refetch the post to update the UI
      });

      if (shouldNavigate) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CreatePostPage()),
        );
      }
    }
  } catch (error) {
    Navigator.of(context, rootNavigator: true).pop();
    print('Error: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${error.toString()}')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Post?>(
        future: postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostPage()),
                );
              });
              return const Center(child: CircularProgressIndicator()); 
          } else if (!snapshot.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostPage()),
                );
              });
              return const Center(child: CircularProgressIndicator()); // Show a loading indicator until the page is replaced
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
                              // Row with Back Button and Ellipsis Menu
                              Padding(
                                padding: const EdgeInsets.only(top: 30, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   IconButton(
  icon: const Icon(
    Icons.arrow_back,
    color: Color.fromARGB(255, 0, 0, 0),
    size: 40.0,
  ),
  onPressed: () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false, // This removes all previous routes.
    );
  },
),


                                    PopupMenuButton<String>(
                                      onSelected: (value) {
                                        _handleMenuItemClick(value, post.postID.toString()); // Pass the postID here
                                      },
                                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                        const PopupMenuItem<String>(
                                          value: 'edit',
                                          child: ListTile(
                                            leading: Icon(Icons.edit),
                                            title: Text('Edit post'),
                                          ),
                                        ),
                                         const PopupMenuItem<String>(
                                          value: 'payment',
                                          child: ListTile(
                                            leading: Icon(Icons.payment),
                                            title: Text('Pay the service fee '),
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'open',
                                          enabled: !post.activeStatus!,
                                          child: ListTile(
                                            leading: Icon(Icons.visibility),
                                            title: Text('Open work'),
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'close',
                                          enabled: post.activeStatus!,
                                          child: ListTile(
                                            leading: Icon(Icons.visibility_off),
                                            title: Text('Close work'),
                                          ),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'delete',
                                          child: ListTile(
                                            leading: Icon(Icons.delete, color: Colors.red,),
                                            title: Text('Delete post'),
                                          ),
                                        ),
                                      ],
                                      child: const Icon(
                                        Icons.more_vert,
                                        size: 40.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Profile Picture and other content
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ProfilePicture(
                                      postID: post.postID.toString(),
                                      imageUrl: post.avatarUrl,
                                      rating: post.totalScore,
                                      status: post.activeStatus,
                                    ),
                                    const SizedBox(height: 15),
                                    NameRating(
                                      name: post.name,
                                      taskCount: 0,
                                    ),
                                    const SizedBox(height: 20),
                                    TaskButtons(
                                      categories: post.categoryID!,
                                    ),
                                    const SizedBox(height: 10),
                                    VerifiedBadge(),
                                    const SizedBox(height: 20),
                                    InfoList(
                                      location: post.location,
                                      phoneNumber: post.phoneNumber,
                                      placeTypes: post.placeTypeID,
                                      amountPeople: post.amountFamily,
                                      price: post.price,
                                    ),
                                    const SizedBox(height: 20),
                                    Description(description: post.description, create: post.createdAt, update: post.updatedAt,),
                                    const SizedBox(height: 20),
                                    BuildReviews(
                                      rating: post.userRatings,
                                      name: post.name,
                                    ),
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
              ],
            );
          }
        },
      ),
    );
  }
  
}
