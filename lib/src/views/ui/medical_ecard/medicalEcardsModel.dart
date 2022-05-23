import 'dart:convert';

List<MedicalEcardsModel> medicalEcardsModelFromJson(String str) =>
    List<MedicalEcardsModel>.from(
        json.decode(str).map((x) => MedicalEcardsModel.fromJson(x)));

String medicalEcardsModelToJson(List<MedicalEcardsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MedicalEcardsModel {
  MedicalEcardsModel({
    this.firstName,
    this.middleName,
    this.lastName,
    this.identityId,
    this.photo,
    this.category,
    this.insuredMemberName,
    this.memberEffectiveDate,
    this.policyValidThru,
    this.plan,
    this.memberAnnualLimit,
    this.dateOfBirth,
    this.lifeCode,
    this.relation,
    this.sex,
    this.exclusion,
    this.plans,
    this.tpa,
    this.principal,
  });

  String firstName;
  dynamic middleName;
  String lastName;
  String identityId;
  dynamic photo;
  String category;
  String insuredMemberName;
  DateTime memberEffectiveDate;
  DateTime policyValidThru;
  String plan;
  int memberAnnualLimit;
  DateTime dateOfBirth;
  int lifeCode;
  String relation;
  String sex;
  String exclusion;
  List<Plan> plans;
  String tpa;
  int principal;

  factory MedicalEcardsModel.fromJson(Map<String, dynamic> json) =>
      MedicalEcardsModel(
        firstName: json["FirstName"] == null ? null : json["FirstName"],
        middleName: json["MiddleName"],
        lastName: json["LastName"] == null ? null : json["LastName"],
        identityId: json["IdentityID"] == null ? null : json["IdentityID"],
        photo: json["Photo"],
        category: json["Category"] == null ? null : json["Category"],
        insuredMemberName: json["InsuredMemberName"] == null
            ? null
            : json["InsuredMemberName"],
        memberEffectiveDate: json["MemberEffectiveDate"] == null
            ? null
            : DateTime.parse(json["MemberEffectiveDate"]),
        policyValidThru: json["PolicyValidThru"] == null
            ? null
            : DateTime.parse(json["PolicyValidThru"]),
        plan: json["Plan"] == null ? null : json["Plan"],
        memberAnnualLimit: json["MemberAnnualLimit"] == null
            ? null
            : json["MemberAnnualLimit"],
        dateOfBirth: json["DateOfBirth"] == null
            ? null
            : DateTime.parse(json["DateOfBirth"]),
        lifeCode: json["LifeCode"] == null ? null : json["LifeCode"],
        relation: json["Relation"] == null ? null : json["Relation"],
        sex: json["Sex"] == null ? null : json["Sex"],
        exclusion: json["Exclusion"] == null ? null : json["Exclusion"],
        plans: json["Plans"] == null
            ? null
            : List<Plan>.from(json["Plans"].map((x) => Plan.fromJson(x))),
        tpa: json["TPA"] == null ? null : json["TPA"],
        principal: json["Principal"] == null ? null : json["Principal"],
      );

  Map<String, dynamic> toJson() => {
        "FirstName": firstName == null ? null : firstName,
        "MiddleName": middleName,
        "LastName": lastName == null ? null : lastName,
        "IdentityID": identityId == null ? null : identityId,
        "Photo": photo,
        "Category": category == null ? null : category,
        "InsuredMemberName":
            insuredMemberName == null ? null : insuredMemberName,
        "MemberEffectiveDate": memberEffectiveDate == null
            ? null
            : memberEffectiveDate.toIso8601String(),
        "PolicyValidThru":
            policyValidThru == null ? null : policyValidThru.toIso8601String(),
        "Plan": plan == null ? null : plan,
        "MemberAnnualLimit":
            memberAnnualLimit == null ? null : memberAnnualLimit,
        "DateOfBirth":
            dateOfBirth == null ? null : dateOfBirth.toIso8601String(),
        "LifeCode": lifeCode == null ? null : lifeCode,
        "Relation": relation == null ? null : relation,
        "Sex": sex == null ? null : sex,
        "Exclusion": exclusion == null ? null : exclusion,
        "Plans": plans == null
            ? null
            : List<dynamic>.from(plans.map((x) => x.toJson())),
        "TPA": tpa == null ? null : tpa,
        "Principal": principal == null ? null : principal,
      };
}

class Plan {
  Plan({
    this.name,
    this.limit,
  });

  String name;
  int limit;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        name: json["Name"] == null ? null : json["Name"],
        limit: json["Limit"] == null ? null : json["Limit"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name == null ? null : name,
        "Limit": limit == null ? null : limit,
      };
}
