import 'dart:async';
import 'dart:io';

import 'package:attendance/page/student_page/dashboard_page.dart';
import 'package:attendance/page/student_page/setting_page.dart';
import 'package:attendance/page/student_page/statistic_page.dart';
import 'package:attendance/util/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 1;
  DateTime? _lastPressedAt;
  late bool canPop ;
  @override
  void initState() {
    canPop = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       body: PopScope(
        canPop: Platform.isAndroid? false:true,
        onPopInvoked: ((didPop) {
          
            willPop().then((value){
             if(value){
              SystemNavigator.pop();
             }
            });
          
           
        
         
        }),
        child:  getPage()
      ) ,
       bottomNavigationBar:  Container(
       decoration: const BoxDecoration(
          color: Colors.white,
         boxShadow:[

                     BoxShadow(
                       color: Color.fromRGBO(0, 0, 0,0.15),
                       offset: Offset(1, 1),
                       blurRadius: 4               
                     )
                   ]
        ), 
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  index = 0;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings_outlined,
                    color: index ==0? Colors.blue.shade600 :Colors.grey.shade600 ,
                  ),
                  Text(
                    "تنظیمات",
                    style:TextStyle(
                      color: index ==0?Colors.blue.shade600: Colors.grey.shade600  ,
                      fontSize: 10,
                    ) ,
                  )
                ],
              ),
            ),
            
            InkWell(
               onTap: (){
                setState(() {
                  index = 1;
                });
              },
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: index ==1? Colors.blue.shade600 :Colors.grey.shade600 ,
                  ),
                  Text(
                    "داشبورد",
                    style:TextStyle(
                      color: index ==1? Colors.blue.shade600 : Colors.grey.shade600,
                      fontSize: 10,
                    ) ,
                  )
                ],
                           ),
             ),
           
            
            InkWell(
               onTap: (){
                setState(() {
                  index = 2;
                });
              },
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.insert_chart_outlined,
                    color: index ==2? Colors.blue.shade600 :Colors.grey.shade600 ,
                  ),
                  Text(
                    "تاریخچه",
                    style:TextStyle(
                      color: index ==2? Colors.blue.shade600 : Colors.grey.shade600,
                      fontSize: 10,
                    ) ,
                  )
                ],
                           ),
             ),
           
          ]
        ),
       ),
       
    );
  }
  Future<bool> willPop() async{
    if(Platform.isAndroid){
        DateTime now = DateTime.now();
        if (_lastPressedAt == null || now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          CustomSnackBar().showWarningSnackBar(context, "لطفا جهت خروج,دکمه برگشت را مجدد کلیک کنید");
          return false;
        }
        return true;
    }
    return false;
     
  }
  Widget getPage(){
   if(index == 0){
    return const StatisticPage();
   }
   else if(index == 2){
    return const SettingPage();
   }
   else{
    return const StudentDashboardPage();
   }
  }
}