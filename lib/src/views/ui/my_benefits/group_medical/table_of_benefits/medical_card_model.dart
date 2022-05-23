class MedicalCartModel {
  String firstName;
  String middleName;
  String lastName;
  String identityID;
  String photo;
  String category;
  String insuredMemberName;
  String memberEffectiveDate;
  String policyValidThru;
  String plan;
  int memberAnnualLimit;
  String dateOfBirth;
  int lifeCode;
  String relation;
  String sex;
  String exclusion;
  List<Plans> plans;
  String tPA;
  int principal;

  MedicalCartModel(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.identityID,
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
      this.tPA,
      this.principal});

  MedicalCartModel.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    identityID = json['IdentityID'];
    photo = json['Photo'];
    category = json['Category'];
    insuredMemberName = json['InsuredMemberName'];
    memberEffectiveDate = json['MemberEffectiveDate'];
    policyValidThru = json['PolicyValidThru'];
    plan = json['Plan'];
    memberAnnualLimit = json['MemberAnnualLimit'];
    dateOfBirth = json['DateOfBirth'];
    lifeCode = json['LifeCode'];
    relation = json['Relation'];
    sex = json['Sex'];
    exclusion = json['Exclusion'];
    if (json['Plans'] != null) {
      plans = new List<Plans>();
      json['Plans'].forEach((v) {
        plans.add(new Plans.fromJson(v));
      });
    }
    tPA = json['TPA'];
    principal = json['Principal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['IdentityID'] = this.identityID;
    data['Photo'] = this.photo;
    data['Category'] = this.category;
    data['InsuredMemberName'] = this.insuredMemberName;
    data['MemberEffectiveDate'] = this.memberEffectiveDate;
    data['PolicyValidThru'] = this.policyValidThru;
    data['Plan'] = this.plan;
    data['MemberAnnualLimit'] = this.memberAnnualLimit;
    data['DateOfBirth'] = this.dateOfBirth;
    data['LifeCode'] = this.lifeCode;
    data['Relation'] = this.relation;
    data['Sex'] = this.sex;
    data['Exclusion'] = this.exclusion;
    if (this.plans != null) {
      data['Plans'] = this.plans.map((v) => v.toJson()).toList();
    }
    data['TPA'] = this.tPA;
    data['Principal'] = this.principal;
    return data;
  }
}

class Plans {
  String name;
  int limit;

  Plans({this.name, this.limit});

  Plans.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    limit = json['Limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Limit'] = this.limit;
    return data;
  }
}
