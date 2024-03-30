import 'package:attendance/Dio/interceotor.dart';
import 'package:dio/dio.dart';

class AttendanceDio {
  Dio getDio(){
   
    BaseOptions options = BaseOptions(
          baseUrl:"http://razdeveloper.ir/api/",
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 10), 
          receiveTimeout: const Duration(seconds: 10)
    );
    Dio dio = Dio(options);
    
    dio.interceptors.add(AttendanceInterceptor());
    return dio;
  }
}