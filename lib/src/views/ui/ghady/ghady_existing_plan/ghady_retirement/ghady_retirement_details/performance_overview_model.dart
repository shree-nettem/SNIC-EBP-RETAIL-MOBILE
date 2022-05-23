class PerformanceOverviewModel {
  String nextPaymentDueDate;
  String startDate;
  String strategy;
  int goal;
  int contribution;
  int term;
  String termUnit;
  String currency;
  List<Activities> activities;
  List<AllocationsDistribution> allocationsDistribution;
  List<Null> summary;
  List<History> history;
  int key;
  String policyNumber;
  String date;

  PerformanceOverviewModel(
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

  PerformanceOverviewModel.fromJson(Map<String, dynamic> json) {
    nextPaymentDueDate = json['NextPaymentDueDate'];
    startDate = json['StartDate'];
    strategy = json['Strategy'];
    goal = json['Goal'];
    contribution = json['Contribution'];
    term = json['Term'];
    termUnit = json['TermUnit'];
    currency = json['Currency'];
    if (json['Activities'] != null) {
      activities = <Activities>[];
      json['Activities'].forEach((v) {
        activities.add(new Activities.fromJson(v));
      });
    }
    if (json['AllocationsDistribution'] != null) {
      allocationsDistribution = <AllocationsDistribution>[];
      json['AllocationsDistribution'].forEach((v) {
        allocationsDistribution.add(new AllocationsDistribution.fromJson(v));
      });
    }
    // if (json['Summary'] != null) {
    //   summary = <Null>[];
    //   json['Summary'].forEach((v) {
    //     summary.add(new Null.fromJson(v));
    //   });
    // }
    if (json['History'] != null) {
      history = <History>[];
      json['History'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
    key = json['Key'];
    policyNumber = json['PolicyNumber'];
    date = json['Date'];
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
    // if (this.summary != null) {
    //   data['Summary'] = this.summary.map((v) => v.toJson()).toList();
    // }
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
  String code;
  String name;
  double amount;
  double charge;
  int key;
  String policyNumber;
  String date;

  Activities(
      {this.code,
      this.name,
      this.amount,
      this.charge,
      this.key,
      this.policyNumber,
      this.date});

  Activities.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    name = json['Name'];
    amount = json['Amount'];
    charge = json['Charge'];
    key = json['Key'];
    policyNumber = json['PolicyNumber'];
    date = json['Date'];
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
  String fundCode;
  String fundName;
  int percentage;
  int key;
  String policyNumber;
  String date;

  AllocationsDistribution(
      {this.fundCode,
      this.fundName,
      this.percentage,
      this.key,
      this.policyNumber,
      this.date});

  AllocationsDistribution.fromJson(Map<String, dynamic> json) {
    fundCode = json['FundCode'];
    fundName = json['FundName'];
    percentage = json['Percentage'];
    key = json['Key'];
    policyNumber = json['PolicyNumber'];
    date = json['Date'];
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

class History {
  String nextPaymentDueDate;
  String startDate;
  String strategy;
  int goal;
  int contribution;
  int term;
  String termUnit;
  String currency;
  Null activities;
  Null allocationsDistribution;
  Null summary;
  Null history;
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
    nextPaymentDueDate = json['NextPaymentDueDate'];
    startDate = json['StartDate'];
    strategy = json['Strategy'];
    goal = json['Goal'];
    contribution = json['Contribution'];
    term = json['Term'];
    termUnit = json['TermUnit'];
    currency = json['Currency'];
    activities = json['Activities'];
    allocationsDistribution = json['AllocationsDistribution'];
    summary = json['Summary'];
    history = json['History'];
    key = json['Key'];
    policyNumber = json['PolicyNumber'];
    date = json['Date'];
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
