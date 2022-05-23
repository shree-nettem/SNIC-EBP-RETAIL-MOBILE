class LoginModel {
  String id;
  String name;
  bool activated;
  bool isEnabled;
  List<Roles> roles;
  List<Companies> companies;
  bool emailConfirmed;
  bool phoneNumberConfirmed;
  String referralCode;
  int numberOfReferrals;
  Onboarding onboarding;
  int customerId;

  LoginModel(
      {this.id,
      this.name,
      this.activated,
      this.isEnabled,
      this.roles,
      this.companies,
      this.emailConfirmed,
      this.phoneNumberConfirmed,
      this.referralCode,
      this.numberOfReferrals,
      this.customerId,
      this.onboarding});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    activated = json['Activated'];
    isEnabled = json['IsEnabled'];
    customerId = json['CustomerId'];
    if (json['Roles'] != null) {
      roles = [];
      json['Roles'].forEach((v) {
        roles.add(new Roles.fromJson(v));
      });
    }
    if (json['Companies'] != null) {
      companies = [];
      json['Companies'].forEach((v) {
        companies.add(new Companies.fromJson(v));
      });
    }
    emailConfirmed = json['EmailConfirmed'];
    phoneNumberConfirmed = json['PhoneNumberConfirmed'];
    referralCode = json['ReferralCode'] ?? "";
    numberOfReferrals = json['NumberOfReferrals'] ?? 0;
    onboarding = json['Onboarding'] != null
        ? new Onboarding.fromJson(json['Onboarding'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Activated'] = this.activated;
    data['IsEnabled'] = this.isEnabled;
    if (this.roles != null) {
      data['Roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    if (this.companies != null) {
      data['Companies'] = this.companies.map((v) => v.toJson()).toList();
    }
    data['EmailConfirmed'] = this.emailConfirmed;
    data['PhoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['ReferralCode'] = this.referralCode;
    data['CustomerId'] = this.customerId;
    data['NumberOfReferrals'] = this.numberOfReferrals;
    if (this.onboarding != null) {
      data['Onboarding'] = this.onboarding.toJson();
    }
    return data;
  }
}

class Roles {
  String roleID;
  String name;

  Roles({this.roleID, this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    roleID = json['RoleID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RoleID'] = this.roleID;
    data['Name'] = this.name;
    return data;
  }
}

class Companies {
  int companyID;
  String name;
  bool isEnabled;

  Companies({this.companyID, this.name, this.isEnabled});

  Companies.fromJson(Map<String, dynamic> json) {
    companyID = json['CompanyID'];
    name = json['Name'];
    isEnabled = json['IsEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyID'] = this.companyID;
    data['Name'] = this.name;
    data['IsEnabled'] = this.isEnabled;
    return data;
  }
}

class Onboarding {
  int id;
  int currentStepId;
  String currentStepName;

  Onboarding({this.id, this.currentStepId, this.currentStepName});

  Onboarding.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    currentStepId = json['CurrentStepId'];
    currentStepName = json['CurrentStepName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CurrentStepId'] = this.currentStepId;
    data['CurrentStepName'] = this.currentStepName;
    return data;
  }
}
