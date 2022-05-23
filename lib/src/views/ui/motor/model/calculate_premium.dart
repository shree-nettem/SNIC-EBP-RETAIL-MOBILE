/*
class CalculatePremium {
  List<Data> result;

  CalculatePremium({this.result});

  CalculatePremium.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Data>();
      json['result'].forEach((v) {
        result.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String planName;
  CalculatePremiumOutput calculatePremiumOutput;
  List<PlanCovers> planCovers;
  List<OptionalCovers> optionalCovers;
  List<EligibleUpgrades> eligibleUpgrades;

  Data(
      {this.planName,
        this.calculatePremiumOutput,
        this.planCovers,
        this.optionalCovers,
        this.eligibleUpgrades});

  Data.fromJson(Map<String, dynamic> json) {
    planName = json['PlanName'];
    calculatePremiumOutput = json['CalculatePremiumOutput'] != null
        ? new CalculatePremiumOutput.fromJson(json['CalculatePremiumOutput'])
        : null;
    if (json['PlanCovers'] != null) {
      planCovers = new List<PlanCovers>();
      json['PlanCovers'].forEach((v) {
        planCovers.add(new PlanCovers.fromJson(v));
      });
    }
    if (json['OptionalCovers'] != null) {
      optionalCovers = new List<OptionalCovers>();
      json['OptionalCovers'].forEach((v) {
        optionalCovers.add(new OptionalCovers.fromJson(v));
      });
    }
    if (json['EligibleUpgrades'] != null) {
      eligibleUpgrades = new List<EligibleUpgrades>();
      json['EligibleUpgrades'].forEach((v) {
        eligibleUpgrades.add(new EligibleUpgrades.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PlanName'] = this.planName;
    if (this.calculatePremiumOutput != null) {
      data['CalculatePremiumOutput'] = this.calculatePremiumOutput.toJson();
    }
    if (this.planCovers != null) {
      data['PlanCovers'] = this.planCovers.map((v) => v.toJson()).toList();
    }
    if (this.optionalCovers != null) {
      data['OptionalCovers'] =
          this.optionalCovers.map((v) => v.toJson()).toList();
    }
    if (this.eligibleUpgrades != null) {
      data['EligibleUpgrades'] =
          this.eligibleUpgrades.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EligibleUpgrades {
  String label;
  String value;
  String price;

  EligibleUpgrades({this.label, this.value, this.price});

  EligibleUpgrades.fromJson(Map<String, dynamic> json) {
    label = json['Label'];
    value = json['Value'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Label'] = this.label;
    data['Value'] = this.value;
    data['Price'] = this.price;
    return data;
  }
}


class CalculatePremiumOutput {
  String strGrossPremium;
  String strDiscountAmt;
  String strNetPremium;
  String strLoadingAmt;
  String strPolicyQuoteNumber;
  String strPolicyHolderCode;
  String strPolicyStatusCode;
  String strIncludedProducts;
  String strExcludedProducts;
  PolicyDetail policyDetail;
  String strRetCode;
  String strRetError;

  CalculatePremiumOutput(
      {this.strGrossPremium,
        this.strDiscountAmt,
        this.strNetPremium,
        this.strLoadingAmt,
        this.strPolicyQuoteNumber,
        this.strPolicyHolderCode,
        this.strPolicyStatusCode,
        this.strIncludedProducts,
        this.strExcludedProducts,
        this.policyDetail,
        this.strRetCode,
        this.strRetError});

  CalculatePremiumOutput.fromJson(Map<String, dynamic> json) {
    strGrossPremium = json['strGrossPremium'];
    strDiscountAmt = json['strDiscountAmt'];
    strNetPremium = json['strNetPremium'];
    strLoadingAmt = json['strLoadingAmt'];
    strPolicyQuoteNumber = json['strPolicyQuoteNumber'];
    strPolicyHolderCode = json['strPolicyHolderCode'];
    strPolicyStatusCode = json['strPolicyStatusCode'];
    strIncludedProducts = json['strIncludedProducts'];
    strExcludedProducts = json['strExcludedProducts'];
    policyDetail = json['policyDetail'] != null
        ? new PolicyDetail.fromJson(json['policyDetail'])
        : null;
    strRetCode = json['strRetCode'];
    strRetError = json['strRetError'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strGrossPremium'] = this.strGrossPremium;
    data['strDiscountAmt'] = this.strDiscountAmt;
    data['strNetPremium'] = this.strNetPremium;
    data['strLoadingAmt'] = this.strLoadingAmt;
    data['strPolicyQuoteNumber'] = this.strPolicyQuoteNumber;
    data['strPolicyHolderCode'] = this.strPolicyHolderCode;
    data['strPolicyStatusCode'] = this.strPolicyStatusCode;
    data['strIncludedProducts'] = this.strIncludedProducts;
    data['strExcludedProducts'] = this.strExcludedProducts;
    if (this.policyDetail != null) {
      data['policyDetail'] = this.policyDetail.toJson();
    }
    data['strRetCode'] = this.strRetCode;
    data['strRetError'] = this.strRetError;
    return data;
  }
}

class PolicyDetail {
  List<NameValues> nameValues;

  PolicyDetail({this.nameValues});

  PolicyDetail.fromJson(Map<String, dynamic> json) {
    if (json['NameValues'] != null) {
      nameValues = new List<NameValues>();
      json['NameValues'].forEach((v) {
        nameValues.add(new NameValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nameValues != null) {
      data['NameValues'] = this.nameValues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NameValues {
  String strName;
  String strValue;

  NameValues({this.strName, this.strValue});

  NameValues.fromJson(Map<String, dynamic> json) {
    strName = json['strName'];
    strValue = json['strValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strName'] = this.strName;
    data['strValue'] = this.strValue;
    return data;
  }
}

class PlanCovers {
  String label;
  String value;
  Null price;

  PlanCovers({this.label, this.value, this.price});

  PlanCovers.fromJson(Map<String, dynamic> json) {
    label = json['Label'];
    value = json['Value'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Label'] = this.label;
    data['Value'] = this.value;
    data['Price'] = this.price;
    return data;
  }
}

class OptionalCovers {
  String label;
  String value;
  String price;

  OptionalCovers({this.label, this.value, this.price});

  OptionalCovers.fromJson(Map<String, dynamic> json) {
    label = json['Label'];
    value = json['Value'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Label'] = this.label;
    data['Value'] = this.value;
    data['Price'] = this.price;
    return data;
  }
}*/
import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:rxdart/rxdart.dart';

