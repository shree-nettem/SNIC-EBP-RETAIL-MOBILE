// To parse this JSON data, do
//
//     final renewPlanDetails = renewPlanDetailsFromJson(jsonString);

import 'dart:convert';

RenewPlanDetails renewPlanDetailsFromJson(String str) => RenewPlanDetails.fromJson(json.decode(str));

String renewPlanDetailsToJson(RenewPlanDetails data) => json.encode(data.toJson());

class RenewPlanDetails {
  RenewPlanDetails({
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
    this.planName,
    this.agencyRepairOption,
    this.carReplace,
    this.carReplaceDays,
    this.policySumInsured,
    this.registrationNo,
    this.partyCode,
    this.cprNo,
    this.planCovers,
    this.documents,
    this.chassisNumber,
    this.repairCondition,
    this.sumInsured,
    this.vehicleMake,
    this.vehicleModel,
    this.vehicleYear,
    this.statusCaption,
    this.actualPolicyName,
    this.isMortgage,
    this.eligibleUpgrades,
    this.optionalCovers,
    this.isPlanCoversExpanded=false,
    this.isSupplementaryBenefitsExpanded=false
  });

  final String quotationNumber;
  final String policyNumber;
  final String policyInceptionDate;
  final String policyExpiryDate;
  final String renewalFlag;
  final String policyStatus;
  final String netPremium;
  final String totalPremium;
  final String productCode;
  final String productName;
  final String planName;
  final String agencyRepairOption;
  final String carReplace;
  final String carReplaceDays;
  final String policySumInsured;
  final String registrationNo;
  final String partyCode;
  final String cprNo;
  final List<EligibleUpgrade> planCovers;
   bool isPlanCoversExpanded;
   bool isSupplementaryBenefitsExpanded;
  final List<Document> documents;
  final String chassisNumber;
  final String repairCondition;
  final String sumInsured;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleYear;
  final String statusCaption;
  final String actualPolicyName;
  final dynamic isMortgage;
  final List<EligibleUpgrade> eligibleUpgrades;
  final List<EligibleUpgrade> optionalCovers;

