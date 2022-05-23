// To parse this JSON data, do
//
//     final plansModel = plansModelFromJson(jsonString);

import 'dart:convert';

PlansModel plansModelFromJson(String str) => PlansModel.fromJson(json.decode(str));

String plansModelToJson(PlansModel data) => json.encode(data.toJson());

class PlansModel {
  PlansModel({
    this.totalRowCount,
    this.policySearch,
    this.errorCode,
    this.errorDescription,
  });

  final int totalRowCount;
  final List<PolicySearch> policySearch;
  final int errorCode;
  final String errorDescription;

  factory PlansModel.fromJson(Map<String, dynamic> json) => PlansModel(
    totalRowCount: json["totalRowCount"] == null ? null : json["totalRowCount"],
    policySearch: json["policySearch"] == null ? null : List<PolicySearch>.from(json["policySearch"].map((x) => PolicySearch.fromJson(x))),
    errorCode: json["errorCode"] == null ? null : json["errorCode"],
    errorDescription: json["errorDescription"] == null ? null : json["errorDescription"],
  );

  Map<String, dynamic> toJson() => {
    "totalRowCount": totalRowCount == null ? null : totalRowCount,
    "policySearch": policySearch == null ? null : List<dynamic>.from(policySearch.map((x) => x.toJson())),
    "errorCode": errorCode == null ? null : errorCode,
    "errorDescription": errorDescription == null ? null : errorDescription,
  };
}

class PolicySearch {
  PolicySearch({
    this.productCode,
    this.proposalNumber,
    this.policyNumber,
    this.policyStatusCode,
    this.policyIDate,
    this.policyBranchCode,
    this.policyExpiryDate,
    this.policyTerm,
    this.policySi,
    this.policyPartyCode,
    this.policyPartyName,
    this.registrationNumber,
    this.vehicleMake,
    this.modelGroup,
    this.productName,
    this.policyDurationUnit,
    this.policyStatus,
    this.renewedQuoteNo,
    this.oldPolicyNumber,
    this.statusCaption,
    this.index,
    this.isExpanded,
    this.VehicleYear
  });


  final int index;
  final bool isExpanded;
  final String productCode;
  final String proposalNumber;
  final String policyNumber;
  final String policyStatusCode;
  final String policyIDate;
  final String policyBranchCode;
  final String policyExpiryDate;
  final String policyTerm;
  final String policySi;
  final String policyPartyCode;
  final String policyPartyName;
  final String registrationNumber;
  final String vehicleMake;
  final String modelGroup;
  final String productName;
  final String policyDurationUnit;
  final String policyStatus;
  final String renewedQuoteNo;
  final String oldPolicyNumber;
  final String statusCaption;
  final String VehicleYear;

  factory PolicySearch.fromJson(Map<String, dynamic> json) => PolicySearch(
    VehicleYear: json["VehicleYear"] == null ? null : json["VehicleYear"],
    productCode: json["productCode"] == null ? null : json["productCode"],
    proposalNumber: json["proposalNumber"] == null ? null : json["proposalNumber"],
    policyNumber: json["policyNumber"] == null ? null : json["policyNumber"],
    policyStatusCode: json["policyStatusCode"] == null ? null : json["policyStatusCode"],
    policyIDate: json["policyIDate"] == null ? null : json["policyIDate"],
    policyBranchCode: json["policyBranchCode"] == null ? null : json["policyBranchCode"],
    policyExpiryDate: json["policyExpiryDate"] == null ? null : json["policyExpiryDate"],
    policyTerm: json["policyTerm"] == null ? null : json["policyTerm"],
    policySi: json["policySI"] == null ? null : json["policySI"],
    policyPartyCode: json["policyPartyCode"] == null ? null : json["policyPartyCode"],
    policyPartyName: json["policyPartyName"] == null ? null : json["policyPartyName"],
    registrationNumber: json["registrationNumber"] == null ? null : json["registrationNumber"],
    vehicleMake: json["vehicleMake"] == null ? null : json["vehicleMake"],
    modelGroup: json["modelGroup"] == null ? null : json["modelGroup"],
    productName: json["productName"] == null ? null : json["productName"],
    policyDurationUnit: json["policyDurationUnit"] == null ? null : json["policyDurationUnit"],
    policyStatus: json["policyStatus"] == null ? null : json["policyStatus"],
    renewedQuoteNo: json["renewedQuoteNo"] == null ? null : json["renewedQuoteNo"],
    oldPolicyNumber: json["oldPolicyNumber"] == null ? null : json["oldPolicyNumber"],
    statusCaption: json["statusCaption"] == null ? null : json["statusCaption"],
  );

  Map<String, dynamic> toJson() => {
    "productCode": productCode == null ? null : productCode,
    "proposalNumber": proposalNumber == null ? null : proposalNumber,
    "policyNumber": policyNumber == null ? null : policyNumber,
    "policyStatusCode": policyStatusCode == null ? null : policyStatusCode,
    "policyIDate": policyIDate == null ? null : policyIDate,
    "policyBranchCode": policyBranchCode == null ? null : policyBranchCode,
    "policyExpiryDate": policyExpiryDate == null ? null : policyExpiryDate,
    "policyTerm": policyTerm == null ? null : policyTerm,
    "policySI": policySi == null ? null : policySi,
    "policyPartyCode": policyPartyCode == null ? null : policyPartyCode,
    "policyPartyName": policyPartyName == null ? null : policyPartyName,
    "registrationNumber": registrationNumber == null ? null : registrationNumber,
    "vehicleMake": vehicleMake == null ? null : vehicleMake,
    "modelGroup": modelGroup == null ? null : modelGroup,
    "productName": productName == null ? null : productName,
    "policyDurationUnit": policyDurationUnit == null ? null : policyDurationUnit,
    "policyStatus": policyStatus == null ? null : policyStatus,
    "renewedQuoteNo": renewedQuoteNo == null ? null : renewedQuoteNo,
    "oldPolicyNumber": oldPolicyNumber == null ? null : oldPolicyNumber,
    "statusCaption": statusCaption == null ? null : statusCaption,
  };
}
