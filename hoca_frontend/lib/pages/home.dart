import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/home/home_components.dart';
// Make sure to import the navbar
import 'package:hoca_frontend/models/post.dart';
import 'package:hoca_frontend/pages/location.dart';
import 'package:hoca_frontend/pages/notification.dart';
import 'package:hoca_frontend/pages/service/cleaning.dart';
import 'package:hoca_frontend/pages/service/clothes.dart';
import 'package:hoca_frontend/pages/service/gardening.dart';
import 'package:hoca_frontend/pages/service/pets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];
  String? selectedLatitude = "";  
  String? selectedLongitude = ""; 

  @override
  void initState() {
    super.initState();
    load("", "");
  }

  load(String latitude, String longitude) async {
    String url = "/v1/post/list?lat=$latitude&long=$longitude";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');


    print("Making request to URL: $url");
    print("Using token: $token");
    Caller.dio.get(
      url,
      options: Options(
      headers: {
        'x-auth-token': '$token',  // Add token to header
      },
    ),
      ).then((response) {
        print(response.data);
          if (mounted) {
            setState(() {
              // Directly map the response data to List<Post>
              posts = (response.data as List).map((postJson) => Post.fromJson(postJson)).toList();
            });
          }
    }).onError((DioException error, _) {
      Caller.handle(context, error);
    });
  }

  reload() {
    if (selectedLatitude == null || selectedLongitude == null) {
      _showLocationAlert(); 
    } else {
      load(selectedLatitude!, selectedLongitude!); 
    }
  }

  _showLocationAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Required'),
          content: const Text('Please choose a location to see available services.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dismiss the dialog
                _navigateToLocationPage();  // Navigate to the location selection page
              },
              child: const Text('Choose Location'),
            ),
          ],
        );
      },
    );
  }

  _navigateToLocationPage() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationPage(),
      ),
    );

    if (result != null) {
      setState(() {
        selectedLatitude = result['latitude'].toString();
        selectedLongitude = result['longitude'].toString();
      });

      load(selectedLatitude!, selectedLongitude!);  // Reload data with new location
    }
  }

  void navigateBasedOnCategory(Post post) async {
  if (post.categoryID == 1 || post.categoryID == 2 || post.categoryID == 3) {
    List<Post> filteredPosts = posts.where((post) =>
    post.categoryID == 1 || post.categoryID == 2 || post.categoryID == 3).toList();
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CleanPage(posts: filteredPosts),  // Navigate to CleanPage
      ),
    );
    if (result == true) {
      setState(() {
          filteredPosts = posts;  // Reset the filteredPosts list to all posts
      });
      reload();
    }
  } else if (post.categoryID == 4 || post.categoryID == 5) {
    List<Post> filteredPosts = posts.where((post) =>
    post.categoryID == 4 || post.categoryID == 5).toList();
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClothesPage(posts: filteredPosts),  // Navigate to ClothesPage
      ),
    );
    if (result == true) {
      setState(() {
          filteredPosts = posts;  // Reset the filteredPosts list to all posts
      });
      reload();
    }
  } else if (post.categoryID == 6 || post.categoryID == 7 || post.categoryID == 8) {
    List<Post> filteredPosts = posts.where((post) =>
    post.categoryID == 6 || post.categoryID == 7 || post.categoryID == 8).toList();
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GardeningPage(posts: filteredPosts,),  // Navigate to GardeningPage
      ),
    );
    if (result == true) {
      setState(() {
          filteredPosts = posts;  // Reset the filteredPosts list to all posts
      });
      reload();
    }
  } else if (post.categoryID == 9) {
    List<Post> filteredPosts = posts.where((post) =>
    post.categoryID == 9).toList();
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetsPage(posts: filteredPosts,),  // Navigate to PetsPage
      ),
    );
    if (result == true) {
      setState(() {
          filteredPosts = posts;  // Reset the filteredPosts list to all posts
        });
      reload();
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background half box decoration
          Container(
            height: 335.0,
            decoration: BoxDecoration(
              color: const Color(0xFF87C4FF).withOpacity(0.6), // 70% opacity
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(90),
              ), // Rounded only top corners
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              children: [
                                const TextSpan(text: 'Welcome!, '),
                                TextSpan(
                                  text: 'Thanadol',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const SizedBox(
                        width: 40,
                        height: 40,
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 35,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotiPage()), // Navigate to NotiPage
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationPage(),
                      ),
                    );

                    if (result != null) {
                      selectedLatitude = result['latitude'].toString();
                      selectedLongitude = result['longitude'].toString();

                      // Use the latitude and longitude
                      load(selectedLatitude!, selectedLongitude!);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF39A7FF),
                            size: 26,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Choose Your Location',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Service',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          // Filter the posts for cleaning categories (1, 2, 3)
                          List<Post> filteredPosts = posts.where((post) => post.categoryID == 1 || post.categoryID == 2 || post.categoryID == 3).toList();
                          setState(() {
                            posts = filteredPosts; // Update the posts list with filtered posts
                          });
                          if (filteredPosts.isNotEmpty) {
                            navigateBasedOnCategory(filteredPosts.first); // Navigate based on the first post's category
                          }
                        },
                        child: buildServiceOption('Cleaning', FontAwesomeIcons.broom),
                      ),

                    GestureDetector(
                      onTap: () {
                        // Filter the posts for clothes categories (4, 5)
                        List<Post> filteredPosts = posts.where((post) => post.categoryID == 4 || post.categoryID == 5).toList();
                        setState(() {
                          posts = filteredPosts; // Update the posts list with filtered posts
                        });
                        if (filteredPosts.isNotEmpty) {
                          navigateBasedOnCategory(filteredPosts.first); // Navigate based on the first post's category
                        }
                      },
                      child: buildServiceOption('Clothes', FontAwesomeIcons.shirt),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Filter the posts for gardening categories (6, 7, 8)
                        List<Post> filteredPosts = posts.where((post) => post.categoryID == 6 || post.categoryID == 7 || post.categoryID == 8).toList();
                        setState(() {
                          posts = filteredPosts; // Update the posts list with filtered posts
                        });
                        if (filteredPosts.isNotEmpty) {
                          navigateBasedOnCategory(filteredPosts.first); // Navigate based on the first post's category
                        }
                      },
                      child: buildServiceOption('Gardening', FontAwesomeIcons.seedling),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Filter the posts for pets categories (9)
                        List<Post> filteredPosts = posts.where((post) => post.categoryID == 9).toList();
                        setState(() {
                          posts = filteredPosts; // Update the posts list with filtered posts
                        });
                        if (filteredPosts.isNotEmpty) {
                          navigateBasedOnCategory(filteredPosts.first); // Navigate based on the first post's category
                        }
                      },
                      child: buildServiceOption('Pets', Icons.pets),
                    ),
                  ],
                ),
                const SizedBox(height: 65),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Worker Available',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Total Found: ${posts.length} in your area', // Use posts.length for the count
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.58,
                    ),
                    itemCount: posts.length, // Use posts.length directly
                    itemBuilder: (context, index) {
                      return WorkerPost(
                        post: posts[index],  // Directly pass the post
                        reload: reload,      // Pass the reload function
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
