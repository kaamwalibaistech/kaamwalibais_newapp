// To parse this JSON data, do
//
//     final applyCandidateStatusUpdate = applyCandidateStatusUpdateFromJson(jsonString);

import 'dart:convert';

ApplyCandidateStatusUpdate applyCandidateStatusUpdateFromJson(String str) =>
    ApplyCandidateStatusUpdate.fromJson(json.decode(str));

String applyCandidateStatusUpdateToJson(ApplyCandidateStatusUpdate data) =>
    json.encode(data.toJson());

class ApplyCandidateStatusUpdate {
  String status;
  String msg;

  ApplyCandidateStatusUpdate({
    required this.status,
    required this.msg,
  });

  factory ApplyCandidateStatusUpdate.fromJson(Map<String, dynamic> json) =>
      ApplyCandidateStatusUpdate(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
