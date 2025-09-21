import 'package:flutter/material.dart';
import 'package:zentime/Widgets/dashed_line.dart';

class TimelineItem extends StatelessWidget {
  final String time;
  final String label;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.time,
    required this.label,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(height: 4),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 4),
            if (!isLast) SizedBox(height: 100, child: DashedLine(height: 100)),
          ],
        ),
        SizedBox(width: 8),
        Column(
          children: [
            SizedBox(width: 80, child: Text(time, textAlign: TextAlign.left, style: TextStyle(color: Colors.blue),)),
            SizedBox(height: 40),
            SizedBox(width: 80, child: Text(label, textAlign: TextAlign.left)),
          ],
        ),
      ],
    );
  }
}
