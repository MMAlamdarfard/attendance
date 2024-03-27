
import 'package:attendance/Dio/dio.dart';
import 'package:dio/dio.dart';


class LoginController{
   
  late Dio dio;
  LoginController(){
    AttendanceDio attendanceDio = AttendanceDio();
    dio = attendanceDio.getDio();
  } 
  Future<LoginModel?> login(RequestModel resquestModel) async{
   
   try{
     Response<dynamic> response = await dio.post("login",);
     
     return LoginModel(status:response.statusCode??0,model:ResponceModel.fromJson(response.data) );
   }
   catch(e){
     return null;
   }
   
  
  }

   

}

class LoginModel{
  final int status;
  final ResponceModel model;
  LoginModel({required this.status, required this.model});
}
class RequestModel {
  String? username;
  String? password;
  String? uniqid;

  RequestModel({this.username, this.password, this.uniqid});

  RequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    uniqid = json['uniqid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['uniqid'] = uniqid;
    return data;
  }
}
class ResponceModel {
  String? type;
  String? data;
  ResponceModel ({this.type, this.data});
  ResponceModel .fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['data'] = this.data;
    return data;
  }
}