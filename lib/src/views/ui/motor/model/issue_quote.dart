// To parse this JSON data, do
//
//     final issueQuote = issueQuoteFromJson(jsonString);

import 'dart:convert';

IssueQuote issueQuoteFromJson(String str) => IssueQuote.fromJson(json.decode(str));

String issueQuoteToJson(IssueQuote data) => json.encode(data.toJson());

class IssueQuote {
  IssueQuote({
    this.proposalNumber,
    this.status,
    this.proposalSubStatus,
    this.proposalMerStatus,
    this.policyPremium,
    this.netPremiumBeforeDiscount,
    this.netPremiumAfterDiscount,
    this.discountedAmount,
    this.discountPercentage,
    this.gst,
    this.stampDuty,
    this.totalPremiumBeforeDiscount,
    this.totalPremiumAfterDiscount,
    this.workflowStatus,
    this.workflowMessage,
    this.errorCode,
    this.errorDescription,
    this.actualPolicyName,
    this.planName,
    this.vehicleMake,
    this.vehicleModel,
    this.registrationNumber,
    this.basicPremiumAmount,
    this.supplementaryBenefitsAmount,
    this.vatAmount,
  });

  final String proposalNumber;
  final String status;
  final String proposalSubStatus;
  final String proposalMerStatus;
  final double policyPremium;
  final double netPremiumBeforeDiscount;
  final double netPremiumAfterDiscount;
  final double discountedAmount;
  final double discountPercentage;
  final double gst;
  final double stampDuty;
  final double totalPremiumBeforeDiscount;
  final double totalPremiumAfterDiscount;
  final String workflowStatus;
  final String workflowMessage;
  final int errorCode;
  final dynamic errorDescription;
  final String actualPolicyName;
  final String planName;
  final String vehicleMake;
  final String vehicleModel;
  final String registrationNumber;
  final double basicPremiumAmount;
  final double supplementaryBenefitsAmount;
  final double vatAmount;


  factory IssueQuote.fromJson(Map<String, dynamic> json) => IssueQuote(
    proposalNumber: json["proposalNumber"] == null ? null : json["proposalNumber"],
    status: json["status"] == null ? null : json["status"],
    proposalSubStatus: json["proposalSubStatus"] == null ? null : json["proposalSubStatus"],
    proposalMerStatus: json["proposalMERStatus"] == null ? null : json["proposalMERStatus"],
    policyPremium: json["policyPremium"] == null ? null : json["policyPremium"],
    netPremiumBeforeDiscount: json["netPremiumBeforeDiscount"] == null ? null : json["netPremiumBeforeDiscount"],
    netPremiumAfterDiscount: json["netPremiumAfterDiscount"] == null ? null : json["netPremiumAfterDiscount"],
    discountedAmount: json["discountedAmount"] == null ? null : json["discountedAmount"],
    discountPercentage: json["discountPercentage"] == null ? null : json["discountPercentage"],
    gst: json["gst"] == null ? null : json["gst"],
    stampDuty: json["stampDuty"] == null ? null : json["stampDuty"],
    totalPremiumBeforeDiscount: json["totalPremiumBeforeDiscount"] == null ? null : json["totalPremiumBeforeDiscount"],
    totalPremiumAfterDiscount: json["totalPremiumAfterDiscount"] == null ? null : json["totalPremiumAfterDiscount"],
    workflowStatus: json["workflowStatus"] == null ? null : json["workflowStatus"],
    workflowMessage: json["workflowMessage"] == null ? null : json["workflowMessage"],
    errorCode: json["errorCode"] == null ? null : json["errorCode"],
    errorDescription: json["errorDescription"],
    actualPolicyName: json["ActualPolicyName"] == null ? null : json["ActualPolicyName"],
    planName: json["PlanName"] == null ? null : json["PlanName"],
    vehicleMake: json["VehicleMake"] == null ? null : json["VehicleMake"],
    vehicleModel: json["VehicleModel"] == null ? null : json["VehicleModel"],
    registrationNumber: json["RegistrationNumber"] == null ? null : json["RegistrationNumber"],
    basicPremiumAmount: json["BasicPremiumAmount"] == null ? null : json["BasicPremiumAmount"],
    supplementaryBenefitsAmount: json["SupplementaryBenefitsAmount"] == null ? null : json["SupplementaryBenefitsAmount"],
    vatAmount: json["VatAmount"] == null ? null : json["VatAmount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "proposalNumber": proposalNumber == null ? null : proposalNumber,
    "status": status == null ? null : status,
    "proposalSubStatus": proposalSubStatus == null ? null : proposalSubStatus,
    "proposalMERStatus": proposalMerStatus == null ? null : proposalMerStatus,
    "policyPremium": policyPremium == null ? null : policyPremium,
    "netPremiumBeforeDiscount": netPremiumBeforeDiscount == null ? null : netPremiumBeforeDiscount,
    "netPremiumAfterDiscount": netPremiumAfterDiscount == null ? null : netPremiumAfterDiscount,
    "discountedAmount": discountedAmount == null ? null : discountedAmount,
    "discountPercentage": discountPercentage == null ? null : discountPercentage,
    "gst": gst == null ? null : gst,
    "stampDuty": stampDuty == null ? null : stampDuty,
    "totalPremiumBeforeDiscount": totalPremiumBeforeDiscount == null ? null : totalPremiumBeforeDiscount,
    "totalPremiumAfterDiscount": totalPremiumAfterDiscount == null ? null : totalPremiumAfterDiscount,
    "workflowStatus": workflowStatus == null ? null : workflowStatus,
    "workflowMessage": workflowMessage == null ? null : workflowMessage,
    "errorCode": errorCode == null ? null : errorCode,
    "errorDescription": errorDescription,
    "ActualPolicyName": actualPolicyName == null ? null : actualPolicyName,
    "PlanName": planName == null ? null : planName,
    "VehicleMake": vehicleMake == null ? null : vehicleMake,
    "VehicleModel": vehicleModel == null ? null : vehicleModel,
    "RegistrationNumber": registrationNumber == null ? null : registrationNumber,
    "BasicPremiumAmount": basicPremiumAmount == null ? null : basicPremiumAmount,
    "SupplementaryBenefitsAmount": supplementaryBenefitsAmount == null ? null : supplementaryBenefitsAmount,
    "VatAmount": vatAmount == null ? null : vatAmount,
  };
}