CalculatePremium calculatePremiumFromJson(String str) =>
    CalculatePremium.fromJson(json.decode(str));

String calculatePremiumToJson(CalculatePremium data) =>
    json.encode(data.toJson());

class CalculatePremium {
  CalculatePremium({
    this.data,
  });

  List<Datum> data;

  factory CalculatePremium.fromJson(Map<String, dynamic> json) =>
      CalculatePremium(
        data: json["result"] == null
            ? null
            : List<Datum>.from(json["result"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {this.planName,
      this.businessName,
      this.hasCalculatePremium,
      this.calculatePremiumOutput,
      this.planCovers,
      this.optionalCovers,
      this.eligibleUpgrades,
      this.defaultUpgrade,
      this.recommended,
      this.startingFrom});

  final String planName;
  final String businessName;
  RxBool hasCalculatePremium;
  CalculatePremiumOutput calculatePremiumOutput;
  final List<EligibleUpgrade> planCovers;
  final List<EligibleUpgrade> optionalCovers;
  final List<EligibleUpgrade> eligibleUpgrades;
  final String defaultUpgrade;
  final bool recommended;
  final int startingFrom;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        planName: json["PlanName"] == null ? null : json["PlanName"],
        businessName:
            json["BusinessName"] == null ? null : json["BusinessName"],
        calculatePremiumOutput: json["CalculatePremiumOutput"] == null
            ? null
            : CalculatePremiumOutput.fromJson(json["CalculatePremiumOutput"]),
        hasCalculatePremium: json["CalculatePremiumOutput"] == null
            ? RxBool(false)
            : RxBool(true),
        planCovers: json["PlanCovers"] == null
            ? null
            : List<EligibleUpgrade>.from(
                json["PlanCovers"].map((x) => EligibleUpgrade.fromJson(x))),
        optionalCovers: json["OptionalCovers"] == null
            ? null
            : List<EligibleUpgrade>.from(
                json["OptionalCovers"].map((x) => EligibleUpgrade.fromJson(x))),
        eligibleUpgrades: json["EligibleUpgrades"] == null
            ? null
            : List<EligibleUpgrade>.from(json["EligibleUpgrades"]
                .map((x) => EligibleUpgrade.fromJson(x))),
        defaultUpgrade:
            json["DefaultUpgrade"] == null ? null : json["DefaultUpgrade"],
        recommended: json["Recommended"] == null ? null : json["Recommended"],
        startingFrom:
            json["StartingFrom"] == null ? null : json["StartingFrom"],
      );

  Map<String, dynamic> toJson() => {
        "PlanName": planName == null ? null : planName,
        "BusinessName": businessName == null ? null : businessName,
        "CalculatePremiumOutput": calculatePremiumOutput == null
            ? null
            : calculatePremiumOutput.toJson(),
        "PlanCovers": planCovers == null
            ? null
            : List<dynamic>.from(planCovers.map((x) => x.toJson())),
        "OptionalCovers": optionalCovers == null
            ? null
            : List<dynamic>.from(optionalCovers.map((x) => x.toJson())),
        "EligibleUpgrades": eligibleUpgrades == null
            ? null
            : List<dynamic>.from(eligibleUpgrades.map((x) => x.toJson())),
        "DefaultUpgrade": defaultUpgrade == null ? null : defaultUpgrade,
        "Recommended": recommended == null ? null : recommended,
        "StartingFrom": startingFrom == null ? null : startingFrom,
      };
}

class CalculatePremiumOutput {
  CalculatePremiumOutput({
    this.strGrossPremium,
    this.strDiscountAmt,
    this.strNetPremium,
    this.strBasicPremium,
    this.strVatPremium,
    this.strLoadingAmt,
    this.strPolicyQuoteNumber,
    this.strPolicyHolderCode,
    this.strPolicyStatusCode,
    this.strSupplementaryBenefit,
    this.strIncludedProducts,
    this.strExcludedProducts,
    this.policyDetail,
    this.strRetCode,
    this.strRetError,
  });

