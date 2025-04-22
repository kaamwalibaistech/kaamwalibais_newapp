// To parse this JSON data, do
//
//     final employerRegisterModel = employerRegisterModelFromJson(jsonString);

import 'dart:convert';

EmployerRegisterModel employerRegisterModelFromJson(String str) =>
    EmployerRegisterModel.fromJson(json.decode(str));

String employerRegisterModelToJson(EmployerRegisterModel data) =>
    json.encode(data.toJson());

class EmployerRegisterModel {
  String status;
  String userId;
  String name;
  String mobileNo;
  String emailId;
  String flag;
  String token;
  String msg;

  EmployerRegisterModel({
    required this.status,
    required this.userId,
    required this.name,
    required this.mobileNo,
    required this.emailId,
    required this.flag,
    required this.token,
    required this.msg,
  });

  factory EmployerRegisterModel.fromJson(Map<String, dynamic> json) =>
      EmployerRegisterModel(
        status: json["status"] ?? "",
        userId: json["UserId"] ?? "",
        name: json["Name"] ?? "",
        mobileNo: json["MobileNo"] ?? "",
        emailId: json["EmailId"] ?? "",
        flag: json["flag"] ?? "",
        token: json["token"] ?? "",
        msg: json["msg"] ?? "",
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
