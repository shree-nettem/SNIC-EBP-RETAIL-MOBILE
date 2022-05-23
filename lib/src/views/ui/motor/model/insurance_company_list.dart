// To parse this JSON data, do
//
//     final insuranceCompanyList = insuranceCompanyListFromJson(jsonString);

import 'dart:convert';

InsuranceCompanyList insuranceCompanyListFromJson(String str) => InsuranceCompanyList.fromJson(json.decode(str));

String insuranceCompanyListToJson(InsuranceCompanyList data) => json.encode(data.toJson());

class InsuranceCompanyList {
  InsuranceCompanyList({
    this.result,
  });

  List<String> result;

  factory InsuranceCompanyList.fromJson(Map<String, dynamic> json) => InsuranceCompanyList(
    result: List<String>.from(json["result"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x)),
  };
}
