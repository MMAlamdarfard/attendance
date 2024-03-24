import 'package:flutter/material.dart';

class TimeLineConstant{
   final BuildContext context;
   TimeLineConstant({required this.context});
   double mobileWidth()=>MediaQuery.of(context).size.width;
   double mobileHeight()=>MediaQuery.of(context).size.height;
   double get classTimlineContainerWidth{
     return (1.618*mobileHeight())/3;
   }
   double get classContainerHeight{
     return mobileHeight()/12;
   }
   

}