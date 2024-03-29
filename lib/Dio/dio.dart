import 'package:attendance/Dio/interceotor.dart';
import 'package:dio/dio.dart';

class AttendanceDio {
  Dio getDio(){
   
    BaseOptions options = BaseOptions(
          baseUrl:"http://razdeveloper.ir/api/",
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 5), // 60 seconds
          receiveTimeout: const Duration(seconds: 5)// 60 seconds
    );
    Dio dio = Dio(options);
    dio.interceptors.add(AttendanceInterceptor());
    return dio;
  }
}