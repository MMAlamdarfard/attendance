class SignUpResponceModel {
  String? username;
  String? status;
  SignUpResponceModel({this.username, this.status});
  SignUpResponceModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['status'] = status;
    return data;
  }
}