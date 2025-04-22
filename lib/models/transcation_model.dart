// To parse this JSON data, do
//
//     final razorpaytranscationModel = razorpaytranscationModelFromJson(jsonString);

import 'dart:convert';

RazorpaytranscationModel razorpaytranscationModelFromJson(String str) =>
    RazorpaytranscationModel.fromJson(json.decode(str));

String razorpaytranscationModelToJson(RazorpaytranscationModel data) =>
    json.encode(data.toJson());

class RazorpaytranscationModel {
  String status;
  String msg;

  RazorpaytranscationModel({
    required this.status,
    required this.msg,
  });

  factory RazorpaytranscationModel.fromJson(Map<String, dynamic> json) =>
      RazorpaytranscationModel(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
