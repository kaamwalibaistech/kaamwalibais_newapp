// To parse this JSON data, do
//
//     final currentPackagePlan = currentPackagePlanFromJson(jsonString);

import 'dart:convert';

CurrentPackagePlan currentPackagePlanFromJson(String str) =>
    CurrentPackagePlan.fromJson(json.decode(str));

String currentPackagePlanToJson(CurrentPackagePlan data) =>
    json.encode(data.toJson());

class CurrentPackagePlan {
  String? status;
  List<Package>? package;

  CurrentPackagePlan({
    this.status,
    this.package,
  });

  factory CurrentPackagePlan.fromJson(Map<String, dynamic> json) =>
      CurrentPackagePlan(
        status: json["status"],
        package: json["package"] == null
            ? []
            : List<Package>.from(
                json["package"]!.map((x) => Package.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "package": package == null
            ? []
            : List<dynamic>.from(package!.map((x) => x.toJson())),
      };
}

class Package {
  String? packageName;
  String? packageType;
  String? avilableCount;
  String? expDate;

  Package({
    this.packageName,
    this.packageType,
    this.avilableCount,
    this.expDate,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageName: json["PackageName"],
        packageType: json["PackageType"],
        avilableCount: json["avilable_count"],
        expDate: json["exp_date"],
      );

  Map<String, dynamic> toJson() => {
        "PackageName": packageName,
        "PackageType": packageType,
        "avilable_count": avilableCount,
        "exp_date": expDate,
      };
}
