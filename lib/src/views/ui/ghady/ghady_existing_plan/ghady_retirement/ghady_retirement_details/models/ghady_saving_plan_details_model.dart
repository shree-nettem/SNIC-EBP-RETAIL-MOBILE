import 'package:ebpv2/src/utilities/utils.dart';

class GhadySavingPlanDetailsModel {
  String nextPaymentDueDate = "";
  String startDate = "";
  String strategy = "";
  num goal;
  num contribution;
  num term;
  String termUnit;
  String currency;
  List<Activities> activities = const [];
  List<AllocationsDistribution> allocationsDistribution = const [];
  List<Summary> summary = const [];
  List<History> history = const [];
  int key;
  String policyNumber;
  String date;

  GhadySavingPlanDetailsModel(
      {this.nextPaymentDueDate,
      this.startDate,
      this.strategy,
      this.goal,
      this.contribution,
      this.term,
      this.termUnit,
      this.currency,
      this.activities,
      this.allocationsDistribution,
      this.summary,
      this.history,
      this.key,
      this.policyNumber,
      this.date});

  GhadySavingPlanDetailsModel.fromJson(Map<String, dynamic> json) {
    nextPaymentDueDate = json['NextPaymentDueDate'] != null
        ? Utils.getOnlyDate(json['NextPaymentDueDate'])
        : "";
    startDate = json['StartDate'] != null ? json['StartDate'] : "";
    strategy = json['Strategy'] ?? "";
    goal = json['Goal'] ?? 0;
    contribution = json['Contribution'] != null
        ? num.parse(json['Contribution'].toStringAsFixed(0))
        : 0;
    term = json['Term'] ?? 0;
    termUnit = json['TermUnit'] ?? "";
    currency = json['Currency'] ?? "";
    if (json['Activities'] != null) {
      activities = [];
      json['Activities'].forEach((v) {
        activities.add(new Activities.fromJson(v));
      });
    }
    if (json['AllocationsDistribution'] != null) {
      allocationsDistribution = [];
      json['AllocationsDistribution'].forEach((v) {
        allocationsDistribution.add(new AllocationsDistribution.fromJson(v));
      });
    }
    if (json['Summary'] != null) {
      summary = [];
      json['Summary'].forEach((v) {
        summary.add(new Summary.fromJson(v));
      });
    }
    if (json['History'] != null) {
      history = [];
      json['History'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
    key = json['Key'] ?? 0;
    policyNumber = json['PolicyNumber'] ?? "";
    date = json['Date'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NextPaymentDueDate'] = this.nextPaymentDueDate;
    data['StartDate'] = this.startDate;
    data['Strategy'] = this.strategy;
    data['Goal'] = this.goal;
    data['Contribution'] = this.contribution;
    data['Term'] = this.term;
    data['TermUnit'] = this.termUnit;
    data['Currency'] = this.currency;
    if (this.activities != null) {
      data['Activities'] = this.activities.map((v) => v.toJson()).toList();
    }
    if (this.allocationsDistribution != null) {
      data['AllocationsDistribution'] =
          this.allocationsDistribution.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['Summary'] = this.summary.map((v) => v.toJson()).toList();
    }
    if (this.history != null) {
      data['History'] = this.history.map((v) => v.toJson()).toList();
    }
    data['Key'] = this.key;
    data['PolicyNumber'] = this.policyNumber;
    data['Date'] = this.date;
    return data;
  }
}

class Activities {
  String code = "";
  String name = "";
  num amount = 0;
  num charge = 0;
  int key = 0;
  String policyNumber = "";
  String date = "";

  Activities(
      {this.code,
      this.name,
      this.amount,
      this.charge,
      this.key,
      this.policyNumber,
      this.date});

  Activities.fromJson(Map<String, dynamic> json) {
    code = json['Code'] ?? "";
    name = json['Name'] ?? "";
    amount = json['Amount'] != null
        ? num.parse(json['Amount'].toStringAsFixed(3))
        : null;
    charge = json['Charge'];
    key = json['Key'] ?? 0;
    policyNumber = json['PolicyNumber'] ?? "";
    date = json['Date'] != null ? Utils.getOnlyDate(json['Date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['Amount'] = this.amount;
    data['Charge'] = this.charge;
    data['Key'] = this.key;
    data['PolicyNumber'] = this.policyNumber;
    data['Date'] = this.date;
    return data;
  }
}

class AllocationsDistribution {
  String fundCode = "";
  String fundName = "";
  num percentage = 0;
  int key = 0;
  String policyNumber = "";
  String date = "";

  AllocationsDistribution(
      {this.fundCode,
      this.fundName,
      this.percentage,
      this.key,
      this.policyNumber,
      this.date});

  AllocationsDistribution.fromJson(Map<String, dynamic> json) {
    fundCode = json['FundCode'] ?? "";
    fundName = json['FundName'] ?? "";
    percentage = json['Percentage'] != null
        ? num.parse(json['Percentage'].toStringAsFixed(0))
        : null;
    key = json['Key'] ?? 0;
    policyNumber = json['PolicyNumber'] ?? "";
    date = json['Date'] != null
        ? Utils.formattedDateFromString(json['Date'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FundCode'] = this.fundCode;
    data['FundName'] = this.fundName;
    data['Percentage'] = this.percentage;
    data['Key'] = this.key;
    data['PolicyNumber'] = this.policyNumber;
    data['Date'] = this.date;
    return data;
  }
}

class Summary {
  String fundCode = "";
  num price = 0;
  String fundName = "";
  String currency = "";
  num units = 0;
  num amount = 0;

  Summary(
      {this.fundCode,
      this.price,
      this.fundName,
      this.currency,
      this.units,
      this.amount});

  Summary.fromJson(Map<String, dynamic> json) {
    fundCode = json['FundCode'] ?? "";
    price = json['Price'] != null
        ? num.parse(json['Price'].toStringAsFixed(3))
        : null;
    fundName = json['FundName'] ?? "";
    currency = json['Currency'] ?? "";
    units = json['Units'] != null
        ? num.parse(json['Units'].toStringAsFixed(3))
        : null;
    amount = json['Amount'] != null
        ? num.parse(json['Amount'].toStringAsFixed(3))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FundCode'] = this.fundCode;
    data['Price'] = this.price;
    data['FundName'] = this.fundName;
    data['Currency'] = this.currency;
    data['Units'] = this.units;
    data['Amount'] = this.amount;
    return data;
  }
}

class History {
  String nextPaymentDueDate = "";
  String startDate;
  String strategy;
  num goal;
  num contribution;
  num term;
  String termUnit;
  String currency;
  String activities;
  String allocationsDistribution;
  String summary;
  String history;
  int key;
  String policyNumber;
  String date;

  History(
      {this.nextPaymentDueDate,
      this.startDate,
      this.strategy,
      this.goal,
      this.contribution,
      this.term,
      this.termUnit,
      this.currency,
      this.activities,
      this.allocationsDistribution,
      this.summary,
      this.history,
      this.key,
      this.policyNumber,
      this.date});

  History.fromJson(Map<String, dynamic> json) {
    nextPaymentDueDate = json['NextPaymentDueDate'] ?? "";
    startDate = json['StartDate'] ?? "";
    strategy = json['Strategy'] ?? "";
    goal = json['Goal'] ?? 0;
    contribution = json['Contribution'] ?? 0;
    term = json['Term'] ?? 0;
    termUnit = json['TermUnit'] ?? "";
    currency = json['Currency'] ?? "";
    activities = json['Activities'] ?? "";
    allocationsDistribution = json['AllocationsDistribution'] ?? "";
    summary = json['Summary'] ?? "";
    history = json['History'] ?? "";
    key = json['Key'] ?? 0;
    policyNumber = json['PolicyNumber'] ?? "";
    date = json['Date'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NextPaymentDueDate'] = this.nextPaymentDueDate;
    data['StartDate'] = this.startDate;
    data['Strategy'] = this.strategy;
    data['Goal'] = this.goal;
    data['Contribution'] = this.contribution;
    data['Term'] = this.term;
    data['TermUnit'] = this.termUnit;
    data['Currency'] = this.currency;
    data['Activities'] = this.activities;
    data['AllocationsDistribution'] = this.allocationsDistribution;
    data['Summary'] = this.summary;
    data['History'] = this.history;
    data['Key'] = this.key;
    data['PolicyNumber'] = this.policyNumber;
    data['Date'] = this.date;
    return data;
  }
}
