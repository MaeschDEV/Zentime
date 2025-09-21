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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 80, child: Text(time, textAlign: TextAlign.right)),
        const SizedBox(width: 16),
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast) SizedBox(height: 50, child: DashedLine(height: 50)),
          ],
        ),
        const SizedBox(width: 16),
        Padding(
          padding: EdgeInsetsGeometry.directional(
            start: 0,
            end: 0,
            top: 25,
            bottom: 0,
          ),
          child: SizedBox(
            width: 80,
            child: Text(label, textAlign: TextAlign.left),
          ),
        ),
      ],
    );
  }
}
