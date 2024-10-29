import 'package:flutter/material.dart';
import 'package:hoca_frontend/components/profile/ProfilePic.dart';

class ProfileHeader extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPickImage;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.isLoading,
    required this.onPickImage,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF87C4FF).withOpacity(0.6),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(90),
          bottomRight: Radius.circular(90),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  ProfilePic(
                    isLoading: isLoading,
                    onPickImage: onPickImage,
                    imageUrl: imageUrl,
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