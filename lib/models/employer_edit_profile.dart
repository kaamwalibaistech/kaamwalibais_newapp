// To parse this JSON data, do
//
//     final empolyereditprofilemodel = empolyereditprofilemodelFromJson(jsonString);

import 'dart:convert';

Empolyereditprofilemodel empolyereditprofilemodelFromJson(String str) =>
    Empolyereditprofilemodel.fromJson(json.decode(str));

String empolyereditprofilemodelToJson(Empolyereditprofilemodel data) =>
    json.encode(data.toJson());

class Empolyereditprofilemodel {
  String status;
  String msg;

  Empolyereditprofilemodel({
    required this.status,
    required this.msg,
  });

  factory Empolyereditprofilemodel.fromJson(Map<String, dynamic> json) =>
      Empolyereditprofilemodel(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
