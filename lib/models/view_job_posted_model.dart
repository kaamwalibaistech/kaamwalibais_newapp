// To parse this JSON data, do
//
//     final viewjobpostedModel = viewJobPostedFromJson(jsonString);

import 'dart:convert';

ViewjobpostedModel viewJobPostedFromJson(String str) =>
    ViewjobpostedModel.fromJson(json.decode(str));

String viewJobPostedToJson(ViewjobpostedModel data) =>
    json.encode(data.toJson());

class ViewjobpostedModel {
  String status;
  List<JobpostList> jobpostList;

  ViewjobpostedModel({
    required this.status,
    required this.jobpostList,
  });

  factory ViewjobpostedModel.fromJson(Map<String, dynamic> json) =>
      ViewjobpostedModel(
        status: json["status"],
        jobpostList: List<JobpostList>.from(
            json["jobpost_list"].map((x) => JobpostList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "jobpost_list": List<dynamic>.from(jobpostList.map((x) => x.toJson())),
      };
}

class JobpostList {
  String jobpostId;
  String categoryName;
  String jobLocation;
  String postDate;
  int totalApply;
  String status;

  JobpostList({
    required this.jobpostId,
    required this.categoryName,
    required this.jobLocation,
    required this.postDate,
    required this.totalApply,
    required this.status,
  });

  factory JobpostList.fromJson(Map<String, dynamic> json) => JobpostList(
        jobpostId: json["jobpost_id"],
        categoryName: json["CategoryName"],
        jobLocation: json["job_location"],
        postDate: json["post_date"],
        totalApply: json["total_apply"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "jobpost_id": jobpostId,
        "CategoryName": categoryName,
        "job_location": jobLocation,
        "post_date": postDate,
        "total_apply": totalApply,
        "status": status,
      };
}
