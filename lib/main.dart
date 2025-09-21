import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:zentime/screens/dashboard_screen.dart';
import 'package:zentime/screens/settings_screen.dart';
import 'package:zentime/screens/statistics_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('days');

  /*
  Tutorial

  First: WidgetsFlutterBinding.ensureInitialized();
  -> Ensures that everything is initialized

  Then:
  await Hive.initFlutter();
  await Hive.openBox('days');
  -> Start hive and open the database

  Create a key for the current day. Use:
  String todayKey = DateTime(2025, 09, 21).toIso8601String().split('T').first;
  -> Only the day gets saved, not the time as well

  Check-In:
  Create a DayEntry with the current day and with the correct sick and holiday bools
  Create a workSession with the start and end set to DateTime.now()
  Create an empty breakSession []
  Use:
  await Hive.box('days').put(todayKey, today.toJson());
  to save

  Break clicked:
  Load the DayEntry with:
  today = DayEntry.fromJson(Hive.box('days').get(todayKey));

  Edit the last worksession and set the end to now, leave the start as it was
  Create a new breakSession with the start and end set to now.
  Save the DayEntry to hive

  Work clicked:
  Exactly like break, but edit the breaksession and create a new worksession

  Check-Out clicked:
  Edit the last worksession and set the end to now
  If the last session was a breaksession, edit the breaksession
  */

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zentime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  final List<Widget> pages = const [
    DashboardScreen(),
    StatisticsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Dashboard',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.leaderboard),
            icon: Icon(Icons.leaderboard_outlined),
            label: 'Statistics',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
