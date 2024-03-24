import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class ClassArrowPainter extends CustomPainter{
   final bool isSelected;
 
  ClassArrowPainter(this.isSelected, {super.repaint});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
  ..shader = ui.Gradient.linear(
    Offset(size.width/2, 0),
    Offset(size.width/2, size.height),
    [
       (isSelected)?const Color.fromRGBO(0, 115, 251, 77):const Color.fromARGB(255, 53, 53, 53) ,
       (isSelected)?const Color.fromRGBO(0, 115, 251, 255):const  Color.fromRGBO(0, 0, 0, 255)
      
    ],
  )..strokeWidth=1;
     canvas.drawCircle(Offset(size.width/2, 0), 2, Paint()..color =(isSelected)? const Color.fromRGBO(0, 115, 251, 77):Colors.black);
     canvas.drawLine(Offset(size.width/2, 0), Offset(size.width/2, size.height),paint );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return true;
  }
  
 



}