// To parse this JSON data, do
//
//     final policeReportClaim = policeReportClaimFromJson(jsonString);

import 'dart:convert';

import 'package:ebpv2/src/views/ui/motor/model/windscreen_claim.dart';

PoliceReportClaim policeReportClaimFromJson(String str) => PoliceReportClaim.fromJson(json.decode(str));

String policeReportClaimToJson(PoliceReportClaim data) => json.encode(data.toJson());

class PoliceReportClaim {
  PoliceReportClaim({
    this.id,
    this.claimNumber,
    this.policyNumber,
    this.vehicleMakeModelYear,
    this.registrationNumber,
    this.dateOfLoss,
    this.claimStatus,
    this.accidentLocationCountry,
    this.accidentLocation,
    this.policeReportDate,
    this.policeReportNumber,
    this.responsibility,
    this.claimType,
    this.createdAt,
    this.driverType,
    this.driverName,
    this.driverDateOfBirth,
    this.licenseIssueDate,
    this.fixingCarLocation,
    this.surveyDate,
    this.otherPartyInvolved,
    this.thirdPartyName,
    this.thirdPartyVehicleMake,
    this.thirdPartyVehicleYear,
    this.thirdPartyPlateNumber,
    this.thirdPartyPolicyNumber,
    this.thirdPartyCprNumber,
    this.thirdPartyFirstName,
    this.thirdPartyMiddleName,
    this.thirdPartyLastName,
    this.thirdPartyDateOfBirth,
    this.thirdPartyMobileNumber,
    this.thirdPartyRegistrationNumber,
    this.thirdPartyAddress,
    this.thirdPartyContactNumber,
    this.claimAttachments,
    this.statusCaption
  });

  final int id;
  final dynamic claimNumber;
  final String policyNumber;
  final String vehicleMakeModelYear;
  final String registrationNumber;
  final DateTime dateOfLoss;
  final String claimStatus;
  final dynamic accidentLocationCountry;
  final dynamic accidentLocation;
  final dynamic policeReportDate;
  final dynamic policeReportNumber;
  final String responsibility;
  final String claimType;
  final DateTime createdAt;
  final dynamic driverType;
  final dynamic driverName;
  final dynamic driverDateOfBirth;
  final dynamic licenseIssueDate;
  final String fixingCarLocation;
  final DateTime surveyDate;
  final bool otherPartyInvolved;
  final dynamic thirdPartyName;
  final dynamic thirdPartyVehicleMake;
  final dynamic thirdPartyVehicleYear;
  final dynamic thirdPartyPlateNumber;
  final dynamic thirdPartyPolicyNumber;
  final dynamic thirdPartyCprNumber;
  final dynamic thirdPartyFirstName;
  final dynamic thirdPartyMiddleName;
  final dynamic thirdPartyLastName;
  final dynamic thirdPartyDateOfBirth;
  final dynamic thirdPartyMobileNumber;
  final dynamic thirdPartyRegistrationNumber;
  final dynamic thirdPartyAddress;
  final dynamic thirdPartyContactNumber;
  final List<ClaimAttachment> claimAttachments;
  dynamic  statusCaption;

