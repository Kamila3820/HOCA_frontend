import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://example.com/profile_picture.jpg'),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 140,
              child: Container(
                width: 60,
                height: 25,
               
              ),
            ),
          ],
        ),
      ],
    );
  }
} 