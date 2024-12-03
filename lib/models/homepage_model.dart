// To parse this JSON data, do
//
//     final homepagemodel = homepagemodelFromJson(jsonString);

import 'dart:convert';

Homepagemodel homepagemodelFromJson(String str) =>
    Homepagemodel.fromJson(json.decode(str));

String homepagemodelToJson(Homepagemodel data) => json.encode(data.toJson());

class Homepagemodel {
  String status;
  List<Categorylist> categorylist;
  List<Joblist> joblist;
  List<Advlist> advlist;
  List<Advlist> banner;

  Homepagemodel({
    required this.status,
    required this.categorylist,
    required this.joblist,
    required this.advlist,
    required this.banner,
  });

  factory Homepagemodel.fromJson(Map<String, dynamic> json) => Homepagemodel(
        status: json["status"],
        categorylist: List<Categorylist>.from(
            json["Categorylist"].map((x) => Categorylist.fromJson(x))),
        joblist:
            List<Joblist>.from(json["joblist"].map((x) => Joblist.fromJson(x))),
        advlist:
            List<Advlist>.from(json["Advlist"].map((x) => Advlist.fromJson(x))),
        banner:
            List<Advlist>.from(json["banner"].map((x) => Advlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Categorylist": List<dynamic>.from(categorylist.map((x) => x.toJson())),
        "joblist": List<dynamic>.from(joblist.map((x) => x.toJson())),
        "Advlist": List<dynamic>.from(advlist.map((x) => x.toJson())),
        "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
      };
}

class Advlist {
  String advertismentId;
  String url;
  String image;

  Advlist({
    required this.advertismentId,
    required this.url,
    required this.image,
  });

  factory Advlist.fromJson(Map<String, dynamic> json) => Advlist(
        advertismentId: json["advertisment_id"],
        url: json["url"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "advertisment_id": advertismentId,
        "url": url,
        "image": image,
      };
}

class Categorylist {
  String categoryId;
  String categoryName;
  String image;

  Categorylist({
    required this.categoryId,
    required this.categoryName,
    required this.image,
  });

  factory Categorylist.fromJson(Map<String, dynamic> json) => Categorylist(
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "CategoryName": categoryName,
        "image": image,
      };
}

class Joblist {
  String jobpostId;
  String age;
  String gender;
  String religion;
  String maritalStatus;
  String jobLocation;
  String workingHours;
  String experience;
  String monthPrice;
  String jobType;
  String postedBy;

  Joblist({
    required this.jobpostId,
    required this.age,
    required this.gender,
    required this.religion,
    required this.maritalStatus,
    required this.jobLocation,
    required this.workingHours,
    required this.experience,
    required this.monthPrice,
    required this.jobType,
    required this.postedBy,
  });

  factory Joblist.fromJson(Map<String, dynamic> json) => Joblist(
        jobpostId: json["jobpost_id"],
        age: json["Age"],
        gender: json["Gender"],
        religion: json["Religion"],
        maritalStatus: json["Marital_Status"],
        jobLocation: json["job_location"],
        workingHours: json["working_hours"],
        experience: json["Experience"],
        monthPrice: json["month_price"],
        jobType: json["job_type"],
        postedBy: json["posted_by"],
      );

  Map<String, dynamic> toJson() => {
        "jobpost_id": jobpostId,
        "Age": age,
        "Gender": gender,
        "Religion": religion,
        "Marital_Status": maritalStatus,
        "job_location": jobLocation,
        "working_hours": workingHours,
        "Experience": experience,
        "month_price": monthPrice,
        "job_type": jobType,
        "posted_by": postedBy,
      };
}
