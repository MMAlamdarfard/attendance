

import 'dart:convert';
import 'dart:io'; 
  
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart' as root_bundle; 
  
class ReadJsonFile{ 
    static Future<Map<String,dynamic>> readJsonData({required String path}) async { 
      
    // read json file 
    final jsondata = await root_bundle.rootBundle.loadString(path); 
      
    // decode json data as list 
    final list = json.decode(jsondata) as Map<String,dynamic>; 
  
    // map json and initialize 
    // using DataModel 
    return list; 
  }
  
}
extension PersianNumberExtension on String {
  String toPersianNumber() {
    Map<String, String> numberMap = {
      '0': '۰',
      '1': '۱',
      '2': '۲',
      '3': '۳',
      '4': '۴',
      '5': '۵',
      '6': '۶',
      '7': '۷',
      '8': '۸',
      '9': '۹',
    };

    return replaceAllMapped(
      RegExp(r'\d'),
      (Match m) => numberMap[m.group(0)!]!,
    );
  }
}
class DeviceInformation{
  
  Future<String?> getUniqueId() async{
     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
     AndroidDeviceInfo androidInfo;
     //IosDeviceInfo iosInfo;
     try {
       
         if (Platform.isAndroid) {
             androidInfo = await deviceInfo.androidInfo;
             return "Android|${androidInfo.hardware}|${androidInfo.id}|${androidInfo.brand}|${androidInfo.model}|${androidInfo.host}|${androidInfo.board}";
         } 
         else{
          return null;
         }
         //else if (Platform.isIOS) {
        //       iosInfo = await deviceInfo.iosInfo;
        //       print('Device Model: ${iosInfo.model}');
        //       print('Device Unique ID: ${iosInfo.identifierForVendor}');
        // }
        } catch (e) {
          return null;
        } 
    
   
  }
 

}