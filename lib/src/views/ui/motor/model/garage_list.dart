// To parse this JSON data, do
//
//     final garageList = garageListFromJson(jsonString);

import 'dart:convert';

GarageList garageListFromJson(String str) => GarageList.fromJson(json.decode(str));

String garageListToJson(GarageList data) => json.encode(data.toJson());

class GarageList {
  GarageList({
    this.result,
  });

  final List<Result> result;

  factory GarageList.fromJson(Map<String, dynamic> json) => GarageList(
    result: json["result"] == null ? null : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.label,
    this.value,
  });

  final String label;
  final String value;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    label: json["Label"] == null ? null : json["Label"],
    value: json["Value"] == null ? null : json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Label": label == null ? null : label,
    "Value": value == null ? null : value,
  };
}
