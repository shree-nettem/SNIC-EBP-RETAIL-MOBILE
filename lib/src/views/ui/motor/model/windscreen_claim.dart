// To parse this JSON data, do
//
//     final windScreenClaim = windScreenClaimFromJson(jsonString);

import 'dart:convert';

WindScreenClaim windScreenClaimFromJson(String str) => WindScreenClaim.fromJson(json.decode(str));

String windScreenClaimToJson(WindScreenClaim data) => json.encode(data.toJson());

class WindScreenClaim {
  WindScreenClaim({
    this.id,
    this.claimNumber,
    this.policyNumber,
    this.vehicleMakeModelYear,
    this.registrationNumber,
    this.dateOfLoss,
    this.claimStatus,
    this.responsibility,
    this.claimType,
    this.createdAt,
    this.fixingCarLocation,
    this.surveyDate,
    this.lossDescription,
    this.claimAttachments,
    this.statusCaption
  });

  final int id;
  final String claimNumber;
  final String policyNumber;
  final String vehicleMakeModelYear;
  final String registrationNumber;
  final DateTime dateOfLoss;
  final String claimStatus;
  final String responsibility;
  final String claimType;
  final DateTime createdAt;
  final String fixingCarLocation;
  final DateTime surveyDate;
  final String lossDescription;
  final List<ClaimAttachment> claimAttachments;
  dynamic statusCaption;

  factory WindScreenClaim.fromJson(Map<String, dynamic> json) => WindScreenClaim(
    id: json["ID"] == null ? null : json["ID"],
    claimNumber: json["ClaimNumber"] == null ? null : json["ClaimNumber"],
    policyNumber: json["PolicyNumber"] == null ? null : json["PolicyNumber"],
    vehicleMakeModelYear: json["VehicleMakeModelYear"] == null ? null : json["VehicleMakeModelYear"],
    registrationNumber: json["RegistrationNumber"] == null ? null : json["RegistrationNumber"],
    dateOfLoss: json["DateOfLoss"] == null ? null : DateTime.parse(json["DateOfLoss"]),
    claimStatus: json["ClaimStatus"] == null ? null : json["ClaimStatus"],
    responsibility: json["Responsibility"] == null ? null : json["Responsibility"],
    claimType: json["ClaimType"] == null ? null : json["ClaimType"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    fixingCarLocation: json["FixingCarLocation"] == null ? null : json["FixingCarLocation"],
    surveyDate: json["SurveyDate"] == null ? null : DateTime.parse(json["SurveyDate"]),
    lossDescription: json["LossDescription"] == null ? null : json["LossDescription"],
    claimAttachments: json["ClaimAttachments"] == null ? null : List<ClaimAttachment>.from(json["ClaimAttachments"].map((x) => ClaimAttachment.fromJson(x))),
    statusCaption: json["StatusCaption"] == null ? null : json["StatusCaption"],

  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "ClaimNumber": claimNumber == null ? null : claimNumber,
    "PolicyNumber": policyNumber == null ? null : policyNumber,
    "VehicleMakeModelYear": vehicleMakeModelYear == null ? null : vehicleMakeModelYear,
    "RegistrationNumber": registrationNumber == null ? null : registrationNumber,
    "DateOfLoss": dateOfLoss == null ? null : dateOfLoss.toIso8601String(),
    "ClaimStatus": claimStatus == null ? null : claimStatus,
    "Responsibility": responsibility == null ? null : responsibility,
    "ClaimType": claimType == null ? null : claimType,
    "CreatedAt": createdAt == null ? null : createdAt.toIso8601String(),
    "FixingCarLocation": fixingCarLocation == null ? null : fixingCarLocation,
    "SurveyDate": surveyDate == null ? null : surveyDate.toIso8601String(),
    "LossDescription": lossDescription == null ? null : lossDescription,
    "ClaimAttachments": claimAttachments == null ? null : List<dynamic>.from(claimAttachments.map((x) => x.toJson())),
  };
}

class ClaimAttachment {
  ClaimAttachment({
    this.label,
    this.value,
  });

  final String label;
 final  String value;

  factory ClaimAttachment.fromJson(Map<String, dynamic> json) => ClaimAttachment(
    label: json["Label"] == null ? null : json["Label"],
    value: json["Value"] == null ? null : json["Value"],
  );



  Map<String, dynamic> toJson() => {
    "Label": label == null ? null : label,
    "Value": value == null ? null : value,
  };
}

