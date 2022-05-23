// To parse this JSON data, do
//
//     final policyDetails = policyDetailsFromJson(jsonString);

import 'dart:convert';

PolicyDetails policyDetailsFromJson(String str) =>
    PolicyDetails.fromJson(json.decode(str));

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
    this.policyFees,
    this.planName,
    this.actualPolicyName,
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
    this.vehicleMakeName,
    this.vehicleModel,
    this.vehicleModelName,
    this.vehicleYear,
    this.calculatedExcess,
    this.windscreenExcess,
    this.underageExcess,
    this.driverExperienceExcess,
    this.unknownDamageExcess,
    this.rsmdExcess,
    this.statusCaption,
    this.additionalExcess,
    this.previousPolicyDetails,
    this.isMortgage,
    this.planCovers,
    this.eligibleUpgrades,
    this.optionalCovers,
  });

  String quotationNumber;
  String policyNumber;
  String policyInceptionDate;
  String policyExpiryDate;
  String renewalFlag;
  String policyStatus;
  String netPremium;
  String totalPremium;
  String productCode;
  String productName;
  String policyFees;
  String planName;
  String actualPolicyName;
  String agencyRepairOption;
  String carReplace;
  String carReplaceDays;
  String policySumInsured;
  String registrationNo;
  String partyCode;
  String cprNo;
  List<Document> documents;
  String chassisNumber;
  String repairCondition;
  String sumInsured;
  String vehicleMake;
  String vehicleMakeName;
  String vehicleModel;
  String vehicleModelName;
  String vehicleYear;
  String calculatedExcess;
  String windscreenExcess;
  String underageExcess;
  String driverExperienceExcess;
  String unknownDamageExcess;
  dynamic rsmdExcess;
  String statusCaption;
  String additionalExcess;
  List<PreviousPolicyDetail> previousPolicyDetails;
  bool isMortgage;
  List<EligibleUpgrade> planCovers;
  List<EligibleUpgrade> eligibleUpgrades;
  List<dynamic> optionalCovers;

  factory PolicyDetails.fromJson(Map<String, dynamic> json) => PolicyDetails(
        additionalExcess: json["AdditionalExcess"],
        quotationNumber: json["quotationNumber"],
        policyNumber: json["policyNumber"],
        policyInceptionDate: json["policyInceptionDate"],
        policyExpiryDate: json["policyExpiryDate"],
        renewalFlag: json["renewalFlag"],
        policyStatus: json["policyStatus"],
        netPremium: json["netPremium"],
        totalPremium: json["totalPremium"],
        productCode: json["productCode"],
        productName: json["productName"],
        policyFees: json["PolicyFees"],
        planName: json["PlanName"],
        actualPolicyName: json["ActualPolicyName"],
        agencyRepairOption: json["AgencyRepairOption"],
        carReplace: json["CarReplace"],
        carReplaceDays: json["CarReplaceDays"],
        policySumInsured: json["PolicySumInsured"],
        registrationNo: json["RegistrationNo"],
        partyCode: json["PartyCode"],
        cprNo: json["CPRNo"],
        documents: List<Document>.from(
            json["Documents"].map((x) => Document.fromJson(x))),
        chassisNumber: json["ChassisNumber"],
        repairCondition: json["RepairCondition"],
        sumInsured: json["SumInsured"],
        vehicleMake: json["VehicleMake"],
        vehicleMakeName: json["VehicleMakeName"],
        vehicleModel: json["VehicleModel"],
        vehicleModelName: json["VehicleModelName"],
        vehicleYear: json["VehicleYear"],
        calculatedExcess: json["CalculatedExcess"],
        windscreenExcess: json["WindscreenExcess"],
        underageExcess: json["UnderageExcess"],
        driverExperienceExcess: json["DriverExperienceExcess"],
        unknownDamageExcess: json["UnknownDamageExcess"],
        rsmdExcess: json["RSMDExcess"],
        statusCaption: json["statusCaption"],
        previousPolicyDetails: List<PreviousPolicyDetail>.from(
            json["previousPolicyDetails"]
                .map((x) => PreviousPolicyDetail.fromJson(x))),
        isMortgage: json["IsMortgage"],
        planCovers: List<EligibleUpgrade>.from(
            json["PlanCovers"].map((x) => EligibleUpgrade.fromJson(x))),
        eligibleUpgrades: List<EligibleUpgrade>.from(
            json["EligibleUpgrades"].map((x) => EligibleUpgrade.fromJson(x))),
        optionalCovers:
            List<dynamic>.from(json["OptionalCovers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "AdditionalExcess": additionalExcess,
        "quotationNumber": quotationNumber,
        "policyNumber": policyNumber,
        "policyInceptionDate": policyInceptionDate,
        "policyExpiryDate": policyExpiryDate,
        "renewalFlag": renewalFlag,
        "policyStatus": policyStatus,
        "netPremium": netPremium,
        "totalPremium": totalPremium,
        "productCode": productCode,
        "productName": productName,
        "PolicyFees": policyFees,
        "PlanName": planName,
        "ActualPolicyName": actualPolicyName,
        "AgencyRepairOption": agencyRepairOption,
        "CarReplace": carReplace,
        "CarReplaceDays": carReplaceDays,
        "PolicySumInsured": policySumInsured,
        "RegistrationNo": registrationNo,
        "PartyCode": partyCode,
        "CPRNo": cprNo,
        "Documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "ChassisNumber": chassisNumber,
        "RepairCondition": repairCondition,
        "SumInsured": sumInsured,
        "VehicleMake": vehicleMake,
        "VehicleMakeName": vehicleMakeName,
        "VehicleModel": vehicleModel,
        "VehicleModelName": vehicleModelName,
        "VehicleYear": vehicleYear,
        "CalculatedExcess": calculatedExcess,
        "WindscreenExcess": windscreenExcess,
        "UnderageExcess": underageExcess,
        "DriverExperienceExcess": driverExperienceExcess,
        "UnknownDamageExcess": unknownDamageExcess,
        "RSMDExcess": rsmdExcess,
        "statusCaption": statusCaption,
        "previousPolicyDetails":
            List<dynamic>.from(previousPolicyDetails.map((x) => x.toJson())),
        "IsMortgage": isMortgage,
        "PlanCovers": List<dynamic>.from(planCovers.map((x) => x.toJson())),
        "EligibleUpgrades":
            List<dynamic>.from(eligibleUpgrades.map((x) => x.toJson())),
        "OptionalCovers": List<dynamic>.from(optionalCovers.map((x) => x)),
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

  dynamic documentStatus;
  dynamic documentVersion;
  String documentName;
  dynamic documentDescription;
  dynamic documentInStatus;
  dynamic documentCategory;
  dynamic documentCreatedOn;
  dynamic documentLockStatus;
  dynamic documentModifiedBy;
  String documentPath;
  dynamic documentId;
  dynamic documentModifiedOn;
  dynamic documentRefrenceId;
  String documentType;
  dynamic refrenceNumber;
  dynamic documentKeyword;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documentStatus: json["documentStatus"],
        documentVersion: json["documentVersion"],
        documentName: json["documentName"],
        documentDescription: json["documentDescription"],
        documentInStatus: json["documentInStatus"],
        documentCategory: json["documentCategory"],
        documentCreatedOn: json["documentCreatedOn"],
        documentLockStatus: json["documentLockStatus"],
        documentModifiedBy: json["documentModifiedBy"],
        documentPath: json["documentPath"],
        documentId: json["documentId"],
        documentModifiedOn: json["documentModifiedOn"],
        documentRefrenceId: json["documentRefrenceID"],
        documentType: json["documentType"],
        refrenceNumber: json["refrenceNumber"],
        documentKeyword: json["documentKeyword"],
      );

  Map<String, dynamic> toJson() => {
        "documentStatus": documentStatus,
        "documentVersion": documentVersion,
        "documentName": documentName,
        "documentDescription": documentDescription,
        "documentInStatus": documentInStatus,
        "documentCategory": documentCategory,
        "documentCreatedOn": documentCreatedOn,
        "documentLockStatus": documentLockStatus,
        "documentModifiedBy": documentModifiedBy,
        "documentPath": documentPath,
        "documentId": documentId,
        "documentModifiedOn": documentModifiedOn,
        "documentRefrenceID": documentRefrenceId,
        "documentType": documentType,
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
  });

  String label;
  String value;
  double price;
  String code;

  factory EligibleUpgrade.fromJson(Map<String, dynamic> json) =>
      EligibleUpgrade(
        label: json["Label"],
        value: json["Value"],
        price: json["Price"] == null ? null : json["Price"],
        code: json["Code"] == null ? null : json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Label": label,
        "Value": value,
        "Price": price == null ? null : price,
        "Code": code == null ? null : code,
      };
}

