import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/models/homepost.dart';
import 'package:hoca_frontend/models/placetype.dart';
import 'package:hoca_frontend/models/post.dart';
import 'package:hoca_frontend/models/posts.dart';
import 'package:hoca_frontend/pages/reserve/reserve.dart';

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

  String getPlaceTypeNames(List<PlaceType> placeTypes) {
  return placeTypes.map((placeType) => placeType.name ?? "Unknown").join(" / ");
}

  @override
  Widget build(BuildContext context) {
    String categoryType = "";

    if (widget.post.categoryID == 1) {
      categoryType = "Deep cleaning";
    }
    if (widget.post.categoryID == 2) {
      categoryType = "Floor care";
    }
    if (widget.post.categoryID == 3) {
      categoryType = "Window care";
    }
    if (widget.post.categoryID == 4) {
      categoryType = "Laundry";
    }
    if (widget.post.categoryID == 5) {
      categoryType = "Sewing";
    }
    if (widget.post.categoryID == 6) {
      categoryType = "Lawn mowing";
    }
    if (widget.post.categoryID == 7) {
      categoryType = "Watering";
    }
    if (widget.post.categoryID == 8) {
      categoryType = "Yard cleanup";
    }
    if (widget.post.categoryID == 9) {
      categoryType = "Pet sitting";
    }
   
    // Get the place type names from placeTypeID
     String placeTypeNames = widget.post.placeTypeID != null && widget.post.placeTypeID!.isNotEmpty
      ? getPlaceTypeNames(widget.post.placeTypeID!)
      : "Unknown"; // Fallback if there are no place types

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReservePage()), // Replace with your ReservePage
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
              color: Colors.black.withOpacity(0.2), // Shadow color with opacity
              spreadRadius: 1, // How much the shadow spreads
              blurRadius: 3, // How blurry the shadow is
              offset: const Offset(0, 2), // Position of the shadow (x, y)
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
                height: 180, // Adjust the height as needed
                fit: BoxFit.cover, // Adjust the image fit
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
                      alignment: Alignment.center, // Center the black star on the yellow star
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 10, // Smaller size for the black star
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
                width: 45, // Set the desired width for the green box
                height: 15, // Set the desired height for the green box
                decoration: const BoxDecoration(
                  color: Color(0xFF90D26D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),    // Adjust the radius for the top-left corner
                    bottomRight: Radius.circular(6), // Adjust the radius for the bottom-right corner
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
              top: 190, // Position under the image
              left: 2,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEED9), // Light peach color
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1), // Shadow color
                              spreadRadius: 1, // How much the shadow spreads
                              blurRadius: 3, // How blurry the shadow is
                              offset: const Offset(0, 2), // Position of the shadow (x, y)
                            ),
                          ],
                        ),
                        child: Text(
                          categoryType,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 6,
                              color: Color.fromARGB(228, 0, 0, 0), // Ensure readability against the light background
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Positioned(
              top: 210, // Adjust this value to position the column below the row of boxes
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
                    margin: const EdgeInsets.only(left: 3), // Adjust this value to move text to the right
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
                    margin: const EdgeInsets.only(left: 3), // Same left margin for consistency
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on, // Location icon
                          color: Color(0xFF39A7FF), // Change the color as needed
                          size: 12, // Adjust the size of the icon
                        ),
                        const SizedBox(width: 4), // Space between the icon and text
                        Text(
                          widget.post.distance! + " km",
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
                    margin: const EdgeInsets.only(left: 3), // Same left margin for consistency
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
              bottom: 10, // Position it near the bottom of the card
              right: 12, // Align it to the right
              child: Text(
                "฿ "+ widget.post.price.toString(),
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
}
