import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.green),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Compare pets',
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Good with other dog section
            PetFeatureCard(
              icon: ClipOval(
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.green,
                  child: Center(
                    child: Image.asset(
                      'assets/dog_icon.png', // You'll need to add this asset
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              title: 'Good with other dog',
              description: 'Lorem Ipsum is simply dummy text of the printing and '
                  'typesetting industry. Lorem Ipsum has been the '
                  'industry\'s standard dummy text ever since the 1500s.',
            ),
            const SizedBox(height: 20),

            // Adaptability section
            PetFeatureCard(
              icon: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.sync,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title: 'Adaptability',
              description: 'Lorem Ipsum is simply dummy text of the printing and '
                  'typesetting industry. Lorem Ipsum has been the '
                  'industry\'s standard dummy text ever since the 1500s.',
            ),
            const SizedBox(height: 20),

            // Watchdog section
            PetFeatureCard(
              icon: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.shield,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              title: 'Watchdog',
              description: 'Lorem Ipsum is simply dummy text of the printing and '
                  'typesetting industry. Lorem Ipsum has been the '
                  'industry\'s standard dummy text ever since the 1500s.',
            ),
          ],
        ),
      ),
    );
  }
}

class PetFeatureCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;

  const PetFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}