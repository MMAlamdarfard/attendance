

import 'package:attendance/util/utill.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressPainter extends CustomPainter {
  final double strokeWidth=6;
  final double value;
  final Color color;
  CircularProgressPainter( {required this.color,required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    
    final double radius = size.width / 2;
    final double angle = 2 * pi * ((100-value) / 100);
    Paint backgroundPaint = Paint()
      ..color = const Color(0xFFD9D9D9).withOpacity(0.45)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    Paint foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(
      Offset(radius, radius),
      radius - strokeWidth / 2,
      backgroundPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius - strokeWidth / 2),
      0 ,
      -angle,
      false,
      foregroundPaint,
    );
  
     final TextPainter textPainter=percentage((100-value).toStringAsFixed(1));
     textPainter.layout();
     textPainter.paint(canvas, Offset(radius -textPainter.width/2, radius-(textPainter.height/2))); 
          
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  TextPainter percentage(String percent){
    final List<String> splits =percent.split(".");
    return TextPainter(
        text: TextSpan(
          children: [
            TextSpan(
              text:splits[0].toPersianNumber(),
              style:  TextStyle(
                color: color,  
                fontWeight: FontWeight.w600,
                fontSize:14 
              ),
            ),
             TextSpan(
              text:'/',
              style:  TextStyle(
                color: color,  
                fontWeight: FontWeight.w400,
                fontSize:12 
              ),
            ),
             TextSpan(
              text:splits[1].toPersianNumber(),
              style:  TextStyle(
                color: color,  
                fontWeight: FontWeight.w600,
                fontSize:14 
              ),
            ),
            TextSpan(
              text: "%",
              style: TextStyle(
                color: color,  
               // fontWeight: FontWeight.w400,
                fontSize: 12
              ),
            ),
           
          ],
          
        ),
        
        textDirection: TextDirection.rtl
      );
  }
}