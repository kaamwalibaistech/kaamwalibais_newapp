// To parse this JSON data, do
//
//     final employerProfileEdit = employerProfileEditFromJson(jsonString);

import 'dart:convert';

EmployerProfileEdit employerProfileEditFromJson(String str) =>
    EmployerProfileEdit.fromJson(json.decode(str));

String employerProfileEditToJson(EmployerProfileEdit data) =>
    json.encode(data.toJson());

class EmployerProfileEdit {
  String status;
  String msg;

  EmployerProfileEdit({
    required this.status,
    required this.msg,
  });

  factory EmployerProfileEdit.fromJson(Map<String, dynamic> json) =>
      EmployerProfileEdit(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
