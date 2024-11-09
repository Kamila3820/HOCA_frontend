import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/components/home/buildWorkerCard.dart';
import 'package:hoca_frontend/models/post.dart'; // Import your Post model

class ClothesPage extends StatefulWidget {
  final List<Post> posts; // Accept the posts as a parameter

  const ClothesPage({super.key, required this.posts}); // Require the posts

  @override
  _ClothesPageState createState() => _ClothesPageState();
}

class _ClothesPageState extends State<ClothesPage> {
  Future<void> _refreshPosts() async {
    // Implement your logic to refresh the posts here
    // For example, you could call an API to fetch the latest data
    // and update the `widget.posts` list accordingly
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    setState(() {
      // Trigger a rebuild to update the UI
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
                color: const Color(0xFF87C4FF).withOpacity(0.6),
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
                        'Clothes',
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
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Total Found: ${widget.posts.length}',
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
              child: widget.posts.isEmpty
                  ? Center(
                      child: Text(
                        'No clothes services available.',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.58,
                        ),
                        itemCount: widget.posts.length,
                        itemBuilder: (context, index) {
                          return WorkerPost(
                            post: widget.posts[index],
                            reload: () {
                              // Call the _refreshPosts method when the WorkerPost is reloaded
                              _refreshPosts();
                            },
                          );
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