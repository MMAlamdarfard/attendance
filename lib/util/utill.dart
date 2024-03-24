

import 'dart:convert'; 
  
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