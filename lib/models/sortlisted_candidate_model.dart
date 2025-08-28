// To parse this JSON data, do
//
//     final shortlistedcandidatemodel = shortlistedcandidatemodelFromJson(jsonString);

import 'dart:convert';

Shortlistedcandidatemodel shortlistedcandidatemodelFromJson(String str) =>
    Shortlistedcandidatemodel.fromJson(json.decode(str));

String shortlistedcandidatemodelToJson(Shortlistedcandidatemodel data) =>
    json.encode(data.toJson());

class Shortlistedcandidatemodel {
  int status;
  String message;

  Shortlistedcandidatemodel({
    required this.status,
    required this.message,
  });

  factory Shortlistedcandidatemodel.fromJson(Map<String, dynamic> json) =>
      Shortlistedcandidatemodel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
