import 'package:flutter/material.dart';
import 'package:zentime/Widgets/dashed_line_painter.dart';

class DashedLine extends StatelessWidget {
  final double height;

  const DashedLine({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(0, height), painter: DashedLinePainter());
  }
}
