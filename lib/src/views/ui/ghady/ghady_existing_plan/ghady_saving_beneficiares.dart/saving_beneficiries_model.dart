class GhadyBeneficiriesModel {
  GhadyBeneficiriesModel({
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
  List<Document> documents;

  factory GhadyBeneficiriesModel.fromJson(Map<String, dynamic> json) =>
      GhadyBeneficiriesModel(
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
            : List<Document>.from(
                json["Documents"].map((x) => Document.fromJson(x))),
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
            : List<dynamic>.from(documents.map((x) => x.toJson())),
      };
}

class Document {
  Document({
    this.documentId,
    this.requestId,
    this.type,
    this.date,
    this.workId,
    this.companyId,
    this.username,
    this.role,
    this.fileId,
    this.oldFileId,
  });

  String documentId;
  int requestId;
  int type;
  DateTime date;
  dynamic workId;
  dynamic companyId;
  dynamic username;
  dynamic role;
  String fileId;
  dynamic oldFileId;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documentId: json["DocumentID"] == null ? null : json["DocumentID"],
        requestId: json["RequestID"] == null ? null : json["RequestID"],
        type: json["Type"] == null ? null : json["Type"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        workId: json["WorkID"],
        companyId: json["CompanyId"],
        username: json["Username"],
        role: json["Role"],
        fileId: json["FileID"] == null ? null : json["FileID"],
        oldFileId: json["OldFileID"],
      );

  Map<String, dynamic> toJson() => {
        "DocumentID": documentId == null ? null : documentId,
        "RequestID": requestId == null ? null : requestId,
        "Type": type == null ? null : type,
        "Date": date == null ? null : date.toIso8601String(),
        "WorkID": workId,
        "CompanyId": companyId,
        "Username": username,
        "Role": role,
        "FileID": fileId == null ? null : fileId,
        "OldFileID": oldFileId,
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
    this.step,
    this.investorType,
    this.recommendedInvestorType,
    this.answers,
    this.plan,
    this.client,
    this.growthRate,
    this.beneficiaries,
    this.stage,
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
  int step;
  String investorType;
  String recommendedInvestorType;
  List<int> answers;
  String plan;
  String client;
  double growthRate;
  List<GhadyBeneficiary> beneficiaries;
  int stage;

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
        step: json["step"] == null ? null : json["step"],
        investorType:
            json["investorType"] == null ? null : json["investorType"],
        recommendedInvestorType: json["recommendedInvestorType"] == null
            ? null
            : json["recommendedInvestorType"],
        answers: json["answers"] == null
            ? null
            : List<int>.from(json["answers"].map((x) => x)),
        plan: json["plan"] == null ? null : json["plan"],
        client: json["client"] == null ? null : json["client"],
        growthRate:
            json["GrowthRate"] == null ? null : json["GrowthRate"].toDouble(),
        beneficiaries: json["beneficiaries"] == null
            ? null
            : List<GhadyBeneficiary>.from(
                json["beneficiaries"].map((x) => GhadyBeneficiary.fromJson(x))),
        stage: json["stage"] == null ? null : json["stage"],
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
        "step": step == null ? null : step,
        "investorType": investorType == null ? null : investorType,
        "recommendedInvestorType":
            recommendedInvestorType == null ? null : recommendedInvestorType,
        "answers":
            answers == null ? null : List<dynamic>.from(answers.map((x) => x)),
        "plan": plan == null ? null : plan,
        "client": client == null ? null : client,
        "GrowthRate": growthRate == null ? null : growthRate,
        "beneficiaries": beneficiaries == null
            ? null
            : List<dynamic>.from(beneficiaries.map((x) => x.toJson())),
        "stage": stage == null ? null : stage,
      };
}

class GhadyBeneficiary {
  GhadyBeneficiary({
    this.name,
    this.relation,
    this.id,
    this.contact,
    this.beneficiaryPercentage,
    this.beneficiaryDateOfBirth,
    this.beneficiaryAddress,
    this.guardianName,
    this.guardianDateOfBirth,
    this.guardianMobile,
    this.guardianAddress,
    this.guardianIdNo,
    this.guardianRelation,
    this.guardianGender,
    this.guardianNationality,
    this.guardianEmail,
    this.beneficiaryMobileCountryCode,
    this.guardianMobileCountryCode,
  });

  String name;
  String relation;
  String id;
  String contact;
  double beneficiaryPercentage;
  DateTime beneficiaryDateOfBirth;
  String beneficiaryAddress;
  String guardianName;
  DateTime guardianDateOfBirth;
  String guardianMobile;
  String guardianAddress;
  String guardianIdNo;
  String guardianRelation;
  String guardianGender;
  String guardianNationality;
  String guardianEmail;
  String beneficiaryMobileCountryCode;
  String guardianMobileCountryCode;

  factory GhadyBeneficiary.fromJson(Map<String, dynamic> json) =>
      GhadyBeneficiary(
        name: json["Name"] == null ? null : json["Name"],
        relation: json["Relation"] == null ? null : json["Relation"],
        id: json["ID"] == null ? null : json["ID"],
        contact: json["Contact"] == null ? null : json["Contact"],
        beneficiaryPercentage:
            json["Per"] == null ? null : json["Per"].toDouble(),
        beneficiaryDateOfBirth: json["BeneficiaryDateOfBirth"] == null
            ? null
            : DateTime.parse(json["BeneficiaryDateOfBirth"]),
        beneficiaryAddress: json["BeneficiaryAddress"] == null
            ? null
            : json["BeneficiaryAddress"],
        guardianName:
            json["GuardianName"] == null ? null : json["GuardianName"],
        guardianDateOfBirth: json["GuardianDateOfBirth"] == null
            ? null
            : DateTime.parse(json["GuardianDateOfBirth"]),
        guardianMobile:
            json["GuardianMobile"] == null ? null : json["GuardianMobile"],
        guardianAddress:
            json["GuardianAddress"] == null ? null : json["GuardianAddress"],
        guardianIdNo:
            json["GuardianIDNo"] == null ? null : json["GuardianIDNo"],
        guardianRelation:
            json["GuardianRelation"] == null ? null : json["GuardianRelation"],
        guardianGender:
            json["GuardianGender"] == null ? null : json["GuardianGender"],
        guardianNationality: json["GuardianNationality"] == null
            ? null
            : json["GuardianNationality"],
        guardianEmail:
            json["GuardianEmail"] == null ? null : json["GuardianEmail"],
        beneficiaryMobileCountryCode:
            json["BeneficiaryMobileCountryCode"] == null
                ? null
                : json["BeneficiaryMobileCountryCode"],
        guardianMobileCountryCode: json["GuardianMobileCountryCode"] == null
            ? null
            : json["GuardianMobileCountryCode"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name == null ? null : name,
        "Relation": relation == null ? null : relation,
        "ID": id == null ? null : id,
        "Contact": contact == null ? null : contact,
        "Per": beneficiaryPercentage == null ? null : beneficiaryPercentage,
        "BeneficiaryDateOfBirth": beneficiaryDateOfBirth == null
            ? null
            : beneficiaryDateOfBirth.toIso8601String(),
        "BeneficiaryAddress":
            beneficiaryAddress == null ? null : beneficiaryAddress,
        "GuardianName": guardianName == null ? null : guardianName,
        "GuardianDateOfBirth": guardianDateOfBirth == null
            ? null
            : guardianDateOfBirth.toIso8601String(),
        "GuardianMobile": guardianMobile == null ? null : guardianMobile,
        "GuardianAddress": guardianAddress == null ? null : guardianAddress,
        "GuardianIDNo": guardianIdNo == null ? null : guardianIdNo,
        "GuardianRelation": guardianRelation == null ? null : guardianRelation,
        "GuardianGender": guardianGender == null ? null : guardianGender,
        "GuardianNationality":
            guardianNationality == null ? null : guardianNationality,
        "GuardianEmail": guardianEmail == null ? null : guardianEmail,
        "BeneficiaryMobileCountryCode": beneficiaryMobileCountryCode,
        "GuardianMobileCountryCode": guardianMobileCountryCode,
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
      };
}
