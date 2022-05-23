

// To parse this JSON data, do
//
//     final bankName = bankNameFromJson(jsonString);

import 'dart:convert';

List<BankName> bankNameFromJson(String str) => List<BankName>.from(json.decode(str).map((x) => BankName.fromJson(x)));

String bankNameToJson(List<BankName> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankName {
  BankName({
    this.code,
    this.name,
  });

  final String code;
  final String name;

  factory BankName.fromJson(Map<String, dynamic> json) => BankName(
    code: json["Code"] == null ? null : json["Code"],
    name: json["Name"] == null ? null : json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Name": name == null ? null : name,
  };
}
