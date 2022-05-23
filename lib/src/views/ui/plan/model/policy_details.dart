// To parse this JSON data, do
//
//     final policyDetails = policyDetailsFromJson(jsonString);

import 'dart:convert';

PolicyDetails policyDetailsFromJson(String str) => PolicyDetails.fromJson(json.decode(str));

String policyDetailsToJson(PolicyDetails data) => json.encode(data.toJson());

class PolicyDetails {
  PolicyDetails({
    this.quotationNumber,
    this.policyNumber,
    this.policyInceptionDate,
    this.policyExpiryDate,
    this.renewalFlag,
    this.policyStatus,
    this.netPremium,
    this.totalPremium,
    this.productCode,
    this.productName,
    this.agencyRepairOption,
    this.carReplace,
    this.carReplaceDays,
    this.policySumInsured,
    this.registrationNo,
    this.partyCode,
    this.cprNo,
    this.documents,
    this.chassisNumber,
    this.repairCondition,
    this.sumInsured,
    this.vehicleMake,
    this.vehicleModel,
    this.vehicleYear,
    this.statusCaption,
    this.VehicleMakeName,
    this.VehicleModelName,
    this.VehicleYear

  });

  final String quotationNumber;
  final dynamic policyNumber;
  final String policyInceptionDate;
  final String policyExpiryDate;
  final String renewalFlag;
  final String policyStatus;
  final String netPremium;
  final String totalPremium;
  final String productCode;
  final String productName;
  final String agencyRepairOption;
  final String carReplace;
  final String carReplaceDays;
  final String policySumInsured;
  final dynamic registrationNo;
  final String partyCode;
  final String cprNo;
  final List<Document> documents;
  final dynamic chassisNumber;
  final String repairCondition;
  final String sumInsured;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleYear;
  final String statusCaption;
  final String VehicleMakeName;
  final String VehicleModelName;
  final String VehicleYear;

  factory PolicyDetails.fromJson(Map<String, dynamic> json) => PolicyDetails(
    VehicleYear: json["VehicleYear"] == null ? null : json["VehicleYear"],

    VehicleMakeName: json["VehicleMakeName"] == null ? null : json["VehicleMakeName"],
    VehicleModelName: json["VehicleModelName"] == null ? null : json["VehicleModelName"],

    quotationNumber: json["quotationNumber"] == null ? null : json["quotationNumber"],
    policyNumber: json["policyNumber"],
    policyInceptionDate: json["policyInceptionDate"] == null ? null : json["policyInceptionDate"],
    policyExpiryDate: json["policyExpiryDate"] == null ? null : json["policyExpiryDate"],
    renewalFlag: json["renewalFlag"] == null ? null : json["renewalFlag"],
    policyStatus: json["policyStatus"] == null ? null : json["policyStatus"],
    netPremium: json["netPremium"] == null ? null : json["netPremium"],
    totalPremium: json["totalPremium"] == null ? null : json["totalPremium"],
    productCode: json["productCode"] == null ? null : json["productCode"],
    productName: json["productName"] == null ? null : json["productName"],
    agencyRepairOption: json["AgencyRepairOption"] == null ? null : json["AgencyRepairOption"],
    carReplace: json["CarReplace"] == null ? null : json["CarReplace"],
    carReplaceDays: json["CarReplaceDays"] == null ? null : json["CarReplaceDays"],
    policySumInsured: json["PolicySumInsured"] == null ? null : json["PolicySumInsured"],
    registrationNo: json["RegistrationNo"],
    partyCode: json["PartyCode"] == null ? null : json["PartyCode"],
    cprNo: json["CPRNo"] == null ? null : json["CPRNo"],
    documents: json["Documents"] == null ? null : List<Document>.from(json["Documents"].map((x) => Document.fromJson(x))),
    chassisNumber: json["ChassisNumber"],
    repairCondition: json["RepairCondition"] == null ? null : json["RepairCondition"],
    sumInsured: json["SumInsured"] == null ? null : json["SumInsured"],
    vehicleMake: json["VehicleMake"] == null ? null : json["VehicleMake"],
    vehicleModel: json["VehicleModel"] == null ? null : json["VehicleModel"],
    vehicleYear: json["VehicleYear"] == null ? null : json["VehicleYear"],
    statusCaption: json["statusCaption"] == null ? null : json["statusCaption"],
  );

