import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hoca_frontend/models/login.dart';
import 'package:hoca_frontend/pages/history.dart';
import 'package:hoca_frontend/pages/home.dart';
import 'package:hoca_frontend/pages/login.dart';
import 'package:hoca_frontend/pages/profile.dart';
import 'package:hoca_frontend/pages/progress.dart';
import 'package:hoca_frontend/widget/CustomScaffold.dart';

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
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }


  final List<Widget> _pages = [
    const HomePage(),
    HistoryPage(),
    const ProgressPage(),
    const ProfilePage(),
  ];

  final List<String> _titles = [
    'Home',
    'History',
    'Progress',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: _titles[_currentIndex],
      body: _pages[_currentIndex],
      currentIndex: _currentIndex,
      onItemTapped: _onItemTapped,
    );
  }
}