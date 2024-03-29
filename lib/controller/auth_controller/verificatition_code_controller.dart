

import 'package:attendance/Dio/dio.dart';

import 'package:attendance/model/auth_model/verification_model/verification_request_model.dart';
import 'package:attendance/util/exceptions/main_exception.dart/main_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


class VerificationCodeController{
   

  late AttendanceDio attendanceDio;
  VerificationCodeController(){
    attendanceDio = AttendanceDio();
    
  } 
  Future<Either<String,MainException>> verifyCode(VerificationCodeRequestModel resquestModel) async{
    try{
    
     Response<dynamic> response = await attendanceDio.getDio().post("signup/mobile/",data:resquestModel.toJson());
     print(response.statusCode);
     if(response.statusCode == 200 || response.statusCode ==201){
        
        return const Left("finish");
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
  
    return Right(MainException(message: e.response?.data["message"],statusCode:e.response?.statusCode??0 ));
   }
   catch(e){
     return Right(UnknownException(message: e.toString(),statusCode: 50)); 
   }
  }
}