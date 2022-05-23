// To parse this JSON data, do
//
//     final cityList = cityListFromJson(jsonString);

import 'dart:convert';

CityList cityListFromJson(String str) => CityList.fromJson(json.decode(str));

String cityListToJson(CityList data) => json.encode(data.toJson());

class CityList {
  CityList({
    this.result,
  });

  final List<Result> result;

  factory CityList.fromJson(Map<String, dynamic> json) => CityList(
    result: json["result"] == null ? null : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.countryCode,
    this.countryName,
    this.cityCode,
    this.description,
  });

  final String countryCode;
  final String countryName;
  final String cityCode;
  final String description;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    countryCode: json["CountryCode"] == null ? null : json["CountryCode"],
    countryName: json["CountryName"] == null ? null : json["CountryName"],
    cityCode: json["CityCode"] == null ? null : json["CityCode"],
    description: json["Description"] == null ? null : json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "CountryCode": countryCode == null ? null : countryCode,
    "CountryName": countryName == null ? null : countryName,
    "CityCode": cityCode == null ? null : cityCode,
    "Description": description == null ? null : description,
  };
}
