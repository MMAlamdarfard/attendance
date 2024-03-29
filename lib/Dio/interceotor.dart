import 'dart:convert';

import 'package:attendance/util/alghoritm.dart';
import 'package:attendance/util/exceptions/main_exception.dart/main_exception.dart';
import 'package:dio/dio.dart';
class AttendanceInterceptor extends Interceptor{
  late Algorithm algorithm;
  AttendanceInterceptor(){
    algorithm = Algorithm();
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.data = {
      "data": algorithm.encryptWithRAZalghorithm(jsonEncode(options.data))  
    };
    super.onRequest(options, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    
    if(err.type == DioExceptionType.sendTimeout || err.type ==DioExceptionType.receiveTimeout || err.type == DioExceptionType.connectionTimeout){
      throw UnknownException(message: "خطای غیر منتظره رخ داده است",statusCode: 100);
    }
    
    super.onError(err, handler);
  }
}