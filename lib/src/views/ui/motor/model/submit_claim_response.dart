// To parse this JSON data, do
//
//     final minorMotorClaimResponse = minorMotorClaimResponseFromJson(jsonString);

import 'dart:convert';

SubmitClaimResponse minorMotorClaimResponseFromJson(String str) => SubmitClaimResponse.fromJson(json.decode(str));

String minorMotorClaimResponseToJson(SubmitClaimResponse data) => json.encode(data.toJson());

class SubmitClaimResponse {
  SubmitClaimResponse({
    this.id,
    this.customerId,
    this.customerName,
    this.companyId,
    this.companyName,
    this.claimId,
    this.claimNumber,
    this.accidentType,
    this.accidentLocationCountry,
    this.accidentLocation,
    this.driverType,
    this.driverName,
    this.driverDateOfBirth,
    this.licenseIssueDate,
    this.fixingCarLocation,
    this.surveyDate,
    this.policyNumber,
    this.policyId,
    this.dateOfLoss,
    this.policeReportDate,
    this.policeReportNumber,
    this.lossDescription,
    this.responsibility,
    this.intimationNumber,
    this.createdAt,
    this.updatedAt,
    this.claimType,
    this.otherPartyInvolved,
    this.attachmentOwnershipFront,
    this.attachmentOwnershipBack,
    this.attachmentDrivingLicenseFront,
    this.attachmentDrivingLicenseBack,
  });

  final int id;
  final int customerId;
  final dynamic customerName;
  final int companyId;
  final dynamic companyName;
  final dynamic claimId;
  final dynamic claimNumber;
  final String accidentType;
  final String accidentLocationCountry;
  final String accidentLocation;
  final String driverType;
  final String driverName;
  final DateTime driverDateOfBirth;
  final DateTime licenseIssueDate;
  final String fixingCarLocation;
  final DateTime surveyDate;
  final String policyNumber;
  final dynamic policyId;
  final DateTime dateOfLoss;
  final dynamic policeReportDate;
  final String policeReportNumber;
  final String lossDescription;
  final String responsibility;
  final dynamic intimationNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String claimType;
  final bool otherPartyInvolved;
  final dynamic attachmentOwnershipFront;
  final dynamic attachmentOwnershipBack;
  final dynamic attachmentDrivingLicenseFront;
  final dynamic attachmentDrivingLicenseBack;

  factory SubmitClaimResponse.fromJson(Map<String, dynamic> json) => SubmitClaimResponse(
    id: json["ID"] == null ? null : json["ID"],
    customerId: json["CustomerId"] == null ? null : json["CustomerId"],
    customerName: json["CustomerName"],
    companyId: json["CompanyId"] == null ? null : json["CompanyId"],
    companyName: json["CompanyName"],
    claimId: json["ClaimId"],
    claimNumber: json["ClaimNumber"],
    accidentType: json["AccidentType"] == null ? null : json["AccidentType"],
    accidentLocationCountry: json["AccidentLocationCountry"] == null ? null : json["AccidentLocationCountry"],
    accidentLocation: json["AccidentLocation"] == null ? null : json["AccidentLocation"],
    driverType: json["DriverType"] == null ? null : json["DriverType"],
    driverName: json["DriverName"] == null ? null : json["DriverName"],
    driverDateOfBirth: json["DriverDateOfBirth"] == null ? null : DateTime.parse(json["DriverDateOfBirth"]),
    licenseIssueDate: json["LicenseIssueDate"] == null ? null : DateTime.parse(json["LicenseIssueDate"]),
    fixingCarLocation: json["FixingCarLocation"] == null ? null : json["FixingCarLocation"],
    surveyDate: json["SurveyDate"] == null ? null : DateTime.parse(json["SurveyDate"]),
    policyNumber: json["PolicyNumber"] == null ? null : json["PolicyNumber"],
    policyId: json["PolicyId"],
    dateOfLoss: json["DateOfLoss"] == null ? null : DateTime.parse(json["DateOfLoss"]),
    policeReportDate: json["PoliceReportDate"],
    policeReportNumber: json["PoliceReportNumber"] == null ? null : json["PoliceReportNumber"],
    lossDescription: json["LossDescription"] == null ? null : json["LossDescription"],
    responsibility: json["Responsibility"] == null ? null : json["Responsibility"],
    intimationNumber: json["IntimationNumber"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    claimType: json["ClaimType"] == null ? null : json["ClaimType"],
    otherPartyInvolved: json["OtherPartyInvolved"] == null ? null : json["OtherPartyInvolved"],
    attachmentOwnershipFront: json["AttachmentOwnershipFront"],
    attachmentOwnershipBack: json["AttachmentOwnershipBack"],
    attachmentDrivingLicenseFront: json["AttachmentDrivingLicenseFront"],
    attachmentDrivingLicenseBack: json["AttachmentDrivingLicenseBack"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "CustomerId": customerId == null ? null : customerId,
    "CustomerName": customerName,
    "CompanyId": companyId == null ? null : companyId,
    "CompanyName": companyName,
    "ClaimId": claimId,
    "ClaimNumber": claimNumber,
    "AccidentType": accidentType == null ? null : accidentType,
    "AccidentLocationCountry": accidentLocationCountry == null ? null : accidentLocationCountry,
    "AccidentLocation": accidentLocation == null ? null : accidentLocation,
    "DriverType": driverType == null ? null : driverType,
    "DriverName": driverName == null ? null : driverName,
    "DriverDateOfBirth": driverDateOfBirth == null ? null : driverDateOfBirth.toIso8601String(),
    "LicenseIssueDate": licenseIssueDate == null ? null : licenseIssueDate.toIso8601String(),
    "FixingCarLocation": fixingCarLocation == null ? null : fixingCarLocation,
    "SurveyDate": surveyDate == null ? null : surveyDate.toIso8601String(),
    "PolicyNumber": policyNumber == null ? null : policyNumber,
    "PolicyId": policyId,
    "DateOfLoss": dateOfLoss == null ? null : dateOfLoss.toIso8601String(),
    "PoliceReportDate": policeReportDate,
    "PoliceReportNumber": policeReportNumber == null ? null : policeReportNumber,
    "LossDescription": lossDescription == null ? null : lossDescription,
    "Responsibility": responsibility == null ? null : responsibility,
    "IntimationNumber": intimationNumber,
    "CreatedAt": createdAt == null ? null : createdAt.toIso8601String(),
    "UpdatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "ClaimType": claimType == null ? null : claimType,
    "OtherPartyInvolved": otherPartyInvolved == null ? null : otherPartyInvolved,
    "AttachmentOwnershipFront": attachmentOwnershipFront,
    "AttachmentOwnershipBack": attachmentOwnershipBack,
    "AttachmentDrivingLicenseFront": attachmentDrivingLicenseFront,
    "AttachmentDrivingLicenseBack": attachmentDrivingLicenseBack,
  };
}
