
import 'package:attendance/util/alghoritm.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
class AttendanceInterceptor extends Interceptor{
  late Algorithm algorithm;
  AttendanceInterceptor(){
    algorithm = Algorithm();
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
   
   isConnected()
   .then((value){
   
     if(value == 1){
      // options.data = {
      //  "data": algorithm.encryptWithRAZalghorithm(jsonEncode(options.data))  
      // };
      super.onRequest(options, handler);
     }else{
       handler.reject(
        DioException(
          requestOptions:RequestOptions(),
          type: DioExceptionType.unknown,
          message: "لطفا اتصال خود را به اینترنت  چک کنید"
        )
      );
     }
   });
    
  }
  Future<int> isConnected() async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult.contains(ConnectivityResult.mobile) || 
     connectivityResult.contains(ConnectivityResult.wifi)    ||
     connectivityResult.contains(ConnectivityResult.ethernet)
  ) {
    return 1; 
  }  else  {
    return 0;
  } 

}
}