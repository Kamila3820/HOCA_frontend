import 'package:flutter/material.dart';

class ServiceFeaturesPage extends StatefulWidget {
  const ServiceFeaturesPage({super.key});

  @override
  State<ServiceFeaturesPage> createState() => _ServiceFeaturesPageState();
}

class _ServiceFeaturesPageState extends State<ServiceFeaturesPage> {
  bool isAgreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Color(0xFF87C4FF)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Service Features',
          style: TextStyle(
            color: Color(0xFF87C4FF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Payment Section
              FeatureCard(
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFF87C4FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.payment,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                title: 'Payment Options',
                description: 'Secure payment processing with multiple options including credit cards, '
                    'digital wallets, and installment plans. All transactions are encrypted '
                    'and protected.',
              ),
              const SizedBox(height: 20),

              // Search Section
              FeatureCard(
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFF87C4FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                title: 'Advanced Search',
                description: 'Find exactly what you need with our powerful search features. '
                    'Filter by location, service type, price range, and availability. '
                    'Save your favorite searches for quick access.',
              ),
              const SizedBox(height: 20),

              // User Verification Section
              FeatureCard(
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFF87C4FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.verified_user,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                title: 'User Verification',
                description: 'Enhanced security with verified user profiles. Multi-factor '
                    'authentication and identity verification ensure a safe and '
                    'trusted community.',
              ),
              const SizedBox(height: 20),

              // Ratings Section
              FeatureCard(
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFF87C4FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                title: 'User Ratings',
                description: 'Transparent rating system with verified reviews. '
                    'Rate and review services, view detailed feedback, and make '
                    'informed decisions based on user experiences.',
              ),
              const SizedBox(height: 30),

              // Terms Checkbox
              Row(
                children: [
                  Checkbox(
                    value: isAgreedToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        isAgreedToTerms = value ?? false;
                      });
                    },
                    activeColor: Color(0xFF87C4FF),
                  ),
                  Expanded(
                    child: Text(
                      'I agree to the Terms of Use',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isAgreedToTerms 
                    ? () {
                        // Add your button action here
                        print('Terms agreed, button pressed!');
                      } 
                    : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF87C4FF),
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

class FeatureCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;

  const FeatureCard({
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
            color: Color(0xFF87C4FF),
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