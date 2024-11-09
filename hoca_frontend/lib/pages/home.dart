import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/home/home_components.dart';
import 'package:hoca_frontend/models/post.dart';
import 'package:hoca_frontend/models/profile.dart';
import 'package:hoca_frontend/pages/locatelocation.dart';
import 'package:hoca_frontend/pages/notification.dart';
import 'package:hoca_frontend/pages/service/cleaning.dart';
import 'package:hoca_frontend/pages/service/clothes.dart';
import 'package:hoca_frontend/pages/service/gardening.dart';
import 'package:hoca_frontend/pages/service/pets.dart';
import 'package:page_transition/page_transition.dart';
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
  String? username;
  Profile? profile;
  List<Post> posts = [];
  String selectedLatitude = "";
  String selectedLongitude = "";
  String _locationName = "Choose Your Location"; // Default location text
  bool? hasNewNoti = false;


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
    checkNewNotifications();
      callUserName();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Load location if provided, otherwise use saved location or show alert
    if (widget.latitude != null && widget.longitude != null) {
      setState(() {
        selectedLatitude = widget.latitude!;
        selectedLongitude = widget.longitude!;
        _locationName = widget.address ?? prefs.getString('address') ?? "Choose Your Location";
      });

      await prefs.setString('latitude', selectedLatitude);
      await prefs.setString('longitude', selectedLongitude);
      await prefs.setString('address', _locationName);

      load(selectedLatitude, selectedLongitude);
    } else {
      String? savedLat = prefs.getString('latitude');
      String? savedLong = prefs.getString('longitude');
      String? savedAddress = prefs.getString('address');

      if (savedLat != null && savedLong != null) {
        setState(() {
          selectedLatitude = savedLat;
          selectedLongitude = savedLong;
          _locationName = savedAddress ?? "Choose Your Location";
        });
        load(selectedLatitude, selectedLongitude);
      } else {
        showLocationAlert();
      }
    }
  });
}

 Future<void> _refreshPage() async {
    await reload();
  }

  void callUserName() async {
    String url = "/v1/user/profile";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Caller.dio.get(
      url,
      options: Options(
        headers: {'x-auth-token': '$token'},
      ),
    ).then((response) {
      profile = Profile.fromJson(response.data);
    }).onError((DioException error, _) {
      Caller.handle(context, error);
    });
  }


  void navigateToLocateLocation() async {
  final result = await Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.leftToRight,
      child: const LocateLocationPage(),
      duration: const Duration(milliseconds: 400),
    ),
  );

  if (result is Map && result.containsKey('address')) {
    setState(() {
      _locationName = result['address'];
      selectedLatitude = result['latitude'].toString();
      selectedLongitude = result['longitude'].toString();
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('latitude', selectedLatitude);
    await prefs.setString('longitude', selectedLongitude);
    await prefs.setString('address', _locationName);

    load(selectedLatitude, selectedLongitude);
  }
}


  reload() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLat = prefs.getString('latitude');
  String? savedLong = prefs.getString('longitude');

  if (savedLat != null && savedLong != null) {
    load(savedLat, savedLong);
  } else {
    showLocationAlert();
  }
}


  void checkNewNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  bool? storedNewNoti = prefs.getBool('hasNewNoti');
  setState(() {
    hasNewNoti = storedNewNoti ?? false;
  });
}


load(String latitude, String longitude) async {
  String url = "/v1/post/list?lat=$latitude&long=$longitude";
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  Caller.dio
      .get(
    url,
    options: Options(
      headers: {'x-auth-token': '$token'},
    ),
  )
      .then((response) {
    if (mounted) {
      setState(() {
        posts = (response.data as List)
            .map((postJson) => Post.fromJson(postJson))
            .toList();
      });
    }
  }).onError((DioException error, _) {
    Caller.handle(context, error);
  });
}


  showLocationAlert() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.blue),
            SizedBox(width: 8.0),
            Text('Location Required',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
          ],
        ),
        content: Text(
          'Please choose a location to see available services.',
          style: TextStyle(fontSize: 16.0, color: Colors.black54),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              navigateToLocateLocation();
            },
            child: Text('Choose Location',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshPage, // This is the function that will be called on pull-to-refresh
        child: Stack(
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
                                    fontSize: 18, color: Colors.white),
                              ),
                              children: [
                                const TextSpan(text: 'Welcome!, '),
                                TextSpan(
                                  text: profile?.username!,
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Stack(
                        children: [
                          const SizedBox(
                            width: 40,
                            height: 40,
                            child: FaIcon(
                              FontAwesomeIcons.bell,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 35,
                            ),
                          ),
                          if (hasNewNoti!)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.topToBottom,
                            child: const NotiPage(),
                            duration: const Duration(milliseconds: 300),
                          ),
                        ).then((_) async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('hasNewNoti', false);
                          checkNewNotifications();
                        });
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
                          Expanded(
                            child: Text(
                              _locationName,
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
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
  onTap: () {
    List<Post> filteredPosts = posts
        .where((post) => 
          post.categoryID?.any((category) => category.groupID == 1) ?? false
        )
        .toList();
    
    setState(() {
      posts = filteredPosts;
    });

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: CleanPage(posts: filteredPosts),
        duration: const Duration(milliseconds: 300),
      ),
    ).then((result) {
      if (result == true) {
        reload();
      }
    });
  },
  child: buildServiceOption(
    'Cleaning', 
    FontAwesomeIcons.broom
  ),
),
                    GestureDetector(
                      onTap: () {
                        List<Post> filteredPosts = posts
        .where((post) => 
          post.categoryID?.any((category) => category.groupID == 2) ?? false
        )
        .toList();
    
    setState(() {
      posts = filteredPosts;
    });
                        // Removed the isEmpty check, directly navigate to CleanPage
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ClothesPage(posts: filteredPosts),
                            duration: const Duration(milliseconds: 300),
                          ),
                        ).then((result) {
                          if (result == true) {
                            reload();
                          }
                        });
                      },
                      child:
                          buildServiceOption('Clothes', FontAwesomeIcons.shirt),
                    ),
                    GestureDetector(
                      onTap: () {
                        List<Post> filteredPosts = posts
        .where((post) => 
          post.categoryID?.any((category) => category.groupID == 3) ?? false
        )
        .toList();
    
    setState(() {
      posts = filteredPosts;
    });
                        // Removed the isEmpty check, always navigate
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: GardeningPage(posts: filteredPosts),
                            duration: const Duration(milliseconds: 300),
                          ),
                        ).then((result) {
                          if (result == true) {
                            reload();
                          }
                        });
                      },
                      child: buildServiceOption(
                          'Gardening', FontAwesomeIcons.seedling),
                    ),
                    GestureDetector(
                      onTap: () {
                        List<Post> filteredPosts = posts
        .where((post) => 
          post.categoryID?.any((category) => category.groupID == 4) ?? false
        )
        .toList();
    
    setState(() {
      posts = filteredPosts;
    });
                        // Removed the isEmpty check, directly navigate to CleanPage
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: PetsPage(posts: filteredPosts),
                            duration: const Duration(milliseconds: 300),
                          ),
                        ).then((result) {
                          if (result == true) {
                            reload();
                          }
                        });
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
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
      ),
    );
  }
}
