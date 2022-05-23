// To parse this JSON data, do
//
//     final claimHistory = claimHistoryFromJson(jsonString);

import 'dart:convert';

List<ClaimHistory> claimHistoryFromJson(String str) => List<ClaimHistory>.from(json.decode(str).map((x) => ClaimHistory.fromJson(x)));

String claimHistoryToJson(List<ClaimHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClaimHistory {
  ClaimHistory({

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
    this.attachmentPoliceReport,
    this.attachmentIban,
    this.attachmentCprFront,
    this.attachmentCprBack,
    this.attachmentWindscreenPicture,
    this.attachmentCarPicture,
    this.attachmentOther1,
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
    this.status,
    this.statusCaption,
  });

  int id;
  int customerId;
  String customerName;
  int companyId;
  String companyName;
  int claimId;
  String claimNumber;
  String accidentType;
  dynamic accidentLocationCountry;
  dynamic accidentLocation;
  dynamic driverType;
  dynamic driverName;
  dynamic driverDateOfBirth;
  dynamic licenseIssueDate;
  dynamic fixingCarLocation;
  dynamic surveyDate;
  String policyNumber;
  String policyId;
  DateTime dateOfLoss;
  dynamic policeReportDate;
  String policeReportNumber;
  String lossDescription;
  String responsibility;
  dynamic intimationNumber;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic claimType;
  dynamic otherPartyInvolved;
  String attachmentOwnershipFront;
  dynamic attachmentOwnershipBack;
  dynamic attachmentDrivingLicenseFront;
  dynamic attachmentDrivingLicenseBack;
  dynamic attachmentPoliceReport;
  dynamic attachmentIban;
  dynamic attachmentCprFront;
  String attachmentCprBack;
  dynamic attachmentWindscreenPicture;
  dynamic attachmentCarPicture;
  dynamic attachmentOther1;
  dynamic thirdPartyName;
  dynamic thirdPartyVehicleMake;
  dynamic thirdPartyVehicleYear;
  dynamic thirdPartyPlateNumber;
  dynamic thirdPartyPolicyNumber;
  dynamic thirdPartyCprNumber;
  dynamic thirdPartyFirstName;
  dynamic thirdPartyMiddleName;
  dynamic thirdPartyLastName;
  dynamic thirdPartyDateOfBirth;
  dynamic thirdPartyMobileNumber;
  dynamic thirdPartyRegistrationNumber;
  dynamic thirdPartyAddress;
  dynamic thirdPartyContactNumber;
  dynamic status;
  dynamic statusCaption;

  factory ClaimHistory.fromJson(Map<String, dynamic> json) => ClaimHistory(

    id: json["ID"],
    customerId: json["CustomerId"],
    customerName: json["CustomerName"],
    companyId: json["CompanyId"],
    companyName: json["CompanyName"],
    claimId: json["ClaimId"],
    claimNumber: json["ClaimNumber"],
    accidentType: json["AccidentType"],
    accidentLocationCountry: json["AccidentLocationCountry"],
    accidentLocation: json["AccidentLocation"],
    driverType: json["DriverType"],
    driverName: json["DriverName"],
    driverDateOfBirth: json["DriverDateOfBirth"],
    licenseIssueDate: json["LicenseIssueDate"],
    fixingCarLocation: json["FixingCarLocation"],
    surveyDate: json["SurveyDate"],
    policyNumber: json["PolicyNumber"],
    policyId: json["PolicyId"],
    dateOfLoss: DateTime.parse(json["DateOfLoss"]),
    policeReportDate: json["PoliceReportDate"],
    policeReportNumber: json["PoliceReportNumber"],
    lossDescription: json["LossDescription"],
    responsibility: json["Responsibility"],
    intimationNumber: json["IntimationNumber"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
    claimType: json["ClaimType"],
    otherPartyInvolved: json["OtherPartyInvolved"],
    attachmentOwnershipFront: json["AttachmentOwnershipFront"],
    attachmentOwnershipBack: json["AttachmentOwnershipBack"],
    attachmentDrivingLicenseFront: json["AttachmentDrivingLicenseFront"],
    attachmentDrivingLicenseBack: json["AttachmentDrivingLicenseBack"],
    attachmentPoliceReport: json["AttachmentPoliceReport"],
    attachmentIban: json["AttachmentIban"],
    attachmentCprFront: json["AttachmentCprFront"],
    attachmentCprBack: json["AttachmentCprBack"],
    attachmentWindscreenPicture: json["AttachmentWindscreenPicture"],
    attachmentCarPicture: json["AttachmentCarPicture"],
    attachmentOther1: json["AttachmentOther1"],
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
    status: json["Status"],
    statusCaption:json["StatusCaption"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CustomerId": customerId,
    "CustomerName": customerName,
    "CompanyId": companyId,
    "CompanyName": companyName,
    "ClaimId": claimId,
    "ClaimNumber": claimNumber,
    "AccidentType": accidentType,
    "AccidentLocationCountry": accidentLocationCountry,
    "AccidentLocation": accidentLocation,
    "DriverType": driverType,
    "DriverName": driverName,
    "DriverDateOfBirth": driverDateOfBirth,
    "LicenseIssueDate": licenseIssueDate,
    "FixingCarLocation": fixingCarLocation,
    "SurveyDate": surveyDate,
    "PolicyNumber": policyNumber,
    "PolicyId": policyId,
    "DateOfLoss": dateOfLoss.toIso8601String(),
    "PoliceReportDate": policeReportDate,
    "PoliceReportNumber": policeReportNumber,
    "LossDescription": lossDescription,
    "Responsibility": responsibility,
    "IntimationNumber": intimationNumber,
    "CreatedAt": createdAt.toIso8601String(),
    "UpdatedAt": updatedAt.toIso8601String(),
    "ClaimType": claimType,
    "OtherPartyInvolved": otherPartyInvolved,
    "AttachmentOwnershipFront": attachmentOwnershipFront,
    "AttachmentOwnershipBack": attachmentOwnershipBack,
    "AttachmentDrivingLicenseFront": attachmentDrivingLicenseFront,
    "AttachmentDrivingLicenseBack": attachmentDrivingLicenseBack,
    "AttachmentPoliceReport": attachmentPoliceReport,
    "AttachmentIban": attachmentIban,
    "AttachmentCprFront": attachmentCprFront,
    "AttachmentCprBack": attachmentCprBack,
    "AttachmentWindscreenPicture": attachmentWindscreenPicture,
    "AttachmentCarPicture": attachmentCarPicture,
    "AttachmentOther1": attachmentOther1,
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
    "Status": status,
  };
}
