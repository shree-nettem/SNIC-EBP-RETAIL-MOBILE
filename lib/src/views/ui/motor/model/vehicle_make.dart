




// To parse this JSON data, do
//
//     final vehicleMake = vehicleMakeFromJson(jsonString);

import 'dart:convert';

List<VehicleMake> vehicleMakeFromJson(String str) => List<VehicleMake>.from(json.decode(str).map((x) => VehicleMake.fromJson(x)));

String vehicleMakeToJson(List<VehicleMake> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VehicleMake {
  VehicleMake({
    this.code,
    this.description,
  });

  final String code;
  final String description;

  factory VehicleMake.fromJson(Map<String, dynamic> json) => VehicleMake(
    code: json["Code"] == null ? null : json["Code"],
    description: json["Description"] == null ? null : json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code == null ? null : code,
    "Description": description == null ? null : description,
  };
}
