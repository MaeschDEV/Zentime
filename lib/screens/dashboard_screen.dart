import 'package:flutter/material.dart';
import 'package:zentime/Widgets/timeline_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.green),
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
                  Icon(Icons.login, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Check-In',
                    style: TextStyle(color: Colors.green, fontSize: 16),
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
}
