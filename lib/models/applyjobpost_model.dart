// To parse this JSON data, do
//
//     final applyjobpost = applyjobpostFromJson(jsonString);

import 'dart:convert';

Applyjobpost applyjobpostFromJson(String str) =>
    Applyjobpost.fromJson(json.decode(str));

String applyjobpostToJson(Applyjobpost data) => json.encode(data.toJson());

class Applyjobpost {
  String status;
  String msg;

  Applyjobpost({
    required this.status,
    required this.msg,
  });

  factory Applyjobpost.fromJson(Map<String, dynamic> json) => Applyjobpost(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
