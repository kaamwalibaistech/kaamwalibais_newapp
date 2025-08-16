import 'dart:convert';

Homepagemodel? homepagemodelFromJson(String str) =>
    str.isNotEmpty ? Homepagemodel.fromJson(json.decode(str)) : null;

String homepagemodelToJson(Homepagemodel? data) =>
    data != null ? json.encode(data.toJson()) : '';

class Homepagemodel {
  String? status;
  List<Categorylist>? categorylist;
  List<Joblist>? joblist;
  List<Advlist>? advlist;
  List<Advlist>? banner;

  Homepagemodel({
    this.status,
    this.categorylist,
    this.joblist,
    this.advlist,
    this.banner,
  });

  factory Homepagemodel.fromJson(Map<String, dynamic> json) => Homepagemodel(
        status: json["status"],
        categorylist: json["Categorylist"] != null
            ? List<Categorylist>.from(
                json["Categorylist"].map((x) => Categorylist.fromJson(x)))
            : null,
        joblist: json["joblist"] != null
            ? List<Joblist>.from(
                json["joblist"].map((x) => Joblist.fromJson(x)))
            : null,
        advlist: json["Advlist"] != null
            ? List<Advlist>.from(
                json["Advlist"].map((x) => Advlist.fromJson(x)))
            : null,
        banner: json["banner"] != null
            ? List<Advlist>.from(json["banner"].map((x) => Advlist.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Categorylist": categorylist?.map((x) => x.toJson()).toList(),
        "joblist": joblist?.map((x) => x.toJson()).toList(),
        "Advlist": advlist?.map((x) => x.toJson()).toList(),
        "banner": banner?.map((x) => x.toJson()).toList(),
      };
}

class Advlist {
  String? advertismentId;
  String? url;
  String? image;

  Advlist({
    this.advertismentId,
    this.url,
    this.image,
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
  String? categoryId;
  String? categoryName;
  String? image;

  Categorylist({
    this.categoryId,
    this.categoryName,
    this.image,
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
  String? jobpostId;
  String? age;
  String? gender;
  String? religion;
  String? maritalStatus;
  String? jobLocation;
  String? workingHours;
  dynamic experience;
  String? monthPrice;
  String? jobType;
  String? postedBy;

  Joblist({
    this.jobpostId,
    this.age,
    this.gender,
    this.religion,
    this.maritalStatus,
    this.jobLocation,
    this.workingHours,
    this.experience,
    this.monthPrice,
    this.jobType,
    this.postedBy,
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