  final String strGrossPremium;
  final String strDiscountAmt;
  final String strNetPremium;
  final String strBasicPremium;
  final String strVatPremium;
  final String strLoadingAmt;
  final String strPolicyQuoteNumber;
  final String strPolicyHolderCode;
  final String strPolicyStatusCode;
  final String strSupplementaryBenefit;
  final String strIncludedProducts;
  final String strExcludedProducts;
  final PolicyDetail policyDetail;
  final String strRetCode;
  final String strRetError;

  factory CalculatePremiumOutput.fromJson(Map<String, dynamic> json) =>
      CalculatePremiumOutput(
        strGrossPremium:
            json["strGrossPremium"] == null ? null : json["strGrossPremium"],
        strDiscountAmt:
            json["strDiscountAmt"] == null ? null : json["strDiscountAmt"],
        strNetPremium:
            json["strNetPremium"] == null ? null : json["strNetPremium"],
        strBasicPremium:
            json["strBasicPremium"] == null ? null : json["strBasicPremium"],
        strVatPremium:
            json["strVatPremium"] == null ? null : json["strVatPremium"],
        strLoadingAmt:
            json["strLoadingAmt"] == null ? null : json["strLoadingAmt"],
        strPolicyQuoteNumber: json["strPolicyQuoteNumber"] == null
            ? null
            : json["strPolicyQuoteNumber"],
        strPolicyHolderCode: json["strPolicyHolderCode"] == null
            ? null
            : json["strPolicyHolderCode"],
        strSupplementaryBenefit: json["strSupplementaryBenefit"] == null
            ? null
            : json["strSupplementaryBenefit"],
        strPolicyStatusCode: json["strPolicyStatusCode"] == null
            ? null
            : json["strPolicyStatusCode"],
        strIncludedProducts: json["strIncludedProducts"] == null
            ? null
            : json["strIncludedProducts"],
        strExcludedProducts: json["strExcludedProducts"] == null
            ? null
            : json["strExcludedProducts"],
        policyDetail: json["policyDetail"] == null
            ? null
            : PolicyDetail.fromJson(json["policyDetail"]),
        strRetCode: json["strRetCode"] == null ? null : json["strRetCode"],
        strRetError: json["strRetError"] == null ? null : json["strRetError"],
      );

