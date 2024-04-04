import 'package:attendance/Dio/interceotor.dart';
import 'package:dio/dio.dart';

class AttendanceDio {
  final int timeOut;
  AttendanceDio({required this.timeOut});
  Dio getDio(){
   
    BaseOptions options = BaseOptions(
          baseUrl:"http://razdeveloper.ir/api/",
          receiveDataWhenStatusError: true,
          connectTimeout:  Duration(seconds:timeOut ), 
          receiveTimeout:  Duration(seconds:timeOut)
    );
    Dio dio = Dio(options);
    
    dio.interceptors.add(AttendanceInterceptor());
    return dio;
  }
}