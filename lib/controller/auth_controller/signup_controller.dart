

import 'package:attendance/Dio/dio.dart';
import 'package:attendance/model/auth_model/signup_model/signup_request_model.dart';
import 'package:attendance/model/auth_model/signup_model/signup_responce_model.dart';
import 'package:attendance/util/exceptions/main_exception.dart/main_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


class SignUpController{
   

  late AttendanceDio attendanceDio;
  SignUpController(){
    attendanceDio = AttendanceDio();
    
  } 
  Future<Either<SignUpResponceModel,MainException>> signUp(SignupRequestModel resquestModel) async{
    try{
    
     Response<dynamic> response = await attendanceDio.getDio().post("signup/username/",data:resquestModel.toJson());
     if(response.statusCode == 200 || response.statusCode ==201){
        SignUpResponceModel signUpResponceModel = SignUpResponceModel.fromJson(response.data);
        return Left(signUpResponceModel);
     }
     else if(response.statusCode == 500 || response.statusCode == 501){
      throw ServerException(message: "خطای سرور لطفا بعدا تلاش کنید", statusCode: response.statusCode??500);
     }
     else if(response.statusCode == 403){
       throw VpnException(message: "اگر به vpn متصل هستید ان را قطع کنید", statusCode: response.statusCode??400); 
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
       return Right(MainException(message: res.data["message"],statusCode:res.statusCode??0 ));
    }
    else{
      if(e.type ==DioExceptionType.unknown){
         return Right(ServerException(message:e.message??"خطای غیره منتظره ای رخ داده است لطفا بعدا تلاش کنید" ,statusCode: 100));
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