  Map<String, dynamic> toJson() => {
    "VehicleMakeName": VehicleMakeName == null ? null : VehicleMakeName,
    "VehicleModelName": VehicleModelName == null ? null : VehicleModelName,
    "quotationNumber": quotationNumber == null ? null : quotationNumber,
    "policyNumber": policyNumber,
    "policyInceptionDate": policyInceptionDate == null ? null : policyInceptionDate,
    "policyExpiryDate": policyExpiryDate == null ? null : policyExpiryDate,
    "renewalFlag": renewalFlag == null ? null : renewalFlag,
    "policyStatus": policyStatus == null ? null : policyStatus,
    "netPremium": netPremium == null ? null : netPremium,
    "totalPremium": totalPremium == null ? null : totalPremium,
    "productCode": productCode == null ? null : productCode,
    "productName": productName == null ? null : productName,
    "AgencyRepairOption": agencyRepairOption == null ? null : agencyRepairOption,
    "CarReplace": carReplace == null ? null : carReplace,
    "CarReplaceDays": carReplaceDays == null ? null : carReplaceDays,
    "PolicySumInsured": policySumInsured == null ? null : policySumInsured,
    "RegistrationNo": registrationNo,
    "PartyCode": partyCode == null ? null : partyCode,
    "CPRNo": cprNo == null ? null : cprNo,
    "Documents": documents == null ? null : List<dynamic>.from(documents.map((x) => x.toJson())),
    "ChassisNumber": chassisNumber,
    "RepairCondition": repairCondition == null ? null : repairCondition,
    "SumInsured": sumInsured == null ? null : sumInsured,
    "VehicleMake": vehicleMake == null ? null : vehicleMake,
    "VehicleModel": vehicleModel == null ? null : vehicleModel,
    "VehicleYear": vehicleYear == null ? null : vehicleYear,
    "statusCaption": statusCaption == null ? null : statusCaption,

  };
}

class Document {
  Document({
    this.documentStatus,
    this.documentVersion,
    this.documentName,
    this.documentDescription,
    this.documentInStatus,
    this.documentCategory,
    this.documentCreatedOn,
    this.documentLockStatus,
    this.documentModifiedBy,
    this.documentPath,
    this.documentId,
    this.documentModifiedOn,
    this.documentRefrenceId,
    this.documentType,
    this.refrenceNumber,
    this.documentKeyword,
  });

  final dynamic documentStatus;
  final dynamic documentVersion;
  final String documentName;
  final dynamic documentDescription;
  final dynamic documentInStatus;
  final dynamic documentCategory;
  final dynamic documentCreatedOn;
  final dynamic documentLockStatus;
  final dynamic documentModifiedBy;
  final String documentPath;
  final dynamic documentId;
  final dynamic documentModifiedOn;
  final dynamic documentRefrenceId;
  final String documentType;
  final dynamic refrenceNumber;
  final dynamic documentKeyword;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    documentStatus: json["documentStatus"],
    documentVersion: json["documentVersion"],
    documentName: json["documentName"] == null ? null : json["documentName"],
    documentDescription: json["documentDescription"],
    documentInStatus: json["documentInStatus"],
    documentCategory: json["documentCategory"],
    documentCreatedOn: json["documentCreatedOn"],
    documentLockStatus: json["documentLockStatus"],
    documentModifiedBy: json["documentModifiedBy"],
    documentPath: json["documentPath"] == null ? null : json["documentPath"],
    documentId: json["documentId"],
    documentModifiedOn: json["documentModifiedOn"],
    documentRefrenceId: json["documentRefrenceID"],
    documentType: json["documentType"] == null ? null : json["documentType"],
    refrenceNumber: json["refrenceNumber"],
    documentKeyword: json["documentKeyword"],
  );

  Map<String, dynamic> toJson() => {
    "documentStatus": documentStatus,
    "documentVersion": documentVersion,
    "documentName": documentName == null ? null : documentName,
    "documentDescription": documentDescription,
    "documentInStatus": documentInStatus,
    "documentCategory": documentCategory,
    "documentCreatedOn": documentCreatedOn,
    "documentLockStatus": documentLockStatus,
    "documentModifiedBy": documentModifiedBy,
    "documentPath": documentPath == null ? null : documentPath,
    "documentId": documentId,
    "documentModifiedOn": documentModifiedOn,
    "documentRefrenceID": documentRefrenceId,
    "documentType": documentType == null ? null : documentType,
    "refrenceNumber": refrenceNumber,
    "documentKeyword": documentKeyword,
  };
}
