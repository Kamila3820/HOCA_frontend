import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/models/categories.dart';
import 'package:hoca_frontend/models/homepost.dart';
import 'package:hoca_frontend/models/placetype.dart';
import 'package:hoca_frontend/models/post.dart';
import 'package:hoca_frontend/models/posts.dart';
import 'package:hoca_frontend/pages/reserve/reserve.dart';
import 'package:page_transition/page_transition.dart';

class WorkerPost extends StatefulWidget {
  final Post post;
  const WorkerPost({
    super.key,
    required this.post,
    required this.reload,
  });
  final VoidCallback reload;

  @override
  State<WorkerPost> createState() => _WorkerPostState();
}

class _WorkerPostState extends State<WorkerPost> {
  HomePost? posts;
  Posts? post;

  @override
  void initState() {
    super.initState();
  }

  List<String> getCategoryNames(List<Categories> categories) {
    return categories.map((category) => category.name).take(3).toList();
  }

  String getPlaceTypeNames(List<PlaceType> placeTypes) {
    return placeTypes.map((placeType) => placeType.name ?? "Unknown").join(" / ");
  }

  @override
  Widget build(BuildContext context) {
    List<String> selectedCategories = widget.post.categoryID != null 
        ? getCategoryNames(widget.post.categoryID!)
        : ["Unknown"];
        
    // Get the place type names from placeTypeID
     String placeTypeNames = widget.post.placeTypeID != null && widget.post.placeTypeID!.isNotEmpty
      ? getPlaceTypeNames(widget.post.placeTypeID!)
      : "Unknown"; // Fallback if there are no place types

  return GestureDetector(
    onTap: () {
      Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.bottomToTop,
    child: ReservePage(postID: widget.post.postID.toString()),
    duration: const Duration(milliseconds: 400),
  ),
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
                widget.post.avatarUrl!, // Replace with your image URL
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            if (widget.post.totalScore != 0.0)
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
                      widget.post.totalScore.toString(),
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
                top: 185,
                left: 2,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...selectedCategories.map((category) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEED9), 
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            category,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(228, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      )).toList(),
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
                    widget.post.name!,
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
                      widget.post.gender!,
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
      "${widget.post.distance!} km",
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 10,
          color: Colors.black54,
        ),
      ),
    ),
    const SizedBox(width: 8), // Add spacing before the pipe
    const Text(
      '|', // Pipe separator
      style: TextStyle(
        fontSize: 10,
        color: Colors.black54,
      ),
    ),
    const SizedBox(width: 8), // Add spacing after the pipe
    const FaIcon(
      FontAwesomeIcons.running, // Font Awesome walking man icon
      color: Colors.black54,
      size: 12,
    ),
    const SizedBox(width: 4),
    Text(
      "฿${widget.post.distanceFee}", // The text you want to add
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
                      placeTypeNames,
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
                "฿ ${widget.post.price}",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
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
}
