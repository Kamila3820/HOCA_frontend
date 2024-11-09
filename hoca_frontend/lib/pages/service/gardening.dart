import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/home/buildWorkerCard.dart';
import 'package:hoca_frontend/models/post.dart'; // Import your Post model

class GardeningPage extends StatefulWidget {
  final List<Post> posts; // Accept the posts as a parameter

  const GardeningPage({super.key, required this.posts}); // Require the posts

  @override
  _GardeningPageState createState() => _GardeningPageState();
}

class _GardeningPageState extends State<GardeningPage> {
  Future<void> _refreshPosts() async {
    // Add your logic to refresh the posts here
    // This function will be called when the user pulls down to refresh
    await Future.delayed(const Duration(seconds: 2)); // Simulating a delay
    setState(() {
      // Rebuild the widget to show the updated posts
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshPosts,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF87C4FF).withOpacity(0.6), // 60% opacity
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        'Gardening',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25), // Space between the blue box and the text
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Total Found: ${widget.posts.length}', // Show the number of filtered posts
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0), // Space on left and right
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10, // Space between rows
                    crossAxisSpacing: 10, // Space between columns
                    childAspectRatio: 0.58,
                  ),
                  itemCount: widget.posts.length, // Number of posts
                  itemBuilder: (context, index) {
                    return WorkerPost(
                      post: widget.posts[index],  // Directly pass the post
                      reload: () {},      // Pass the reload function
                    ); // Pass each post to buildWorkerCard
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}