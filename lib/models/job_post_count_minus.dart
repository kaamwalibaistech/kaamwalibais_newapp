// To parse this JSON data, do
//
//     final jobpostcountminus = jobpostcountminusFromJson(jsonString);

import 'dart:convert';

Jobpostcountminus jobpostcountminusFromJson(String str) =>
    Jobpostcountminus.fromJson(json.decode(str));

String jobpostcountminusToJson(Jobpostcountminus data) =>
    json.encode(data.toJson());

class Jobpostcountminus {
  String status;
  String msg;

  Jobpostcountminus({
    required this.status,
    required this.msg,
  });

  factory Jobpostcountminus.fromJson(Map<String, dynamic> json) =>
      Jobpostcountminus(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
