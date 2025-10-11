import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zentime/DataTypes/day_entry.dart';
import 'package:zentime/DataTypes/work_session.dart';
import 'package:zentime/Widgets/timeline_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool checkedIn = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            "[Aktion]",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "00:00",
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text("Work: 0h 0min", style: TextStyle(fontSize: 16)),
          Text("Break: 0h 0min", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 32),
          SizedBox(
            width: 218,
            child: OutlinedButton(
              onPressed: checkedIn ? onCheckOutClicked : onCheckInClicked,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: checkedIn ? Colors.red : Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login,
                    color: checkedIn ? Colors.red : Colors.green,
                  ),
                  SizedBox(width: 8),
                  Text(
                    checkedIn ? 'Checked-Out' : 'Check-In',
                    style: TextStyle(
                      color: checkedIn ? Colors.red : Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 218,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.coffee, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Break',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 92,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.blueGrey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.sick, color: Colors.blueGrey),
                      SizedBox(width: 8),
                      Text(
                        'Sick',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 118,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.blueGrey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.beach_access, color: Colors.blueGrey),
                      SizedBox(width: 8),
                      Text(
                        'Holiday',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TimelineItem(time: '8:00 AM', label: 'Work'),
                  TimelineItem(time: '11:30 AM', label: 'Break'),
                  TimelineItem(time: '12:30 AM', label: 'Work'),
                  TimelineItem(time: '12:30 AM', label: 'Work'),
                  TimelineItem(time: '12:30 AM', label: 'Work'),
                  TimelineItem(time: '17:00 AM', label: '', isLast: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onCheckInClicked() async {
    print('Check-In clicked!');
    setState(() {
      checkedIn = !checkedIn;
    });

    String todayKey = DateTime.now().toIso8601String().split('T').first;

    DayEntry today = DayEntry(
      day: DateTime.now(),
      workSessions: [WorkSession(start: DateTime.now(), end: DateTime.now())],
      breakSessions: [],
      sick: false,
      holiday: false,
    );

    await Hive.box('days').put(todayKey, today.toJson());
  }

  onCheckOutClicked() async {
    print('Check-Out clicked!');
    setState(() {
      checkedIn = !checkedIn;
    });

    String todayKey = DateTime.now().toIso8601String().split('T').first;

    DayEntry today = DayEntry.fromJson(Hive.box('days').get(todayKey));
    today.workSessions.last = WorkSession(
      start: today.workSessions.last.start,
      end: DateTime.now(),
    );

    await Hive.box('days').put(todayKey, today.toJson());
  }
}