  factory PoliceReportClaim.fromJson(Map<String, dynamic> json) => PoliceReportClaim(

    id: json["ID"] == null ? null : json["ID"],
    claimNumber: json["ClaimNumber"],
    policyNumber: json["PolicyNumber"] == null ? null : json["PolicyNumber"],
    vehicleMakeModelYear: json["VehicleMakeModelYear"] == null ? null : json["VehicleMakeModelYear"],
    registrationNumber: json["RegistrationNumber"] == null ? null : json["RegistrationNumber"],
    dateOfLoss: json["DateOfLoss"] == null ? null : DateTime.parse(json["DateOfLoss"]),
    claimStatus: json["ClaimStatus"] == null ? null : json["ClaimStatus"],
    accidentLocationCountry: json["AccidentLocationCountry"],
    accidentLocation: json["AccidentLocation"],
    policeReportDate: json["PoliceReportDate"],
    policeReportNumber: json["PoliceReportNumber"],
    responsibility: json["Responsibility"] == null ? null : json["Responsibility"],
    claimType: json["ClaimType"] == null ? null : json["ClaimType"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    driverType: json["DriverType"],
    driverName: json["DriverName"],
    driverDateOfBirth: json["DriverDateOfBirth"],
    licenseIssueDate: json["LicenseIssueDate"],
    fixingCarLocation: json["FixingCarLocation"] == null ? null : json["FixingCarLocation"],
    surveyDate: json["SurveyDate"] == null ? null : DateTime.parse(json["SurveyDate"]),
    otherPartyInvolved: json["OtherPartyInvolved"] == null ? null : json["OtherPartyInvolved"],
    thirdPartyName: json["ThirdPartyName"],
    thirdPartyVehicleMake: json["ThirdPartyVehicleMake"],
    thirdPartyVehicleYear: json["ThirdPartyVehicleYear"],
    thirdPartyPlateNumber: json["ThirdPartyPlateNumber"],
    thirdPartyPolicyNumber: json["ThirdPartyPolicyNumber"],
    thirdPartyCprNumber: json["ThirdPartyCprNumber"],
    thirdPartyFirstName: json["ThirdPartyFirstName"],
    thirdPartyMiddleName: json["ThirdPartyMiddleName"],
    thirdPartyLastName: json["ThirdPartyLastName"],
    thirdPartyDateOfBirth: json["ThirdPartyDateOfBirth"],
    thirdPartyMobileNumber: json["ThirdPartyMobileNumber"],
    thirdPartyRegistrationNumber: json["ThirdPartyRegistrationNumber"],
    thirdPartyAddress: json["ThirdPartyAddress"],
    thirdPartyContactNumber: json["ThirdPartyContactNumber"],
    claimAttachments: json["ClaimAttachments"] == null ? null : List<ClaimAttachment>.from(json["ClaimAttachments"].map((x) => ClaimAttachment.fromJson(x))),
    statusCaption: json["StatusCaption"],

  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "ClaimNumber": claimNumber,
    "PolicyNumber": policyNumber == null ? null : policyNumber,
    "VehicleMakeModelYear": vehicleMakeModelYear == null ? null : vehicleMakeModelYear,
    "RegistrationNumber": registrationNumber == null ? null : registrationNumber,
    "DateOfLoss": dateOfLoss == null ? null : dateOfLoss.toIso8601String(),
    "ClaimStatus": claimStatus == null ? null : claimStatus,
    "AccidentLocationCountry": accidentLocationCountry,
    "AccidentLocation": accidentLocation,
    "PoliceReportDate": policeReportDate,
    "PoliceReportNumber": policeReportNumber,
    "Responsibility": responsibility == null ? null : responsibility,
    "ClaimType": claimType == null ? null : claimType,
    "CreatedAt": createdAt == null ? null : createdAt.toIso8601String(),
    "DriverType": driverType,
    "DriverName": driverName,
    "DriverDateOfBirth": driverDateOfBirth,
    "LicenseIssueDate": licenseIssueDate,
    "FixingCarLocation": fixingCarLocation == null ? null : fixingCarLocation,
    "SurveyDate": surveyDate == null ? null : surveyDate.toIso8601String(),
    "OtherPartyInvolved": otherPartyInvolved == null ? null : otherPartyInvolved,
    "ThirdPartyName": thirdPartyName,
    "ThirdPartyVehicleMake": thirdPartyVehicleMake,
    "ThirdPartyVehicleYear": thirdPartyVehicleYear,
    "ThirdPartyPlateNumber": thirdPartyPlateNumber,
    "ThirdPartyPolicyNumber": thirdPartyPolicyNumber,
    "ThirdPartyCprNumber": thirdPartyCprNumber,
    "ThirdPartyFirstName": thirdPartyFirstName,
    "ThirdPartyMiddleName": thirdPartyMiddleName,
    "ThirdPartyLastName": thirdPartyLastName,
    "ThirdPartyDateOfBirth": thirdPartyDateOfBirth,
    "ThirdPartyMobileNumber": thirdPartyMobileNumber,
    "ThirdPartyRegistrationNumber": thirdPartyRegistrationNumber,
    "ThirdPartyAddress": thirdPartyAddress,
    "ThirdPartyContactNumber": thirdPartyContactNumber,
    "ClaimAttachments": claimAttachments == null ? null : List<dynamic>.from(claimAttachments.map((x) => x.toJson())),
  };
}
