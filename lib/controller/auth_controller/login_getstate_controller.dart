import 'package:attendance/Dio/dio.dart';
import 'package:attendance/util/exceptions/main_exception.dart/main_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetStateLoginController{
   

  late AttendanceDio attendanceDio;
  late SharedPreferences prefs;
  GetStateLoginController(){
    attendanceDio = AttendanceDio(timeOut:5);
    init();
    
  } 
  init() async{
      prefs = await SharedPreferences.getInstance();
  }
  
  
  Future<Either<String,MainException>> getState() async{
    try{
    
     Response<dynamic> response = await attendanceDio.getDio().post("login/getState",);
     if(response.statusCode == 200 || response.statusCode ==201){
        String state = response.data['message'];
        prefs.setString('state', state);
        return Left(state);
     }
     else if(response.statusCode == 500 || response.statusCode == 501){
      throw ServerException(message: "خطای سرور لطفا بعدا تلاش کنید", statusCode: response.statusCode??500);
     }
     else if(response.statusCode == 403){
       throw VpnException(message: "اگر به vpn متصل هستید ان را قطع کنید", statusCode: response.statusCode??400); 
     }
     else if(response.statusCode == 401){
      throw MainException(message: "هویت شما تایید نشده است", statusCode: 401);
     }
     else{
      throw UnknownException(message: "خطای نامشخص ${response.data}", statusCode: response.statusCode??0);
     }
   }
   on UnknownException catch(e){
    return Right(e);
   }
   on VpnException catch(e){
    return Right(e);
   }
   on ServerException catch(e){
    return Right(e);
   }
   on DioException catch(e){
    Response<dynamic>? res =e.response;
    if(res!=null){
      try{
        return Right(MainException(message: res.data["message"],statusCode:res.statusCode??0 )); 
      }catch(e){
        return Right(MainException(message: "خطای سرور لطفا شکیبا باشید",statusCode:res.statusCode??0 ));
      }
    }
    else{
      
      if(e.type ==DioExceptionType.unknown){
         return Right(ServerException(message:e.message??".خطای سرور لطفا شکیبا باشید" ,statusCode: 100));
      }else{
        return Right(ServerException(message: "خطای غیره منتظره ای رخ داده است لطفا بعدا تلاش کنید", statusCode: 500));
      }
      
    }
   }
   catch(e){
    
     return Right(UnknownException(message: e.toString(),statusCode: 50)); 
   }
  }



}