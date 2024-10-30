import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hoca_frontend/components/navbar/creatpostbutton.dart';
import 'package:hoca_frontend/components/navbar/customnavbar.dart';
import 'package:hoca_frontend/pages/history.dart';
import 'package:hoca_frontend/pages/home.dart';
import 'package:hoca_frontend/pages/login.dart';
import 'package:hoca_frontend/pages/profile.dart';
import 'package:hoca_frontend/pages/progress.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(const HOCAApp());
}

class HOCAApp extends StatelessWidget {
  const HOCAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOCA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        '/home': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String?>?;
          return MainScreen(
            latitude: args?['latitude'],
            longitude: args?['longitude'],
          );
        },
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final String? latitude;
  final String? longitude;
  final String? address;  // Add this line

  const MainScreen({
    super.key, 
    this.latitude, 
    this.longitude,
    this.address,  // Add this line
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

   @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        latitude: widget.latitude,
        longitude: widget.longitude,
        address: widget.address,  // Add this line
      ),
      const HistoryPage(),
      const ProgressPage(),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}