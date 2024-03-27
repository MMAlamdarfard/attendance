import 'package:attendance/Dio/interceotor.dart';
import 'package:dio/dio.dart';

class AttendanceDio {
  Dio getDio(){
    Dio dio = Dio();
    dio.options.baseUrl = "http://razdeveloper.ir/api/";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.sendTimeout = const Duration(seconds: 10);
    dio.interceptors.add(AttendanceInterceptor());
    return dio;
  }
}