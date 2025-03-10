// To parse this JSON data, do
//
//     final purchasedpackagesJob = purchasedpackagesJobFromJson(jsonString);

import 'dart:convert';

PurchasedpackagesJob purchasedpackagesJobFromJson(String str) =>
    PurchasedpackagesJob.fromJson(json.decode(str));

String purchasedpackagesJobToJson(PurchasedpackagesJob data) =>
    json.encode(data.toJson());

class PurchasedpackagesJob {
  int status;
  String message;
  List<Package> package;

  PurchasedpackagesJob({
    required this.status,
    required this.message,
    required this.package,
  });

  factory PurchasedpackagesJob.fromJson(Map<String, dynamic> json) =>
      PurchasedpackagesJob(
        status: json["status"],
        message: json["message"],
        package:
            List<Package>.from(json["package"].map((x) => Package.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "package": List<dynamic>.from(package.map((x) => x.toJson())),
      };
}

class Package {
  String packageName;
  String avilableCount;
  String expDate;

  Package({
    required this.packageName,
    required this.avilableCount,
    required this.expDate,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageName: json["PackageName"],
        avilableCount: json["avilable_count"],
        expDate: json["exp_date"],
      );

  Map<String, dynamic> toJson() => {
        "PackageName": packageName,
        "avilable_count": avilableCount,
        "exp_date": expDate,
      };
}