  factory RenewPlanDetails.fromJson(Map<String, dynamic> json) => RenewPlanDetails(
    quotationNumber: json["quotationNumber"] == null ? null : json["quotationNumber"],
    policyNumber: json["policyNumber"] == null ? null : json["policyNumber"],
    policyInceptionDate: json["policyInceptionDate"] == null ? null : json["policyInceptionDate"],
    policyExpiryDate: json["policyExpiryDate"] == null ? null : json["policyExpiryDate"],
    renewalFlag: json["renewalFlag"] == null ? null : json["renewalFlag"],
    policyStatus: json["policyStatus"] == null ? null : json["policyStatus"],
    netPremium: json["netPremium"] == null ? null : json["netPremium"],
    totalPremium: json["totalPremium"] == null ? null : json["totalPremium"],
    productCode: json["productCode"] == null ? null : json["productCode"],
    productName: json["productName"] == null ? null : json["productName"],
    planName: json["PlanName"] == null ? null : json["PlanName"],
    agencyRepairOption: json["AgencyRepairOption"] == null ? null : json["AgencyRepairOption"],
    carReplace: json["CarReplace"] == null ? null : json["CarReplace"],
    carReplaceDays: json["CarReplaceDays"] == null ? null : json["CarReplaceDays"],
    policySumInsured: json["PolicySumInsured"] == null ? null : json["PolicySumInsured"],
    registrationNo: json["RegistrationNo"] == null ? null : json["RegistrationNo"],
    partyCode: json["PartyCode"] == null ? null : json["PartyCode"],
    cprNo: json["CPRNo"] == null ? null : json["CPRNo"],
    planCovers: json["PlanCovers"] == null ? null : List<EligibleUpgrade>.from(json["PlanCovers"].map((x) => EligibleUpgrade.fromJson(x))),
    documents: json["Documents"] == null ? null : List<Document>.from(json["Documents"].map((x) => Document.fromJson(x))),
    chassisNumber: json["ChassisNumber"] == null ? null : json["ChassisNumber"],
    repairCondition: json["RepairCondition"] == null ? null : json["RepairCondition"],
    sumInsured: json["SumInsured"] == null ? null : json["SumInsured"],
    vehicleMake: json["VehicleMake"] == null ? null : json["VehicleMake"],
    vehicleModel: json["VehicleModel"] == null ? null : json["VehicleModel"],
    vehicleYear: json["VehicleYear"] == null ? null : json["VehicleYear"],
    statusCaption: json["statusCaption"] == null ? null : json["statusCaption"],
    actualPolicyName: json["ActualPolicyName"] == null ? null : json["ActualPolicyName"],
    isMortgage: json["IsMortgage"],
    eligibleUpgrades: json["EligibleUpgrades"] == null ? null : List<EligibleUpgrade>.from(json["EligibleUpgrades"].map((x) => EligibleUpgrade.fromJson(x))),
    optionalCovers: json["OptionalCovers"] == null ? null : List<EligibleUpgrade>.from(json["OptionalCovers"].map((x) => EligibleUpgrade.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quotationNumber": quotationNumber == null ? null : quotationNumber,
    "policyNumber": policyNumber == null ? null : policyNumber,
    "policyInceptionDate": policyInceptionDate == null ? null : policyInceptionDate,
    "policyExpiryDate": policyExpiryDate == null ? null : policyExpiryDate,
    "renewalFlag": renewalFlag == null ? null : renewalFlag,
    "policyStatus": policyStatus == null ? null : policyStatus,
    "netPremium": netPremium == null ? null : netPremium,
    "totalPremium": totalPremium == null ? null : totalPremium,
    "productCode": productCode == null ? null : productCode,
    "productName": productName == null ? null : productName,
    "PlanName": planName == null ? null : planName,
    "AgencyRepairOption": agencyRepairOption == null ? null : agencyRepairOption,
    "CarReplace": carReplace == null ? null : carReplace,
    "CarReplaceDays": carReplaceDays == null ? null : carReplaceDays,
    "PolicySumInsured": policySumInsured == null ? null : policySumInsured,
    "RegistrationNo": registrationNo == null ? null : registrationNo,
    "PartyCode": partyCode == null ? null : partyCode,
    "CPRNo": cprNo == null ? null : cprNo,
    "PlanCovers": planCovers == null ? null : List<dynamic>.from(planCovers.map((x) => x.toJson())),
    "Documents": documents == null ? null : List<dynamic>.from(documents.map((x) => x.toJson())),
    "ChassisNumber": chassisNumber == null ? null : chassisNumber,
    "RepairCondition": repairCondition == null ? null : repairCondition,
    "SumInsured": sumInsured == null ? null : sumInsured,
    "VehicleMake": vehicleMake == null ? null : vehicleMake,
    "VehicleModel": vehicleModel == null ? null : vehicleModel,
    "VehicleYear": vehicleYear == null ? null : vehicleYear,
    "statusCaption": statusCaption == null ? null : statusCaption,
    "ActualPolicyName": actualPolicyName == null ? null : actualPolicyName,
    "IsMortgage": isMortgage,
    "EligibleUpgrades": eligibleUpgrades == null ? null : List<dynamic>.from(eligibleUpgrades.map((x) => x.toJson())),
    "OptionalCovers": optionalCovers == null ? null : List<dynamic>.from(optionalCovers.map((x) => x.toJson())),
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

class EligibleUpgrade {
  EligibleUpgrade({
    this.label,
    this.value,
    this.price,
    this.code,
    this.isSelected=true
  });

  final String label;
  final String value;
  final String price;
  final String code;
  bool isSelected;

  factory EligibleUpgrade.fromJson(Map<String, dynamic> json) => EligibleUpgrade(
    label: json["Label"] == null ? null : json["Label"],
    value: json["Value"] == null ? null : json["Value"],
    price: json["Price"] == null ? null : json["Price"],
    code: json["Code"] == null ? null : json["Code"],
  );

  Map<String, dynamic> toJson() => {
    "Label": label == null ? null : label,
    "Value": value == null ? null : value,
    "Price": price == null ? null : price,
    "Code": code == null ? null : code,
  };
}
