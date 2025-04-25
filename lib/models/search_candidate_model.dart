// To parse this JSON data, do
//
//     final searchCandidateModel = searchCandidateModelFromJson(jsonString);

import 'dart:convert';

SearchCandidateModel searchCandidateModelFromJson(String str) =>
    SearchCandidateModel.fromJson(json.decode(str));

String searchCandidateModelToJson(SearchCandidateModel data) =>
    json.encode(data.toJson());

class SearchCandidateModel {
  String status;
  String candidateCount;
  List<SearchcandidateData> data;

  SearchCandidateModel({
    required this.status,
    required this.candidateCount,
    required this.data,
  });

  factory SearchCandidateModel.fromJson(Map<String, dynamic> json) =>
      SearchCandidateModel(
        status: json["status"],
        candidateCount: json["candidate_count"],
        data: List<SearchcandidateData>.from(
            json["data"].map((x) => SearchcandidateData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "candidate_count": candidateCount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchcandidateData {
  String? candidateId;
  String? categoryName;
  String mobileNo;
  String? jobType;
  String? serviceLocation;
  String? rating;
  String? aadharCard;
  String? otherDocuments;
  String? passposrt;
  String? age;
  String? maritalStatus;
  String? religion;
  String? totalExp;
  String? expectedSalary;
  String? gender;
  String? maximumEducation;
  String? workingHours;
  List<Language?> language;
  String? image;
  String? alreadySorted;
  String? ratingCount;
  bool? isVisible;

  SearchcandidateData(
      {required this.candidateId,
      required this.categoryName,
      required this.mobileNo,
      required this.jobType,
      required this.serviceLocation,
      required this.rating,
      required this.aadharCard,
      required this.otherDocuments,
      required this.passposrt,
      required this.age,
      required this.maritalStatus,
      required this.religion,
      required this.totalExp,
      required this.expectedSalary,
      this.gender,
      required this.maximumEducation,
      required this.workingHours,
      required this.language,
      required this.image,
      required this.alreadySorted,
      required this.ratingCount,
      this.isVisible = false});

  factory SearchcandidateData.fromJson(Map<String, dynamic> json) =>
      SearchcandidateData(
        candidateId: json["candidate_id"] ?? "",
        categoryName: json["CategoryName"] ?? "",
        mobileNo: json["MobileNo"],
        jobType: json["job_type"] ?? "",
        serviceLocation: json["ServiceLocation"] ?? "",
        rating: json["rating"] ?? "",
        aadharCard: json["AadharCard"] ?? "",
        otherDocuments: json["OtherDocuments"] ?? "",
        passposrt: json["passposrt"] ?? "",
        age: json["Age"] ?? "",
        maritalStatus: json["MaritalStatus"] ?? "",
        religion: json["Religion"] ?? "",
        totalExp: json["TotalExp"] ?? "",
        expectedSalary: json["ExpectedSalary"] ?? "",
        gender: json["Gender"] ?? "",
        maximumEducation: json["MaximumEducation"] ?? "",
        workingHours: json["WorkingHours"] ?? "",
        language: List<Language>.from(
            json["Language"].map((x) => languageValues.map[x]!) ?? ""),
        image: json["image"] ?? "",
        alreadySorted: json["already_sorted"] ?? "",
        ratingCount: json["rating_count"] ?? "",
        isVisible: json["false"],
      );

  Map<String, dynamic> toJson() => {
        "candidate_id": candidateId ?? "",
        "CategoryName": categoryName ?? "",
        "MobileNo": mobileNo,
        "job_type": jobType ?? "",
        "ServiceLocation": serviceLocation ?? "",
        "rating": rating ?? "",
        "AadharCard": aadharCard ?? "",
        "OtherDocuments": otherDocuments ?? "",
        "passposrt": passposrt ?? "",
        "Age": age ?? "",
        "MaritalStatus": maritalStatus ?? "",
        "Religion": religion ?? "",
        "TotalExp": totalExp ?? "",
        "ExpectedSalary": expectedSalary ?? "",
        "Gender": gender ?? "",
        "MaximumEducation": maximumEducation ?? "",
        "WorkingHours": workingHours ?? "",
        "Language": List<dynamic>.from(
            language.map((x) => languageValues.reverse[x] ?? "")),
        "image": image ?? "",
        "already_sorted": alreadySorted ?? "",
        "rating_count": ratingCount ?? "",
        "isVisible": "false"
      };
}

enum Language { ENGLISH, HINDI, MARATHI }

final languageValues = EnumValues({
  "English": Language.ENGLISH,
  "Hindi": Language.HINDI,
  "Marathi": Language.MARATHI
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
