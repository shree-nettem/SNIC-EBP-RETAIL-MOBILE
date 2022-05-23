import 'package:intl/intl.dart';

class MotorEcardModel {
  MotorEcardModel({
    this.totalRowCount,
    this.policySearch,
    this.errorCode,
    this.errorDescription,
  });

  int totalRowCount;
  List<EcardPolicyData> policySearch;
  int errorCode;
  String errorDescription;

  factory MotorEcardModel.fromJson(Map<String, dynamic> json) =>
      MotorEcardModel(
        totalRowCount:
            json["totalRowCount"] == null ? null : json["totalRowCount"],
        policySearch: json["policySearch"] == null
            ? null
            : List<EcardPolicyData>.from(
                json["policySearch"].map((x) => EcardPolicyData.fromJson(x))),
        errorCode: json["errorCode"] == null ? null : json["errorCode"],
        errorDescription:
            json["errorDescription"] == null ? null : json["errorDescription"],
      );

  Map<String, dynamic> toJson() => {
        "totalRowCount": totalRowCount == null ? null : totalRowCount,
        "policySearch": policySearch == null
            ? null
            : List<dynamic>.from(policySearch.map((x) => x.toJson())),
        "errorCode": errorCode == null ? null : errorCode,
        "errorDescription": errorDescription == null ? null : errorDescription,
      };
}

class EcardPolicyData {
  EcardPolicyData({
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
  });

  String productCode;
  String proposalNumber;
  String policyNumber;
  String policyStatusCode;
  DateTime policyIDate;
  String policyBranchCode;
  DateTime policyExpiryDate;
  String policyTerm;
  String policySi;
  String policyPartyCode;
  String policyPartyName;
  String registrationNumber;
  String vehicleMake;
  String modelGroup;
  String productName;
  String policyDurationUnit;
  String policyStatus;
  String renewedQuoteNo;
  String oldPolicyNumber;
  String statusCaption;

  factory EcardPolicyData.fromJson(Map<String, dynamic> json) =>
      EcardPolicyData(
        productCode: json["productCode"] == null ? null : json["productCode"],
        proposalNumber:
            json["proposalNumber"] == null ? null : json["proposalNumber"],
        policyNumber:
            json["policyNumber"] == null ? null : json["policyNumber"],
        policyStatusCode:
            json["policyStatusCode"] == null ? null : json["policyStatusCode"],
        policyIDate: json["policyIDate"] == null
            ? null
            : DateFormat("dd/MM/yyyy").parse(json["policyIDate"]),
        policyBranchCode:
            json["policyBranchCode"] == null ? null : json["policyBranchCode"],
        policyExpiryDate: json["policyExpiryDate"] == null
            ? null
            : DateFormat("dd/MM/yyyy").parse(json["policyExpiryDate"]),
        policyTerm: json["policyTerm"] == null ? null : json["policyTerm"],
        policySi: json["policySI"] == null ? null : json["policySI"],
        policyPartyCode:
            json["policyPartyCode"] == null ? null : json["policyPartyCode"],
        policyPartyName:
            json["policyPartyName"] == null ? null : json["policyPartyName"],
        registrationNumber: json["registrationNumber"] == null
            ? null
            : json["registrationNumber"],
        vehicleMake: json["vehicleMake"] == null ? null : json["vehicleMake"],
        modelGroup: json["modelGroup"] == null ? null : json["modelGroup"],
        productName: json["productName"] == null ? null : json["productName"],
        policyDurationUnit: json["policyDurationUnit"] == null
            ? null
            : json["policyDurationUnit"],
        policyStatus:
            json["policyStatus"] == null ? null : json["policyStatus"],
        renewedQuoteNo:
            json["renewedQuoteNo"] == null ? null : json["renewedQuoteNo"],
        oldPolicyNumber:
            json["oldPolicyNumber"] == null ? null : json["oldPolicyNumber"],
        statusCaption:
            json["statusCaption"] == null ? null : json["statusCaption"],
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
        "registrationNumber":
            registrationNumber == null ? null : registrationNumber,
        "vehicleMake": vehicleMake == null ? null : vehicleMake,
        "modelGroup": modelGroup == null ? null : modelGroup,
        "productName": productName == null ? null : productName,
        "policyDurationUnit":
            policyDurationUnit == null ? null : policyDurationUnit,
        "policyStatus": policyStatus == null ? null : policyStatus,
        "renewedQuoteNo": renewedQuoteNo == null ? null : renewedQuoteNo,
        "oldPolicyNumber": oldPolicyNumber == null ? null : oldPolicyNumber,
        "statusCaption": statusCaption == null ? null : statusCaption,
      };
}
