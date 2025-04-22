// To parse this JSON data, do
//
//     final categorylistmodel = categorylistmodelFromJson(jsonString);

import 'dart:convert';

Categorylistmodel categorylistmodelFromJson(String str) =>
    Categorylistmodel.fromJson(json.decode(str));

String categorylistmodelToJson(Categorylistmodel data) =>
    json.encode(data.toJson());

class Categorylistmodel {
  String status;
  List<Datum> data;

  Categorylistmodel({
    required this.status,
    required this.data,
  });

  factory Categorylistmodel.fromJson(Map<String, dynamic> json) =>
      Categorylistmodel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String categoryId;
  String categoryName;

  Datum({
    required this.categoryId,
    required this.categoryName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
      );

  Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "CategoryName": categoryName,
      };
}
