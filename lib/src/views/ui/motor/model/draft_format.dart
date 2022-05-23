// To parse this JSON data, do
//
//     final motorInsuranceDraftFormat = motorInsuranceDraftFormatFromJson(jsonString);

import 'dart:convert';

import 'package:ebpv2/src/views/ui/motor/model/issue_quote.dart';

MotorInsuranceDraftFormat motorInsuranceDraftFormatFromJson(String str) =>
    MotorInsuranceDraftFormat.fromJson(json.decode(str));

String motorInsuranceDraftFormatToJson(MotorInsuranceDraftFormat data) =>
    json.encode(data.toJson());

class MotorInsuranceDraftFormat {
  MotorInsuranceDraftFormat({
    this.statusCode,
    this.message,
    this.result,
    this.optionalCovers,
  });

  final int statusCode;
  final String message;
  final Result result;
  final List<String> optionalCovers;

  factory MotorInsuranceDraftFormat.fromJson(Map<String, dynamic> json) =>
      MotorInsuranceDraftFormat(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        optionalCovers: json["optionalCovers"] == null
            ? null
            : List<String>.from(json["optionalCovers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "result": result == null ? null : result.toJson(),
        "optionalCovers": optionalCovers == null
            ? null
            : List<dynamic>.from(optionalCovers.map((x) => x)),
      };
}

class Result {
  Result(
      {this.year,
      this.brandNew,
      this.policyStartDate,
      this.sumInsured,
      this.motorMake,
      this.motorModel,
      this.noClaimDeclarationPeriod,
      this.quoteNumber,
      this.planName,
      this.carReplacement,
      this.plateNumber,
      this.bankName,
      this.chassisNumber,
      this.selectedPlanIndex,
      this.vehicleDetailsStatus,
      this.selectYourPlanStatus,
      this.paymentStatus,
      this.paymentType,
      this.ownership,
      this.isCashFlowVisible,
      this.isPlanSelected,
      this.isRecommendedVisible,
      this.isLoanFlowVisible,
      this.isCustomerFlowVisible,
      this.isBankFlowVisible,
      this.isQuotIssued,
      this.isDealerQuotionUploaded,
      this.isCprValid,
      this.eligibleOption,
      this.policyExpiryDate,
      this.quote,
      this.isPaymentSuccessful,
      this.isPolicyIssued,
      this.transactionNumber});

  final String year;
  final List<bool> brandNew;
  final String policyStartDate;
  final String sumInsured;
  final String motorMake;
  final String motorModel;
  final String noClaimDeclarationPeriod;
  final String quoteNumber;
  final String planName;
  final String carReplacement;
  final String plateNumber;
  final String bankName;
  final String policyExpiryDate;
  final String chassisNumber;
  final int selectedPlanIndex;
  final int vehicleDetailsStatus;
  final int selectYourPlanStatus;
  final int paymentStatus;
  final List<bool> paymentType;
  final List<bool> ownership;
  final bool isCashFlowVisible;
  final bool isPlanSelected;
  final bool isRecommendedVisible;
  final bool isLoanFlowVisible;
  final bool isCustomerFlowVisible;
  final bool isBankFlowVisible;
  final bool isQuotIssued;
  final bool isDealerQuotionUploaded;
  final bool isCprValid;
  final String eligibleOption;
  final IssueQuote quote;
  final bool isPaymentSuccessful;
  final bool isPolicyIssued;
  final int transactionNumber;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        isPaymentSuccessful: json["isPaymentSuccessful"] == null
            ? null
            : json["isPaymentSuccessful"],
        isPolicyIssued:
            json["isPolicyIssued"] == null ? null : json["isPolicyIssued"],
        transactionNumber: json["transactionNumber"] == null
            ? null
            : json["transactionNumber"],
        quote: json["quot"] == null ? null : IssueQuote.fromJson(json["quot"]),
        policyExpiryDate:
            json["PolicyExpiryDate"] == null ? null : json["PolicyExpiryDate"],
        year: json["Year"] == null ? null : json["Year"],
        brandNew: json["BrandNew"] == null
            ? null
            : List<bool>.from(json["BrandNew"].map((x) => x)),
        policyStartDate:
            json["PolicyStartDate"] == null ? null : json["PolicyStartDate"],
        sumInsured: json["SumInsured"] == null ? null : json["SumInsured"],
        motorMake: json["MotorMake"] == null ? null : json["MotorMake"],
        motorModel: json["MotorModel"] == null ? null : json["MotorModel"],
        noClaimDeclarationPeriod: json["NoClaimDeclarationPeriod"] == null
            ? null
            : json["NoClaimDeclarationPeriod"],
        quoteNumber: json["QuoteNumber"] == null ? null : json["QuoteNumber"],
        planName: json["PlanName"] == null ? null : json["PlanName"],
        carReplacement:
            json["CarReplacement"] == null ? null : json["CarReplacement"],
        plateNumber: json["PlateNumber"] == null ? null : json["PlateNumber"],
        bankName: json["BankName"] == null ? null : json["BankName"],
        chassisNumber:
            json["ChassisNumber"] == null ? null : json["ChassisNumber"],
        selectedPlanIndex: json["selectedPlanIndex"] == null
            ? null
            : json["selectedPlanIndex"],
        vehicleDetailsStatus: json["vehicleDetailsStatus"] == null
            ? null
            : json["vehicleDetailsStatus"],
        selectYourPlanStatus: json["selectYourPlanStatus"] == null
            ? null
            : json["selectYourPlanStatus"],
        paymentStatus:
            json["paymentStatus"] == null ? null : json["paymentStatus"],
        paymentType: json["paymentType"] == null
            ? null
            : List<bool>.from(json["paymentType"].map((x) => x)),
        ownership: json["ownership"] == null
            ? null
            : List<bool>.from(json["ownership"].map((x) => x)),
        isCashFlowVisible: json["isCashFlowVisible"] == null
            ? null
            : json["isCashFlowVisible"],
        isPlanSelected:
            json["isPlanSelected"] == null ? null : json["isPlanSelected"],
        isRecommendedVisible: json["isRecommendedVisible"] == null
            ? null
            : json["isRecommendedVisible"],
        isLoanFlowVisible: json["isLoanFlowVisible"] == null
            ? null
            : json["isLoanFlowVisible"],
        isCustomerFlowVisible: json["isCustomerFlowVisible"] == null
            ? null
            : json["isCustomerFlowVisible"],
        isBankFlowVisible: json["isBankFlowVisible"] == null
            ? null
            : json["isBankFlowVisible"],
        isQuotIssued:
            json["isQuotIssued"] == null ? null : json["isQuotIssued"],
        isDealerQuotionUploaded: json["isDealerQuotionUploaded"] == null
            ? null
            : json["isDealerQuotionUploaded"],
        isCprValid: json["isCprValid"] == null ? null : json["isCprValid"],
        eligibleOption:
            json["eligibleOption"] == null ? null : json["eligibleOption"],
      );

  Map<String, dynamic> toJson() => {


    "transactionNumber": transactionNumber == null ? null : transactionNumber,

    "isPolicyIssued": isPolicyIssued == null ? null : isPolicyIssued,
        "isPaymentSuccessful":
            isPaymentSuccessful == null ? null : isPaymentSuccessful,
        "quot": quote == null ? null : quote.toJson(),
        "PolicyExpiryDate": policyExpiryDate == null ? null : policyExpiryDate,
        "Year": year == null ? null : year,
        "BrandNew": brandNew == null
            ? null
            : List<dynamic>.from(brandNew.map((x) => x)),
        "PolicyStartDate": policyStartDate == null ? null : policyStartDate,
        "SumInsured": sumInsured == null ? null : sumInsured,
        "MotorMake": motorMake == null ? null : motorMake,
        "MotorModel": motorModel == null ? null : motorModel,
        "NoClaimDeclarationPeriod":
            noClaimDeclarationPeriod == null ? null : noClaimDeclarationPeriod,
        "QuoteNumber": quoteNumber == null ? null : quoteNumber,
        "PlanName": planName == null ? null : planName,
        "CarReplacement": carReplacement == null ? null : carReplacement,
        "PlateNumber": plateNumber == null ? null : plateNumber,
        "BankName": bankName == null ? null : bankName,
        "ChassisNumber": chassisNumber == null ? null : chassisNumber,
        "selectedPlanIndex":
            selectedPlanIndex == null ? null : selectedPlanIndex,
        "vehicleDetailsStatus":
            vehicleDetailsStatus == null ? null : vehicleDetailsStatus,
        "selectYourPlanStatus":
            selectYourPlanStatus == null ? null : selectYourPlanStatus,
        "paymentStatus": paymentStatus == null ? null : paymentStatus,
        "paymentType": paymentType == null
            ? null
            : List<dynamic>.from(paymentType.map((x) => x)),
        "ownership": ownership == null
            ? null
            : List<dynamic>.from(ownership.map((x) => x)),
        "isCashFlowVisible":
            isCashFlowVisible == null ? null : isCashFlowVisible,
        "isPlanSelected": isPlanSelected == null ? null : isPlanSelected,
        "isRecommendedVisible":
            isRecommendedVisible == null ? null : isRecommendedVisible,
        "isLoanFlowVisible":
            isLoanFlowVisible == null ? null : isLoanFlowVisible,
        "isCustomerFlowVisible":
            isCustomerFlowVisible == null ? null : isCustomerFlowVisible,
        "isBankFlowVisible":
            isBankFlowVisible == null ? null : isBankFlowVisible,
        "isQuotIssued": isQuotIssued == null ? null : isQuotIssued,
        "isDealerQuotionUploaded":
            isDealerQuotionUploaded == null ? null : isDealerQuotionUploaded,
        "isCprValid": isCprValid == null ? null : isCprValid,
        "eligibleOption": eligibleOption == null ? null : eligibleOption,
      };
}
/*class Quote {
  Quote({
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

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
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
}*/