class PreviousPolicyDetail {
  PreviousPolicyDetail({
    this.policyNumber,
    this.productCode,
    this.productName,
    this.policyInceptionDate,
    this.policyExpiryDate,
    this.sumInsured,
    this.totalPremium,
    this.claimPresent,
    this.claimLossRatio,
    this.totalClaimCount,
  });

  dynamic policyNumber;
  dynamic productCode;
  dynamic productName;
  dynamic policyInceptionDate;
  dynamic policyExpiryDate;
  dynamic sumInsured;
  dynamic totalPremium;
  dynamic claimPresent;
  dynamic claimLossRatio;
  dynamic totalClaimCount;

  factory PreviousPolicyDetail.fromJson(Map<String, dynamic> json) =>
      PreviousPolicyDetail(
        policyNumber: json["policyNumber"],
        productCode: json["productCode"],
        productName: json["productName"],
        policyInceptionDate: json["policyInceptionDate"],
        policyExpiryDate: json["policyExpiryDate"],
        sumInsured: json["sumInsured"],
        totalPremium: json["totalPremium"],
        claimPresent: json["claimPresent"],
        claimLossRatio: json["claimLossRatio"],
        totalClaimCount: json["totalClaimCount"],
      );

  Map<String, dynamic> toJson() => {
        "policyNumber": policyNumber,
        "productCode": productCode,
        "productName": productName,
        "policyInceptionDate": policyInceptionDate,
        "policyExpiryDate": policyExpiryDate,
        "sumInsured": sumInsured,
        "totalPremium": totalPremium,
        "claimPresent": claimPresent,
        "claimLossRatio": claimLossRatio,
        "totalClaimCount": totalClaimCount,
      };
}
