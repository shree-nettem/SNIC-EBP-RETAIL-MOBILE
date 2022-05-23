// To parse this JSON data, do
//
//     final calculatingPremium = calculatingPremiumFromJson(jsonString);

import 'dart:convert';

CalculatingPremium calculatingPremiumFromJson(String str) => CalculatingPremium.fromJson(json.decode(str));

String calculatingPremiumToJson(CalculatingPremium data) => json.encode(data.toJson());

class CalculatingPremium {
  CalculatingPremium({
    this.strNetPremium,
    this.strGrossPremium,
    this.strVatPremium,
    this.strBasicPremium,
    this.quotationNumber,
    this.policyNumber,
    this.planName,
    this.actualPolicyName,
    this.planCovers,
    this.eligibleUpgrades,
    this.optionalCovers,
    this.policyFees
  });

  final double strNetPremium;
  final double strGrossPremium;
  final String strVatPremium;
  final String strBasicPremium;
  final String quotationNumber;

  final String policyFees;
  final dynamic policyNumber;
  final String planName;
  final String actualPolicyName;
  final List<EligibleUpgrade> planCovers;
  final List<EligibleUpgrade> eligibleUpgrades;
  final List<EligibleUpgrade> optionalCovers;

  factory CalculatingPremium.fromJson(Map<String, dynamic> json) => CalculatingPremium(


    policyFees: json["PolicyFees"] == null ? null : json["PolicyFees"],
    strNetPremium: json["strNetPremium"] == null ? null : json["strNetPremium"].toDouble(),
    strGrossPremium: json["strGrossPremium"] == null ? null : json["strGrossPremium"],
    strVatPremium: json["strVatPremium"] == null ? null : json["strVatPremium"],
    strBasicPremium: json["strBasicPremium"] == null ? null : json["strBasicPremium"],
    quotationNumber: json["quotationNumber"] == null ? null : json["quotationNumber"],
    policyNumber: json["policyNumber"],
    planName: json["PlanName"] == null ? null : json["PlanName"],
    actualPolicyName: json["ActualPolicyName"] == null ? null : json["ActualPolicyName"],
    planCovers: json["PlanCovers"] == null ? null : List<EligibleUpgrade>.from(json["PlanCovers"].map((x) => EligibleUpgrade.fromJson(x))),
    eligibleUpgrades: json["EligibleUpgrades"] == null ? null : List<EligibleUpgrade>.from(json["EligibleUpgrades"].map((x) => EligibleUpgrade.fromJson(x))),
    optionalCovers: json["OptionalCovers"] == null ? null : List<EligibleUpgrade>.from(json["OptionalCovers"].map((x) => EligibleUpgrade.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "PolicyFees": policyFees == null ? null : policyFees,
    "strNetPremium": strNetPremium == null ? null : strNetPremium,
    "strGrossPremium": strGrossPremium == null ? null : strGrossPremium,
    "strVatPremium": strVatPremium == null ? null : strVatPremium,
    "strBasicPremium": strBasicPremium == null ? null : strBasicPremium,
    "quotationNumber": quotationNumber == null ? null : quotationNumber,
    "policyNumber": policyNumber,
    "PlanName": planName == null ? null : planName,
    "ActualPolicyName": actualPolicyName == null ? null : actualPolicyName,
    "PlanCovers": planCovers == null ? null : List<dynamic>.from(planCovers.map((x) => x.toJson())),
    "EligibleUpgrades": eligibleUpgrades == null ? null : List<dynamic>.from(eligibleUpgrades.map((x) => x.toJson())),
    "OptionalCovers": optionalCovers == null ? null : List<dynamic>.from(optionalCovers.map((x) => x.toJson())),
  };
}

class EligibleUpgrade {
  EligibleUpgrade({
    this.label,
    this.value,
    this.price,
    this.code,
    this.isSelected=false,
  });

  final String label;
  final String value;
  final double price;
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
