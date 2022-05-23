// To parse this JSON data, do
//
//     final minorClaim = minorClaimFromJson(jsonString);

import 'dart:convert';

import 'package:ebpv2/src/views/ui/motor/model/windscreen_claim.dart';

MinorClaim minorClaimFromJson(String str) => MinorClaim.fromJson(json.decode(str));

String minorClaimToJson(MinorClaim data) => json.encode(data.toJson());

class MinorClaim {
  MinorClaim({
    this.id,
    this.claimNumber,
    this.policyNumber,
    this.vehicleMakeModelYear,
    this.registrationNumber,
    this.dateOfLoss,
    this.intimationNumber,
    this.claimType,
    this.createdAt,
    this.claimStatus,
    this.claimAttachments,
    this.statusCaption
  });

  final int id;
  final dynamic claimNumber;
  final String policyNumber;
  final String vehicleMakeModelYear;
  final String registrationNumber;
  final DateTime dateOfLoss;
  final dynamic intimationNumber;
  final String claimType;
  final DateTime createdAt;
  final String claimStatus;
  final List<ClaimAttachment> claimAttachments;
  dynamic statusCaption;

  factory MinorClaim.fromJson(Map<String, dynamic> json) => MinorClaim(
    id: json["ID"] == null ? null : json["ID"],
    claimNumber: json["ClaimNumber"],
    policyNumber: json["PolicyNumber"] == null ? null : json["PolicyNumber"],
    vehicleMakeModelYear: json["VehicleMakeModelYear"] == null ? null : json["VehicleMakeModelYear"],
    registrationNumber: json["RegistrationNumber"] == null ? null : json["RegistrationNumber"],
    dateOfLoss: json["DateOfLoss"] == null ? null : DateTime.parse(json["DateOfLoss"]),
    intimationNumber: json["IntimationNumber"],
    claimType: json["ClaimType"] == null ? null : json["ClaimType"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    claimStatus: json["ClaimStatus"] == null ? null : json["ClaimStatus"],
    claimAttachments: json["ClaimAttachments"] == null ? null : List<ClaimAttachment>.from(json["ClaimAttachments"].map((x) => ClaimAttachment.fromJson(x))),
    statusCaption: json["StatusCaption"] == null ? null : json["StatusCaption"],

  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "ClaimNumber": claimNumber,
    "PolicyNumber": policyNumber == null ? null : policyNumber,
    "VehicleMakeModelYear": vehicleMakeModelYear == null ? null : vehicleMakeModelYear,
    "RegistrationNumber": registrationNumber == null ? null : registrationNumber,
    "DateOfLoss": dateOfLoss == null ? null : dateOfLoss.toIso8601String(),
    "IntimationNumber": intimationNumber,
    "ClaimType": claimType == null ? null : claimType,
    "CreatedAt": createdAt == null ? null : createdAt.toIso8601String(),
    "ClaimStatus": claimStatus == null ? null : claimStatus,
    "ClaimAttachments": claimAttachments == null ? null : List<dynamic>.from(claimAttachments.map((x) => x.toJson())),
  };
}

