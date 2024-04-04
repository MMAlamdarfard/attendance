import 'package:flutter/material.dart';
import 'dart:math';

class HexagonPainter extends CustomPainter {
  final double shadow;

  HexagonPainter({super.repaint, required this.shadow});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    // Gradient
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    paint.shader = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color.fromARGB(255, 12, 121, 211),
               Color.fromRGBO(2, 183, 255, 1),  ], // Adjust gradient colors as needed
    ).createShader(rect);

    // Shadow
    paint.maskFilter =  MaskFilter.blur(BlurStyle.normal,  shadow);

    // Hexagon Path
    double width = size.width;
    double height = size.height;
    double centerX = width / 2;
    double centerY = height / 2;
    double radius = width / 2;
    double angle = (2 * pi / 6); // 60 degrees in radians

    Path path = Path();
    path.moveTo(centerX + radius * cos(pi/6), centerY + radius * sin(pi/6));
    for (int i = 1; i <= 6; i++) {
      path.lineTo(centerX + radius * cos((angle * i)+pi/6),
          centerY + radius * sin((angle * i)+pi/6));
    }
    path.close();

    // Draw hexagon
    canvas.drawPath(path, paint);
    paint.maskFilter=null;
    canvas.drawPath(path,paint );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyHexagon extends StatelessWidget {
  final double shadow;
  const MyHexagon({super.key, required this.shadow});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      
      painter: HexagonPainter(shadow: shadow),
      child:const Icon(
        Icons.home,
        color: Colors.white,
      )
    );
  }
}

