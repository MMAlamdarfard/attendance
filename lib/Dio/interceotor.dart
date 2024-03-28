import 'dart:convert';

import 'package:attendance/util/alghoritm.dart';
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
}