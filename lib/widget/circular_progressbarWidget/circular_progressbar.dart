import 'package:attendance/widget/circular_progressbarWidget/curcular_progresspaint.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
 
  final double value;
  final Color color;

  const CircularProgress({super.key, required this.value,required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularProgressPainter(value: value,color: color),
    );
  }
}