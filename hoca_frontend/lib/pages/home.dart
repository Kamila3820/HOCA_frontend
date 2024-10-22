import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/home/home_components.dart';
import 'package:hoca_frontend/models/post.dart';
import 'package:hoca_frontend/pages/locatelocation.dart';
import 'package:hoca_frontend/pages/notification.dart';
import 'package:hoca_frontend/pages/service/cleaning.dart';
import 'package:hoca_frontend/pages/service/clothes.dart';
import 'package:hoca_frontend/pages/service/gardening.dart';
import 'package:hoca_frontend/pages/service/pets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String? latitude;
  final String? longitude;
  final String? address;

  const HomePage({super.key, this.latitude, this.longitude, this.address});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];
  String selectedLatitude = "";
  String selectedLongitude = "";
  String _locationName = "Choose Your Location"; // Default location text

  String get shortenedLocation {
    if (_locationName.length > 20) {
      return '${_locationName.substring(0, 20)}...';
    }
    return _locationName;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.latitude != null && widget.longitude != null) {
      selectedLatitude = widget.latitude!;
      selectedLongitude = widget.longitude!;
      _locationName = widget.address ?? "Choose Your Location";
      load(selectedLatitude, selectedLongitude);
    } else {
      _showLocationAlert();  // Ask the user to select location if none is provided.
    }
    });
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
    if (selectedLongitude == null) {
      _showLocationAlert();
    } else {
      load(selectedLatitude, selectedLongitude);
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
                navigateToLocateLocation();  // Navigate to the location selection page
              },
              child: const Text('Choose Location'),
            ),
          ],
        );
      },
    );
  }

  void updateLocation(String newLocation) {
    setState(() {
      _locationName = newLocation;
    });
  }

  void navigateToLocateLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocateLocationPage(),
      ),
    );

    // Check if the result is a Map and contains 'address'
    if (result is Map<String, dynamic> && result.containsKey('address')) {
      updateLocation(result['address']);
      setState(() {
        selectedLatitude = result['latitude'].toString();
        selectedLongitude = result['longitude'].toString();
      });
      load(selectedLatitude, selectedLongitude);
    } else {
      print('Unexpected result: $result');
    }
  }

  void navigateBasedOnCategory(Post post) async {
    if (post.categoryID == 1 || post.categoryID == 2 || post.categoryID == 3) {
      List<Post> filteredPosts = posts.where((post) =>
      post.categoryID == 1 || post.categoryID == 2 || post.categoryID == 3).toList();
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CleanPage(posts: filteredPosts),
        ),
      );
      if (result == true) {
        setState(() {
          filteredPosts = posts;
        });
        reload();
      }
    } else if (post.categoryID == 4 || post.categoryID == 5) {
      List<Post> filteredPosts = posts.where((post) =>
      post.categoryID == 4 || post.categoryID == 5).toList();
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClothesPage(posts: filteredPosts),
        ),
      );
      if (result == true) {
        setState(() {
          filteredPosts = posts;
        });
        reload();
      }
    } else if (post.categoryID == 6 || post.categoryID == 7 || post.categoryID == 8) {
      List<Post> filteredPosts = posts.where((post) =>
      post.categoryID == 6 || post.categoryID == 7 || post.categoryID == 8).toList();
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GardeningPage(posts: filteredPosts,),
        ),
      );
      if (result == true) {
        setState(() {
          filteredPosts = posts;
        });
        reload();
      }
    } else if (post.categoryID == 9) {
      List<Post> filteredPosts = posts.where((post) =>
      post.categoryID == 9).toList();
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PetsPage(posts: filteredPosts,),
        ),
      );
      if (result == true) {
        setState(() {
          filteredPosts = posts;
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
          Container(
            height: 335.0,
            decoration: BoxDecoration(
              color: const Color(0xFF87C4FF).withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(90),
              ),
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
                            builder: (context) => const NotiPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: navigateToLocateLocation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                          Expanded(
                            child: Text(
                              shortenedLocation,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                        List<Post> filteredPosts = posts.where((post) => post.categoryID == 1 || post.categoryID == 2 || post.categoryID == 3).toList();
                        setState(() {
                          posts = filteredPosts;
                        });
                        if (filteredPosts.isNotEmpty) {
                          navigateBasedOnCategory(filteredPosts.first);
                        }
                      },
                      child: buildServiceOption('Cleaning', FontAwesomeIcons.broom),
                    ),
                    GestureDetector(
                      onTap: () {
                        List<Post> filteredPosts = posts.where((post) => post.categoryID == 4 || post.categoryID == 5).toList();
                        setState(() {
                          posts = filteredPosts;
                        });
                        if (filteredPosts.isNotEmpty) {
                          navigateBasedOnCategory(filteredPosts.first);
                        }
                      },
                      child: buildServiceOption('Clothes', FontAwesomeIcons.shirt),
                    ),
                    GestureDetector(
                      onTap: () {
                        List<Post> filteredPosts = posts.where((post) => post.categoryID == 6 || post.categoryID == 7 || post.categoryID == 8).toList();
                        setState(() {
                          posts = filteredPosts;
                        });
                        if (filteredPosts.isNotEmpty) {
                          navigateBasedOnCategory(filteredPosts.first);
                        }
                      },
                      child: buildServiceOption('Gardening', FontAwesomeIcons.seedling),
                    ),
                    GestureDetector(
                      onTap: () {
                        List<Post> filteredPosts = posts.where((post) => post.categoryID == 9).toList();
                        setState(() {
                          posts = filteredPosts;
                        });
                        if (filteredPosts.isNotEmpty) {
                          navigateBasedOnCategory(filteredPosts.first);
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
                      'Total Found: ${posts.length} in your area',
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
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return WorkerPost(
                        post: posts[index],
                        reload: reload,
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
