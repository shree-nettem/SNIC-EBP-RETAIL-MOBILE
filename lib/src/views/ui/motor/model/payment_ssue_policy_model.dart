// To parse this JSON data, do
//
//     final paymentAndIssuePolicyModel = paymentAndIssuePolicyModelFromJson(jsonString);

import 'dart:convert';

PaymentAndIssuePolicyModel paymentAndIssuePolicyModelFromJson(String str) => PaymentAndIssuePolicyModel.fromJson(json.decode(str));

String paymentAndIssuePolicyModelToJson(PaymentAndIssuePolicyModel data) => json.encode(data.toJson());

class PaymentAndIssuePolicyModel {
  PaymentAndIssuePolicyModel({
    this.receiptNumber,
    this.strNetPremium,
    this.strPolicyQuoteNumber,
    this.strPolicyStatusCode,
    this.expiryDate,
    this.expiryTime,
    this.documentDetails,
    this.strRetCode,
  });

  final String receiptNumber;
  final String strNetPremium;
  final String strPolicyQuoteNumber;
  final String strPolicyStatusCode;
  final String expiryDate;
  final String expiryTime;
  final List<DocumentDetail> documentDetails;
  final String strRetCode;

  factory PaymentAndIssuePolicyModel.fromJson(Map<String, dynamic> json) => PaymentAndIssuePolicyModel(
    receiptNumber: json["receiptNumber"] == null ? null : json["receiptNumber"],
    strNetPremium: json["strNetPremium"] == null ? null : json["strNetPremium"],
    strPolicyQuoteNumber: json["strPolicyQuoteNumber"] == null ? null : json["strPolicyQuoteNumber"],
    strPolicyStatusCode: json["strPolicyStatusCode"] == null ? null : json["strPolicyStatusCode"],
    expiryDate: json["ExpiryDate"] == null ? null : json["ExpiryDate"],
    expiryTime: json["ExpiryTime"] == null ? null : json["ExpiryTime"],
    documentDetails: json["DocumentDetails"] == null ? null : List<DocumentDetail>.from(json["DocumentDetails"].map((x) => DocumentDetail.fromJson(x))),
    strRetCode: json["strRetCode"] == null ? null : json["strRetCode"],
  );

  Map<String, dynamic> toJson() => {
    "receiptNumber": receiptNumber == null ? null : receiptNumber,
    "strNetPremium": strNetPremium == null ? null : strNetPremium,
    "strPolicyQuoteNumber": strPolicyQuoteNumber == null ? null : strPolicyQuoteNumber,
    "strPolicyStatusCode": strPolicyStatusCode == null ? null : strPolicyStatusCode,
    "ExpiryDate": expiryDate == null ? null : expiryDate,
    "ExpiryTime": expiryTime == null ? null : expiryTime,
    "DocumentDetails": documentDetails == null ? null : List<dynamic>.from(documentDetails.map((x) => x.toJson())),
    "strRetCode": strRetCode == null ? null : strRetCode,
  };
}

class DocumentDetail {
  DocumentDetail({
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

  final String documentStatus;
  final String documentVersion;
  final String documentName;
  final String documentDescription;
  final String documentInStatus;
  final String documentCategory;
  final String documentCreatedOn;
  final String documentLockStatus;
  final String documentModifiedBy;
  final String documentPath;
  final String documentId;
  final String documentModifiedOn;
  final String documentRefrenceId;
  final String documentType;
  final String refrenceNumber;
  final String documentKeyword;

  factory DocumentDetail.fromJson(Map<String, dynamic> json) => DocumentDetail(
    documentStatus: json["documentStatus"] == null ? null : json["documentStatus"],
    documentVersion: json["documentVersion"] == null ? null : json["documentVersion"],
    documentName: json["documentName"] == null ? null : json["documentName"],
    documentDescription: json["documentDescription"] == null ? null : json["documentDescription"],
    documentInStatus: json["documentInStatus"] == null ? null : json["documentInStatus"],
    documentCategory: json["documentCategory"] == null ? null : json["documentCategory"],
    documentCreatedOn: json["documentCreatedOn"] == null ? null : json["documentCreatedOn"],
    documentLockStatus: json["documentLockStatus"] == null ? null : json["documentLockStatus"],
    documentModifiedBy: json["documentModifiedBy"] == null ? null : json["documentModifiedBy"],
    documentPath: json["documentPath"] == null ? null : json["documentPath"],
    documentId: json["documentId"] == null ? null : json["documentId"],
    documentModifiedOn: json["documentModifiedOn"] == null ? null : json["documentModifiedOn"],
    documentRefrenceId: json["documentRefrenceID"] == null ? null : json["documentRefrenceID"],
    documentType: json["documentType"] == null ? null : json["documentType"],
    refrenceNumber: json["refrenceNumber"] == null ? null : json["refrenceNumber"],
    documentKeyword: json["documentKeyword"] == null ? null : json["documentKeyword"],
  );

  Map<String, dynamic> toJson() => {
    "documentStatus": documentStatus == null ? null : documentStatus,
    "documentVersion": documentVersion == null ? null : documentVersion,
    "documentName": documentName == null ? null : documentName,
    "documentDescription": documentDescription == null ? null : documentDescription,
    "documentInStatus": documentInStatus == null ? null : documentInStatus,
    "documentCategory": documentCategory == null ? null : documentCategory,
    "documentCreatedOn": documentCreatedOn == null ? null : documentCreatedOn,
    "documentLockStatus": documentLockStatus == null ? null : documentLockStatus,
    "documentModifiedBy": documentModifiedBy == null ? null : documentModifiedBy,
    "documentPath": documentPath == null ? null : documentPath,
    "documentId": documentId == null ? null : documentId,
    "documentModifiedOn": documentModifiedOn == null ? null : documentModifiedOn,
    "documentRefrenceID": documentRefrenceId == null ? null : documentRefrenceId,
    "documentType": documentType == null ? null : documentType,
    "refrenceNumber": refrenceNumber == null ? null : refrenceNumber,
    "documentKeyword": documentKeyword == null ? null : documentKeyword,
  };
}
