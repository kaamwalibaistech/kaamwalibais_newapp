// To parse this JSON data, do
//
//     final employerRegisterOtp = employerRegisterOtpFromJson(jsonString);

import 'dart:convert';

EmployerRegisterOtp employerRegisterOtpFromJson(String str) =>
    EmployerRegisterOtp.fromJson(json.decode(str));

String employerRegisterOtpToJson(EmployerRegisterOtp data) =>
    json.encode(data.toJson());

class EmployerRegisterOtp {
  String status;
  String userId;
  String name;
  String mobileNo;
  String emailId;
  String flag;
  String token;
  String msg;

  EmployerRegisterOtp({
    required this.status,
    required this.userId,
    required this.name,
    required this.mobileNo,
    required this.emailId,
    required this.flag,
    required this.token,
    required this.msg,
  });

  factory EmployerRegisterOtp.fromJson(Map<String, dynamic> json) =>
      EmployerRegisterOtp(
        status: json["status"],
        userId: json["UserId"],
        name: json["Name"],
        mobileNo: json["MobileNo"],
        emailId: json["EmailId"],
        flag: json["flag"],
        token: json["token"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "UserId": userId,
        "Name": name,
        "MobileNo": mobileNo,
        "EmailId": emailId,
        "flag": flag,
        "token": token,
        "msg": msg,
      };
}