  Map<String, dynamic> toJson() => {
        "strGrossPremium": strGrossPremium == null ? null : strGrossPremium,
        "strDiscountAmt": strDiscountAmt == null ? null : strDiscountAmt,
        "strNetPremium": strNetPremium == null ? null : strNetPremium,
        "strBasicPremium": strBasicPremium == null ? null : strBasicPremium,
        "strVatPremium": strVatPremium == null ? null : strVatPremium,
        "strLoadingAmt": strLoadingAmt == null ? null : strLoadingAmt,
        "strPolicyQuoteNumber":
            strPolicyQuoteNumber == null ? null : strPolicyQuoteNumber,
        "strPolicyHolderCode":
            strPolicyHolderCode == null ? null : strPolicyHolderCode,
        "strPolicyStatusCode":
            strPolicyStatusCode == null ? null : strPolicyStatusCode,
        "strIncludedProducts":
            strIncludedProducts == null ? null : strIncludedProducts,
        "strSupplementaryBenefit":
            strSupplementaryBenefit == null ? null : strSupplementaryBenefit,
        "strExcludedProducts":
            strExcludedProducts == null ? null : strExcludedProducts,
        "policyDetail": policyDetail == null ? null : policyDetail.toJson(),
        "strRetCode": strRetCode == null ? null : strRetCode,
        "strRetError": strRetError == null ? null : strRetError,
      };
}

class PolicyDetail {
  PolicyDetail({
    this.nameValues,
  });

  final List<NameValue> nameValues;

  factory PolicyDetail.fromJson(Map<String, dynamic> json) => PolicyDetail(
        nameValues: json["NameValues"] == null
            ? null
            : List<NameValue>.from(
                json["NameValues"].map((x) => NameValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "NameValues": nameValues == null
            ? null
            : List<dynamic>.from(nameValues.map((x) => x.toJson())),
      };
}

class NameValue {
  NameValue({
    this.strName,
    this.strValue,
  });

  final String strName;
  final String strValue;

  factory NameValue.fromJson(Map<String, dynamic> json) => NameValue(
        strName: json["strName"] == null ? null : json["strName"],
        strValue: json["strValue"] == null ? null : json["strValue"],
      );

  Map<String, dynamic> toJson() => {
        "strName": strName == null ? null : strName,
        "strValue": strValue == null ? null : strValue,
      };
}

class EligibleUpgrade {
  EligibleUpgrade({this.label, this.value, this.price});

  final String label;
  final String value;
  final double price;
  RxBool isSelected = false.obs;

  factory EligibleUpgrade.fromJson(Map<String, dynamic> json) =>
      EligibleUpgrade(
        label: json["Label"] == null ? null : json["Label"],
        value: json["Value"] == null ? null : json["Value"],
        price: json["Price"] == null ? null : json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "Label": label == null ? null : label,
        "Value": value == null ? null : value,
        "Price": price == null ? null : price,
      };

  // set isSelected(bool value) {
  //   _isSelected.value = value;
  // }
}
