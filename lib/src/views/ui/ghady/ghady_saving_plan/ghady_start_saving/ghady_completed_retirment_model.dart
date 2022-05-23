import 'dart:convert';

CompletedRetirmentRequest completedRetirmentRequestFromJson(String str) =>
    CompletedRetirmentRequest.fromJson(json.decode(str));

String completedRetirmentRequestToJson(CompletedRetirmentRequest data) =>
    json.encode(data.toJson());

class CompletedRetirmentRequest {
  CompletedRetirmentRequest({
    this.inputs,
    this.status,
    this.id,
    this.requestId,
    this.productName,
    this.productCategory,
    this.productCode,
    this.documents,
  });

  Inputs inputs;
  int status;
  String id;
  int requestId;
  String productName;
  String productCategory;
  String productCode;
  List<dynamic> documents;

  factory CompletedRetirmentRequest.fromJson(Map<String, dynamic> json) =>
      CompletedRetirmentRequest(
        inputs: json["inputs"] == null ? null : Inputs.fromJson(json["inputs"]),
        status: json["Status"] == null ? null : json["Status"],
        id: json["ID"] == null ? null : json["ID"],
        requestId: json["RequestID"] == null ? null : json["RequestID"],
        productName: json["ProductName"] == null ? null : json["ProductName"],
        productCategory:
            json["ProductCategory"] == null ? null : json["ProductCategory"],
        productCode: json["ProductCode"] == null ? null : json["ProductCode"],
        documents: json["Documents"] == null
            ? null
            : List<dynamic>.from(json["Documents"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "inputs": inputs == null ? null : inputs.toJson(),
        "Status": status == null ? null : status,
        "ID": id == null ? null : id,
        "RequestID": requestId == null ? null : requestId,
        "ProductName": productName == null ? null : productName,
        "ProductCategory": productCategory == null ? null : productCategory,
        "ProductCode": productCode == null ? null : productCode,
        "Documents": documents == null
            ? null
            : List<dynamic>.from(documents.map((x) => x)),
      };
}

class Inputs {
  Inputs({
    this.age,
    this.gender,
    this.frequency,
    this.lumpsum,
    this.target,
    this.customerTarget,
    this.terms,
    this.index,
    this.amount,
    this.strategyValue,
    this.isAmountBased,
    this.insuranceType,
    this.witdrawals,
    this.witdrawalYears,
    this.lockTerms,
    this.lockTarget,
    this.lastStep,
    this.lastStage,
    this.facts,
    this.investorType,
    this.plan,
    this.client,
    this.growthRate,
    this.step,
    this.stage,
    this.recommendedInvestorType,
    this.answers,
  });

  int age;
  String gender;
  int frequency;
  int lumpsum;
  int target;
  int customerTarget;
  int terms;
  int index;
  int amount;
  int strategyValue;
  bool isAmountBased;
  int insuranceType;
  List<dynamic> witdrawals;
  List<dynamic> witdrawalYears;
  bool lockTerms;
  bool lockTarget;
  int lastStep;
  int lastStage;
  Facts facts;
  String investorType;
  String plan;
  String client;
  double growthRate;
  int step;
  int stage;
  String recommendedInvestorType;
  List<int> answers;

  factory Inputs.fromJson(Map<String, dynamic> json) => Inputs(
        age: json["age"] == null ? null : json["age"],
        gender: json["gender"] == null ? null : json["gender"],
        frequency: json["frequency"] == null ? null : json["frequency"],
        lumpsum: json["lumpsum"] == null ? null : json["lumpsum"],
        target: json["target"] == null ? null : json["target"],
        customerTarget:
            json["customerTarget"] == null ? null : json["customerTarget"],
        terms: json["terms"] == null ? null : json["terms"],
        index: json["index"] == null ? null : json["index"],
        amount: json["amount"] == null ? null : json["amount"],
        strategyValue:
            json["strategyValue"] == null ? null : json["strategyValue"],
        isAmountBased:
            json["isAmountBased"] == null ? null : json["isAmountBased"],
        insuranceType:
            json["insuranceType"] == null ? null : json["insuranceType"],
        witdrawals: json["witdrawals"] == null
            ? null
            : List<dynamic>.from(json["witdrawals"].map((x) => x)),
        witdrawalYears: json["witdrawalYears"] == null
            ? null
            : List<dynamic>.from(json["witdrawalYears"].map((x) => x)),
        lockTerms: json["lockTerms"] == null ? null : json["lockTerms"],
        lockTarget: json["lockTarget"] == null ? null : json["lockTarget"],
        lastStep: json["lastStep"] == null ? null : json["lastStep"],
        lastStage: json["lastStage"] == null ? null : json["lastStage"],
        facts: json["facts"] == null ? null : Facts.fromJson(json["facts"]),
        investorType:
            json["investorType"] == null ? null : json["investorType"],
        plan: json["plan"] == null ? null : json["plan"],
        client: json["client"] == null ? null : json["client"],
        growthRate:
            json["GrowthRate"] == null ? null : json["GrowthRate"].toDouble(),
        step: json["step"] == null ? null : json["step"],
        stage: json["stage"] == null ? null : json["stage"],
        recommendedInvestorType: json["recommendedInvestorType"] == null
            ? null
            : json["recommendedInvestorType"],
        answers: json["answers"] == null
            ? null
            : List<int>.from(json["answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "age": age == null ? null : age,
        "gender": gender == null ? null : gender,
        "frequency": frequency == null ? null : frequency,
        "lumpsum": lumpsum == null ? null : lumpsum,
        "target": target == null ? null : target,
        "customerTarget": customerTarget == null ? null : customerTarget,
        "terms": terms == null ? null : terms,
        "index": index == null ? null : index,
        "amount": amount == null ? null : amount,
        "strategyValue": strategyValue == null ? null : strategyValue,
        "isAmountBased": isAmountBased == null ? null : isAmountBased,
        "insuranceType": insuranceType == null ? null : insuranceType,
        "witdrawals": witdrawals == null
            ? null
            : List<dynamic>.from(witdrawals.map((x) => x)),
        "witdrawalYears": witdrawalYears == null
            ? null
            : List<dynamic>.from(witdrawalYears.map((x) => x)),
        "lockTerms": lockTerms == null ? null : lockTerms,
        "lockTarget": lockTarget == null ? null : lockTarget,
        "lastStep": lastStep == null ? null : lastStep,
        "lastStage": lastStage == null ? null : lastStage,
        "facts": facts == null ? null : facts.toJson(),
        "investorType": investorType == null ? null : investorType,
        "plan": plan == null ? null : plan,
        "client": client == null ? null : client,
        "GrowthRate": growthRate == null ? null : growthRate,
        "step": step == null ? null : step,
        "stage": stage == null ? null : stage,
        "recommendedInvestorType":
            recommendedInvestorType == null ? null : recommendedInvestorType,
        "answers":
            answers == null ? null : List<dynamic>.from(answers.map((x) => x)),
      };
}

class Facts {
  Facts({
    this.age,
    this.spouseAge,
    this.retirementAge,
    this.spouseRetirementAge,
    this.expenses,
    this.saving,
    this.savingInterestRate,
    this.endOfServiceIndemnity,
    this.monthlyPension,
    this.spouseMonthlyPension,
    this.yearlyPostRetirement,
    this.includeSpouse,
    this.salaryIncreaseRate,
    this.expensesIncreaseRate,
    this.expensesRelated,
    this.lifeExpectancy,
    this.postRetirementSpendingRate,
    this.includeMonthlyPension,
    this.includeEndOfServiceIndemnity,
    this.isAddLumpsum,
    this.includeSaving,
    this.tempSaving,
    this.tempMonthlyPension,
    this.tempEndOfServiceIndemnity,
    this.salary,
  });

  int age;
  int spouseAge;
  int retirementAge;
  int spouseRetirementAge;
  int expenses;
  int saving;
  int savingInterestRate;
  int endOfServiceIndemnity;
  int monthlyPension;
  int spouseMonthlyPension;
  int yearlyPostRetirement;
  bool includeSpouse;
  int salaryIncreaseRate;
  int expensesIncreaseRate;
  int expensesRelated;
  int lifeExpectancy;
  int postRetirementSpendingRate;
  bool includeMonthlyPension;
  bool includeEndOfServiceIndemnity;
  bool isAddLumpsum;
  bool includeSaving;
  int tempSaving;
  int tempMonthlyPension;
  int tempEndOfServiceIndemnity;
  dynamic salary;

  factory Facts.fromJson(Map<String, dynamic> json) => Facts(
        age: json["Age"] == null ? null : json["Age"],
        spouseAge: json["SpouseAge"] == null ? null : json["SpouseAge"],
        retirementAge:
            json["RetirementAge"] == null ? null : json["RetirementAge"],
        spouseRetirementAge: json["SpouseRetirementAge"] == null
            ? null
            : json["SpouseRetirementAge"],
        expenses: json["Expenses"] == null ? null : json["Expenses"],
        saving: json["Saving"] == null ? null : json["Saving"],
        savingInterestRate: json["SavingInterestRate"] == null
            ? null
            : json["SavingInterestRate"],
        endOfServiceIndemnity: json["EndOfServiceIndemnity"] == null
            ? null
            : json["EndOfServiceIndemnity"],
        monthlyPension:
            json["MonthlyPension"] == null ? null : json["MonthlyPension"],
        spouseMonthlyPension: json["SpouseMonthlyPension"] == null
            ? null
            : json["SpouseMonthlyPension"],
        yearlyPostRetirement: json["YearlyPostRetirement"] == null
            ? null
            : json["YearlyPostRetirement"],
        includeSpouse:
            json["IncludeSpouse"] == null ? null : json["IncludeSpouse"],
        salaryIncreaseRate: json["SalaryIncreaseRate"] == null
            ? null
            : json["SalaryIncreaseRate"],
        expensesIncreaseRate: json["ExpensesIncreaseRate"] == null
            ? null
            : json["ExpensesIncreaseRate"],
        expensesRelated:
            json["ExpensesRelated"] == null ? null : json["ExpensesRelated"],
        lifeExpectancy:
            json["LifeExpectancy"] == null ? null : json["LifeExpectancy"],
        postRetirementSpendingRate: json["PostRetirementSpendingRate"] == null
            ? null
            : json["PostRetirementSpendingRate"],
        includeMonthlyPension: json["IncludeMonthlyPension"] == null
            ? null
            : json["IncludeMonthlyPension"],
        includeEndOfServiceIndemnity:
            json["IncludeEndOfServiceIndemnity"] == null
                ? null
                : json["IncludeEndOfServiceIndemnity"],
        isAddLumpsum:
            json["IsAddLumpsum"] == null ? null : json["IsAddLumpsum"],
        includeSaving:
            json["IncludeSaving"] == null ? null : json["IncludeSaving"],
        tempSaving: json["TempSaving"] == null ? null : json["TempSaving"],
        tempMonthlyPension: json["TempMonthlyPension"] == null
            ? null
            : json["TempMonthlyPension"],
        tempEndOfServiceIndemnity: json["TempEndOfServiceIndemnity"] == null
            ? null
            : json["TempEndOfServiceIndemnity"],
        salary: json["Salary"],
      );

  Map<String, dynamic> toJson() => {
        "Age": age == null ? null : age,
        "SpouseAge": spouseAge == null ? null : spouseAge,
        "RetirementAge": retirementAge == null ? null : retirementAge,
        "SpouseRetirementAge":
            spouseRetirementAge == null ? null : spouseRetirementAge,
        "Expenses": expenses == null ? null : expenses,
        "Saving": saving == null ? null : saving,
        "SavingInterestRate":
            savingInterestRate == null ? null : savingInterestRate,
        "EndOfServiceIndemnity":
            endOfServiceIndemnity == null ? null : endOfServiceIndemnity,
        "MonthlyPension": monthlyPension == null ? null : monthlyPension,
        "SpouseMonthlyPension":
            spouseMonthlyPension == null ? null : spouseMonthlyPension,
        "YearlyPostRetirement":
            yearlyPostRetirement == null ? null : yearlyPostRetirement,
        "IncludeSpouse": includeSpouse == null ? null : includeSpouse,
        "SalaryIncreaseRate":
            salaryIncreaseRate == null ? null : salaryIncreaseRate,
        "ExpensesIncreaseRate":
            expensesIncreaseRate == null ? null : expensesIncreaseRate,
        "ExpensesRelated": expensesRelated == null ? null : expensesRelated,
        "LifeExpectancy": lifeExpectancy == null ? null : lifeExpectancy,
        "PostRetirementSpendingRate": postRetirementSpendingRate == null
            ? null
            : postRetirementSpendingRate,
        "IncludeMonthlyPension":
            includeMonthlyPension == null ? null : includeMonthlyPension,
        "IncludeEndOfServiceIndemnity": includeEndOfServiceIndemnity == null
            ? null
            : includeEndOfServiceIndemnity,
        "IsAddLumpsum": isAddLumpsum == null ? null : isAddLumpsum,
        "IncludeSaving": includeSaving == null ? null : includeSaving,
        "TempSaving": tempSaving == null ? null : tempSaving,
        "TempMonthlyPension":
            tempMonthlyPension == null ? null : tempMonthlyPension,
        "TempEndOfServiceIndemnity": tempEndOfServiceIndemnity == null
            ? null
            : tempEndOfServiceIndemnity,
        "Salary": salary,
      };
}
