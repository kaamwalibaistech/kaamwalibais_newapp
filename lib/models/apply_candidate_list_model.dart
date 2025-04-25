// To parse this JSON data, do
//
//     final applyCandidateList = applyCandidateListFromJson(jsonString);

import 'dart:convert';

ApplyCandidateList applyCandidateListFromJson(String str) =>
    ApplyCandidateList.fromJson(json.decode(str));

String applyCandidateListToJson(ApplyCandidateList data) =>
    json.encode(data.toJson());

class ApplyCandidateList {
  String status;
  List<ApplyList> applyList;

  ApplyCandidateList({
    required this.status,
    required this.applyList,
  });

  factory ApplyCandidateList.fromJson(Map<String, dynamic> json) =>
      ApplyCandidateList(
        status: json["status"],
        applyList: List<ApplyList>.from(
            json["apply_list"].map((x) => ApplyList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "apply_list": List<dynamic>.from(applyList.map((x) => x.toJson())),
      };
}

class ApplyList {
  String applyId;
  String candidateName;
  String phoneNo;
  String email;
  String city;
  String status;
  String categoryName;
  String applyDate;

  ApplyList({
    required this.applyId,
    required this.candidateName,
    required this.phoneNo,
    required this.email,
    required this.city,
    required this.status,
    required this.categoryName,
    required this.applyDate,
  });

  factory ApplyList.fromJson(Map<String, dynamic> json) => ApplyList(
        applyId: json["apply_id"],
        candidateName: json["candidate_name"],
        phoneNo: json["phone_no"],
        email: json["email"],
        city: json["city"],
        status: json["status"],
        categoryName: json["CategoryName"],
        applyDate: json["apply_date"],
      );

  Map<String, dynamic> toJson() => {
        "apply_id": applyId,
        "candidate_name": candidateName,
        "phone_no": phoneNo,
        "email": email,
        "city": city,
        "status": status,
        "CategoryName": categoryName,
        "apply_date": applyDate,
      };
}
