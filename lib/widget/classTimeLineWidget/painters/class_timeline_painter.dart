// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:attendance/util/utill.dart';
import 'package:attendance/widget/classTimeLineWidget/class_timeline.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'dart:ui' as ui;

class ClassTimeLinePainter extends CustomPainter{
  final List<SortedClassData> sortedClassData;
  double currentScroll;
  double maxScroll=0;
  double widthofMobile;
  double currentTimeOffset=0;
 final int hour ;
 final int minute;
 
 final bool isToday;
  List<TimeLinePainterModel> widths=[];
  late Jalali nowjalali;
  ClassTimeLinePainter( 
    {super.repaint,
    required this.hour,
    required this.minute,
    required this.sortedClassData,
    required this.currentScroll,
    required this.widthofMobile,
    this.isToday=false}){
       init();
      
    } 
  
  @override
  void paint(Canvas canvas, Size size) {
    
    if(sortedClassData.length>3){
    Jalali nowjalali=Jalali(sortedClassData[2].end?.year??0,sortedClassData[2].end?.month??0,sortedClassData[2].end?.day??0,hour,minute);
   SortedClassData firstTimeLinePainterModel=sortedClassData.firstWhere((element) => element.widgetTypes==WidgetTypes.container);
    SortedClassData lastTimeLinePainterModel=sortedClassData.lastWhere((element) => element.widgetTypes==WidgetTypes.container);
   drawGrid(canvas);
  if(isToday &&nowjalali>=(firstTimeLinePainterModel.start??nowjalali) && nowjalali<=(lastTimeLinePainterModel.end??nowjalali)){
    for(int i=1;i<widths.length;i++){
      TimeLinePainterModel element=widths[i];
      TimeLinePainterModel prevoiusModel=widths[i-1];
      if(prevoiusModel.time<=nowjalali && element.time>=nowjalali){
          int differenceTime=prevoiusModel.time.toDateTime().difference(element.time.toDateTime()).inMinutes.abs();
          int differenceWidth=(element.width-prevoiusModel.width).toInt().abs();
          int distanceWithCurrentTime=prevoiusModel.time.toDateTime().difference(nowjalali.toDateTime()).inMinutes.abs();
          double offsetWidth=(1-(distanceWithCurrentTime/differenceTime))*differenceWidth;
          canvas.drawLine(Offset(widthofMobile+maxScroll, 0), Offset(offsetWidth+element.width+currentScroll+25, 0),Paint()..color=const Color.fromRGBO(0, 115, 251, 1) ..strokeWidth=3);  
          canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(offsetWidth+element.width+currentScroll-25, -12.5, 50,25),const Radius.circular(15)), Paint()..color=const Color.fromRGBO(0, 115, 251,1)); 
          final TextPainter textPainter=time(nowjalali,false);
          textPainter.layout();
          textPainter.paint(canvas, Offset(offsetWidth+element.width+currentScroll-textPainter.width/2,-(textPainter.height/2))); 
          
         
          final paint = Paint()
          ..shader = ui.Gradient.linear(
          Offset(offsetWidth+element.width+currentScroll, -25-2),
          Offset(offsetWidth+element.width+currentScroll, -widthofMobile/2),
          [
            const Color.fromRGBO(0, 115, 251, 77),
            const Color.fromRGBO(0, 115, 251, 255)
          ],
           )..strokeWidth=1;
          
          canvas.drawCircle(Offset(offsetWidth+element.width+currentScroll, -25), 2, Paint()..color = const Color.fromRGBO(0, 115, 251, 77));
          canvas.drawLine(Offset(offsetWidth+element.width+currentScroll, -25-2), Offset(offsetWidth+element.width+currentScroll, -widthofMobile/2),paint);
          
          
          canvas.drawLine(const Offset(0, 0), Offset(offsetWidth+element.width+currentScroll-25, 0),Paint()..color=const Color.fromRGBO(0, 115, 251, 0.5) ..strokeWidth=3);     
    } 
   
   }    
  }
  else{
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0),Paint()..color=const Color.fromRGBO(0, 115, 251, 1) ..strokeWidth=3);  
  }
    }
 
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return true;
  }
  
  void init() {
  
    nowjalali=Jalali.now();
    double width =(widthofMobile-5);
    for(var element in  sortedClassData){
      if(element.widgetTypes==WidgetTypes.defaultGap){
        width-=5;
        maxScroll+=5;
      }
      else if(element.widgetTypes==WidgetTypes.timeGap){
      
        int offset=((element.gapCount==1?60:20)*(element.gapCount??0));
        width-=offset;
        maxScroll+=offset;
      }
      else{       
        widths.add(TimeLinePainterModel(
                   time: element.start??Jalali.now(),
                   width: width)
                  );        
        width-=250;
        maxScroll+=250;
        widths.add(TimeLinePainterModel(
                   time: element.end??Jalali.now(),
                   width: width)
                  );
       
      } 
      List<int> index=[]; 
      for (int i=1; i<widths.length; i++) {
        double currentWidth=widths[i].width;
        double previousWidth=widths[i-1].width;
        if((currentWidth-previousWidth).abs()<=5){
          index.add(i);
        }

      }
      for (var element in index) {
        widths.removeAt(element);
      }
      
     
   }
  
    
  }
  String correctTime(String time){
    if(time.length==1){
      return "0$time";
    }
    return time;
  }
  TextPainter time(Jalali time,bool isgrid){
    double fontSize=isgrid? 12:16;
    Color color=isgrid?Colors.black45:Colors.white;
    return TextPainter(
        text: TextSpan(
          children: [
            TextSpan(
              text:correctTime("${(time.hour)}").toPersianNumber(),
              style:  TextStyle(
                color: color,  
                fontWeight: FontWeight.w600,
                fontSize:fontSize 
              ),
            ),
            TextSpan(
              text: ":",
              style: TextStyle(
                color: color,  
               // fontWeight: FontWeight.w400,
                fontSize: fontSize
              ),
            ),
            TextSpan(
              text: correctTime("${(time.minute)}").toPersianNumber(),
              style: TextStyle(
                color: color,  
                fontWeight: FontWeight.w600,
                fontSize: fontSize
              ),
            ),
           
          ],
          
        ),
        
        textDirection: TextDirection.rtl
      );
  }
  void drawGrid(Canvas canvas){
    canvas.drawLine(Offset(widths[0].width+currentScroll, -10), Offset(widths[0].width+currentScroll, -16),Paint()..color=Colors.black26 ..strokeWidth=1);
    final TextPainter textPainter=time(widths[0].time,true);
    textPainter.layout();
    textPainter.paint(canvas, Offset(widths[0].width+currentScroll-textPainter.width/2,-(textPainter.height/2)-25)); 
    for(int i=1;i<widths.length;i++){
        TimeLinePainterModel element=widths[i];
        TimeLinePainterModel prevoiusModel=widths[i-1];
        int differenceTime=prevoiusModel.time.toDateTime().difference(element.time.toDateTime()).inMinutes.abs();
        int differenceWidth=(element.width-prevoiusModel.width).toInt().abs();
        final TextPainter textPainter=time(element.time,true);
        textPainter.layout();
        textPainter.paint(canvas, Offset(element.width+currentScroll-textPainter.width/2,-(textPainter.height/2)-25)); 
        for(int j=0; j<differenceTime/30; j++){
          double number=differenceWidth/(differenceTime/30);
          double offset=j*number;
         
         
          canvas.drawLine(Offset(element.width+currentScroll+offset, -10), Offset(element.width+currentScroll+offset, -16),Paint()..color=Colors.black26 ..strokeWidth=1);  
        }
        
        
    }
  }




}
class TimeLinePainterModel {
  final Jalali time;
  final double width;

  TimeLinePainterModel({
    required this.time,
    required this.width
  });
}
