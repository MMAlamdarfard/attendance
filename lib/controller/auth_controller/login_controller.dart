import 'package:attendance/Dio/dio.dart';
import 'package:attendance/model/auth_model/login_model/login_responce_model.dart';
import 'package:attendance/util/exceptions/main_exception.dart/main_exception.dart';
import 'package:attendance/util/utill.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginController{
   

  late AttendanceDio attendanceDio;
  late SharedPreferences prefs;
  LoginController(){
    attendanceDio = AttendanceDio(timeOut:5);
    init();
    
  } 
  init() async{
      prefs = await SharedPreferences.getInstance();
  }
  
  
  Future<Either<LoginResponceModel,MainException>> login(String state) async{
    try{
     
     String? uniqueId = await DeviceInformation().getUniqueId();
    
     if(uniqueId == null){
       throw MainException(message: "خطا در ارسال اطلاعات",statusCode: 100);
       
     }
     var data ={
       "state":state,
       "uniqcode":uniqueId
     };
     Response<dynamic> response = await attendanceDio.getDio().post("login",data: data);
     if(response.statusCode == 200 || response.statusCode ==201){
      
        LoginResponceModel loginResponceModel = LoginResponceModel.fromJson(response.data);
        prefs.setString('accessToken',loginResponceModel.accessToken??"");
        prefs.setString('refreshToken',loginResponceModel.refreshToken??"");
        return Left(loginResponceModel);
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