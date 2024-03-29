class VerificationCodeRequestModel {
  String? verifycode;
  int? username;
  String? uniqcode;

   VerificationCodeRequestModel({this.verifycode, this.username, this.uniqcode});

   VerificationCodeRequestModel.fromJson(Map<String, dynamic> json) {
    verifycode = json['verifycode'];
    username = json['username'];
    uniqcode = json['uniqcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verifycode'] = verifycode;
    data['username'] = username;
    data['uniqcode'] = uniqcode;
    return data;
  }
}