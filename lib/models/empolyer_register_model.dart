// To parse this JSON data, do
//
//     final otp = otpFromJson(jsonString);

import 'dart:convert';

Otp otpFromJson(String str) => Otp.fromJson(json.decode(str));

String otpToJson(Otp data) => json.encode(data.toJson());

class Otp {
  String status;
  String otp;
  String msg;

  Otp({
    required this.status,
    required this.otp,
    required this.msg,
  });

  factory Otp.fromJson(Map<String, dynamic> json) => Otp(
        status: json["status"],
        otp: json["otp"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "otp": otp,
        "msg": msg,
      };
}
