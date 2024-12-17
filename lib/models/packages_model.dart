// To parse this JSON data, do
//
//     final packagesModel = packagesModelFromJson(jsonString);

import 'dart:convert';

PackagesModel packagesModelFromJson(String str) =>
    PackagesModel.fromJson(json.decode(str));

String packagesModelToJson(PackagesModel data) => json.encode(data.toJson());

class PackagesModel {
  List<Package> candidatePackage;
  List<Package> jobPackage;

  PackagesModel({
    required this.candidatePackage,
    required this.jobPackage,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
        candidatePackage: List<Package>.from(
            json["candidate_package"].map((x) => Package.fromJson(x))),
        jobPackage: List<Package>.from(
            json["job_package"].map((x) => Package.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "candidate_package":
            List<dynamic>.from(candidatePackage.map((x) => x.toJson())),
        "job_package": List<dynamic>.from(jobPackage.map((x) => x.toJson())),
      };
}

class Package {
  String packageId;
  String packageName;
  String validFor;
  String totalCount;
  String price;
  List<String> description;

  Package({
    required this.packageId,
    required this.packageName,
    required this.validFor,
    required this.totalCount,
    required this.price,
    required this.description,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageId: json["PackageId"],
        packageName: json["PackageName"],
        validFor: json["ValidFor"],
        totalCount: json["TotalCount"],
        price: json["Price"],
        description: List<String>.from(json["Description"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "PackageId": packageId,
        "PackageName": packageName,
        "ValidFor": validFor,
        "TotalCount": totalCount,
        "Price": price,
        "Description": List<dynamic>.from(description.map((x) => x)),
      };
}
