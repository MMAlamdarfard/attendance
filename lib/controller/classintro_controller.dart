// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:attendance/model/another_model/classdata_model.dart';
import 'package:attendance/model/another_model/geolocation.dart';

class ClassDataController{
   
  Dio dio = Dio();
  late SharedPreferences _prefs;
  ClassDataController() {
    initPrefs();
    dio.options.baseUrl = "http://razdeveloper.ir/";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.sendTimeout = const Duration(seconds: 10);
    
  } 
  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }
  Future<ClassDataModel?> getClassData() async{
   
   try{
     Response<dynamic> response = await dio.get("classdata",);
     return ClassDataModel.fromJson(response.data);
   }
   catch(e){
  
     return null;
   }
   
  
  }

  Future<Today?> getTodayDate() async{ 
   try{
     Response<dynamic> response = await dio.post("dashboard",);
     return Today.fromJson(response.data);
   }
   catch(e){
     return null;
   }
  }
  
  Future<GeoLocation?> getBuildingData() async{
    try{
      Response<dynamic> response = await dio.get("api/building/get",);
      Map<String,dynamic> finalData={};
      finalData["building"]=response.data;
      return GeoLocation.fromJson(finalData);

    }catch(e){
       return null;
    }
  }
  
 Future<MainClassDataModel?> prepareMainClassDataModel({Today? todayInput}) async{
  
   
   
   Today? today = todayInput ?? await getTodayDate();
   
   if(today!=null){
     
     
         String? data = _prefs.getString("ClassData"); 
         String? geoData = _prefs.getString("GeoData");
         if((data!=null && data!="")&&(geoData!=null && geoData!="")){
           ClassDataModel classDataModel=ClassDataModel.fromJson(jsonDecode(data));
           GeoLocation geoLocation=GeoLocation.fromJson(jsonDecode(geoData));
           return MainClassDataModel(
            classDataModel: classDataModel,
            today: today,
            classGeoLocation: geoLocation);      
         }
         else{ 
          GeoLocation? geo = await getBuildingData();
          ClassDataModel? classDataModel = await getClassData();
          if(classDataModel != null && geo!=null){
            _prefs.setString("ClassData", jsonEncode(classDataModel.toJson()));
            _prefs.setString("GeoData", jsonEncode(geo.toJson()));
               return prepareMainClassDataModel(todayInput: today);
            
          } 
           
          
          
         
          
         
      }
   
   
  } 
  return null;

  }  

}
class MainClassDataModel {
    ClassDataModel classDataModel;
    GeoLocation classGeoLocation;
    Today today;
  MainClassDataModel({
    required this.classDataModel,
    required this.classGeoLocation,
    required this.today,
  });

}
