// To parse this JSON data, do
//
//     final createjobpostmodel = createjobpostmodelFromJson(jsonString);

import 'dart:convert';

Createjobpostmodel createjobpostmodelFromJson(String str) =>
    Createjobpostmodel.fromJson(json.decode(str));

String createjobpostmodelToJson(Createjobpostmodel data) =>
    json.encode(data.toJson());

class Createjobpostmodel {
  String status;
  String msg;

  Createjobpostmodel({
    required this.status,
    required this.msg,
  });

  factory Createjobpostmodel.fromJson(Map<String, dynamic> json) =>
      Createjobpostmodel(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
