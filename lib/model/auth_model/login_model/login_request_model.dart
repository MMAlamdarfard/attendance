class LoginRequestModel {
  int? username;
  String? password;
  String? uniqcode;

  LoginRequestModel({this.username, this.password, this.uniqcode});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    uniqcode = json['uniqcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['uniqcode'] = uniqcode;
    return data;
  }
}