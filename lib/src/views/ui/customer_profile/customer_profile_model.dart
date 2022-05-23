class CustomerProfileModel {
  Details details;
  bool basicInformation;
  bool financialDetails;
  bool identification;
  bool personalVerification;
  bool mailingAddress;

  CustomerProfileModel(
      {this.details,
      this.basicInformation,
      this.financialDetails,
      this.identification,
      this.personalVerification,
      this.mailingAddress});

  CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
    basicInformation = json['BasicInformation'];
    financialDetails = json['FinancialDetails'];
    identification = json['Identification'];
    personalVerification = json['PersonalVerification'];
    mailingAddress = json['MailingAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['BasicInformation'] = this.basicInformation;
    data['FinancialDetails'] = this.financialDetails;
    data['Identification'] = this.identification;
    data['PersonalVerification'] = this.personalVerification;
    data['MailingAddress'] = this.mailingAddress;
    return data;
  }
}

class Details {
  int iD;
  String userID;
  String appID;
  int companyID;
  String firstName;
  String middleName;
  String lastName;
  String identityExpiryDate;
  String licenceExpiryDate;
  String dateOfBirth;
  String gender;
  String department;
  String position;
  String mobileNumber;
  String countryCode;
  String otherContactNumber;
  String otherContactNumberCountryCode;
  String address;
  String mailingAddressTown;
  String mailingAddressBlock;
  String mailingAddressRoad;
  String mailingAddressHouse;
  String mailingAddressFlat;
  String mailingAddressAlpha;
  String homeAddressTown;
  String homeAddressBlock;
  String homeAddressRoad;
  String homeAddressHouse;
  String homeAddressFlat;
  String homeAddressAlpha;
  int salary;
  String iBAN;
  String sourceOfIncome;
  String bank;
  int relationshipType;
  String identityID;
  String passportID;
  String photo;
  int maritalStatus;
  String nationality;
  int iDType;
  String personalEmail;
  String corporateEmail;
  int primaryEmail;
  int status;
  List<Documents> documents;
  List<Dependents> dependents;
  String relationDescription;
  String staffNumber;
  String name;
  String email;
  bool subscribed;
  String corporateEmailConfirmedAt;
  String personalEmailConfirmedAt;
  String mobileNumberConfirmedAt;
  String employerName;
  String placeOfBirth;
  String employerAddressTown;
  String employerAddressBlock;
  String employerAddressRoad;
  String employerAddressHouse;
  String employerAddressFlat;
  String employerAddressAlpha;
  dynamic resident;
  String monthlyIncome;

  Details(
      {this.iD,
      this.userID,
      this.appID,
      this.companyID,
      this.firstName,
      this.middleName,
      this.lastName,
      this.identityExpiryDate,
      this.licenceExpiryDate,
      this.dateOfBirth,
      this.gender,
      this.department,
      this.position,
      this.mobileNumber,
      this.countryCode,
      this.otherContactNumber,
      this.otherContactNumberCountryCode,
      this.address,
      this.mailingAddressTown,
      this.mailingAddressBlock,
      this.mailingAddressRoad,
      this.mailingAddressHouse,
      this.mailingAddressFlat,
      this.mailingAddressAlpha,
      this.homeAddressTown,
      this.homeAddressBlock,
      this.homeAddressRoad,
      this.homeAddressHouse,
      this.homeAddressFlat,
      this.homeAddressAlpha,
      this.salary,
      this.relationshipType,
      this.iBAN,
      this.sourceOfIncome,
      this.bank,
      this.identityID,
      this.passportID,
      this.photo,
      this.maritalStatus,
      this.nationality,
      this.iDType,
      this.personalEmail,
      this.corporateEmail,
      this.primaryEmail,
      this.status,
      this.documents,
      this.dependents,
      this.relationDescription,
      this.staffNumber,
      this.name,
      this.email,
      this.subscribed,
      this.corporateEmailConfirmedAt,
      this.personalEmailConfirmedAt,
      this.mobileNumberConfirmedAt,
      this.employerName,
      this.placeOfBirth,
      this.employerAddressTown,
      this.employerAddressBlock,
      this.employerAddressRoad,
      this.employerAddressHouse,
      this.employerAddressFlat,
      this.employerAddressAlpha,
      this.resident,
      this.monthlyIncome});

  Details.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userID = json['UserID'];
    appID = json['AppID'];
    companyID = json['CompanyID'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    identityExpiryDate = json['IdentityExpiryDate'];
    licenceExpiryDate = json['LicenceExpiryDate'];
    dateOfBirth = json['DateOfBirth'];
    gender = json['Gender'];
    department = json['Department'];
    position = json['Position'];
    mobileNumber = json['MobileNumber'];
    countryCode = json['CountryCode'] ?? "";
    otherContactNumber = json['OtherContactNumber'];
    otherContactNumberCountryCode = json["OtherContactNumberCountryCode"];
    address = json['Address'];
    mailingAddressTown = json['MailingAddressTown'];
    mailingAddressBlock = json['MailingAddressBlock'];
    mailingAddressRoad = json['MailingAddressRoad'];
    mailingAddressHouse = json['MailingAddressHouse'];
    mailingAddressFlat = json['MailingAddressFlat'];
    mailingAddressAlpha = json['MailingAddressAlpha'];
    homeAddressTown = json['HomeAddressTown'];
    homeAddressBlock = json['HomeAddressBlock'];
    homeAddressRoad = json['HomeAddressRoad'];
    homeAddressHouse = json['HomeAddressHouse'];
    homeAddressFlat = json['HomeAddressFlat'];
    homeAddressAlpha = json['HomeAddressAlpha'];
    salary = json['Salary'];
    relationshipType = json['RelationshipType'];
    iBAN = json['IBAN'];
    sourceOfIncome = json['SourceOfIncome'];
    bank = json['Bank'];
    identityID = json['IdentityID'];
    passportID = json['PassportID'];
    photo = json['Photo'];
    maritalStatus = json['MaritalStatus'];
    nationality = json['Nationality'];
    iDType = json['IDType'];
    personalEmail = json['PersonalEmail'];
    corporateEmail = json['CorporateEmail'];
    primaryEmail = json['PrimaryEmail'];
    status = json['Status'];
    if (json['Documents'] != null) {
      documents = [];
      json['Documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    if (json['Dependents'] != null) {
      dependents = [];
      json['Dependents'].forEach((v) {
        dependents.add(new Dependents.fromJson(v));
      });
    }
    relationDescription = json['RelationDescription'];
    staffNumber = json['StaffNumber'];
    name = json['Name'];
    email = json['Email'];
    subscribed = json['Subscribed'];
    corporateEmailConfirmedAt = json['CorporateEmailConfirmedAt'];
    personalEmailConfirmedAt = json['PersonalEmailConfirmedAt'];
    mobileNumberConfirmedAt = json['MobileNumberConfirmedAt'];
    employerName = json['EmployerName'];
    placeOfBirth = json['PlaceOfBirth'];
    employerAddressTown = json['EmployerAddressTown'];
    employerAddressBlock = json['EmployerAddressBlock'];
    employerAddressRoad = json['EmployerAddressRoad'];
    employerAddressHouse = json['EmployerAddressHouse'];
    employerAddressFlat = json['EmployerAddressFlat'];
    employerAddressAlpha = json['EmployerAddressAlpha'];
    resident = json['Resident'];
    monthlyIncome = json['MonthlyIncome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['UserID'] = this.userID;
    data['AppID'] = this.appID;
    data['CompanyID'] = this.companyID;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['IdentityExpiryDate'] = this.identityExpiryDate;
    data['LicenceExpiryDate'] = this.licenceExpiryDate;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Gender'] = this.gender;
    data['Department'] = this.department;
    data['Position'] = this.position;
    data['MobileNumber'] = this.mobileNumber;
    data['CountryCode'] = this.countryCode;
    data['OtherContactNumber'] = this.otherContactNumber;
    data['OtherContactNumberCountryCode'] = this.otherContactNumberCountryCode;
    data['Address'] = this.address;
    data['MailingAddressTown'] = this.mailingAddressTown;
    data['MailingAddressBlock'] = this.mailingAddressBlock;
    data['MailingAddressRoad'] = this.mailingAddressRoad;
    data['MailingAddressHouse'] = this.mailingAddressHouse;
    data['MailingAddressFlat'] = this.mailingAddressFlat;
    data['MailingAddressAlpha'] = this.mailingAddressAlpha;
    data['HomeAddressTown'] = this.homeAddressTown;
    data['HomeAddressBlock'] = this.homeAddressBlock;
    data['HomeAddressRoad'] = this.homeAddressRoad;
    data['HomeAddressHouse'] = this.homeAddressHouse;
    data['HomeAddressFlat'] = this.homeAddressFlat;
    data['HomeAddressAlpha'] = this.homeAddressAlpha;
    data['Salary'] = this.salary;
    data['RelationshipType'] = this.relationshipType;
    data['IBAN'] = this.iBAN;
    data['SourceOfIncome'] = this.sourceOfIncome;
    data['Bank'] = this.bank;
    data['IdentityID'] = this.identityID;
    data['PassportID'] = this.passportID;
    data['Photo'] = this.photo;
    data['MaritalStatus'] = this.maritalStatus;
    data['Nationality'] = this.nationality;
    data['IDType'] = this.iDType;
    data['PersonalEmail'] = this.personalEmail;
    data['CorporateEmail'] = this.corporateEmail;
    data['PrimaryEmail'] = this.primaryEmail;
    data['Status'] = this.status;
    if (this.documents != null) {
      data['Documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    if (this.dependents != null) {
      data['Dependents'] = this.dependents.map((v) => v.toJson()).toList();
    }
    data['RelationDescription'] = this.relationDescription;
    data['StaffNumber'] = this.staffNumber;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Subscribed'] = this.subscribed;
    data['CorporateEmailConfirmedAt'] = this.corporateEmailConfirmedAt;
    data['PersonalEmailConfirmedAt'] = this.personalEmailConfirmedAt;
    data['MobileNumberConfirmedAt'] = this.mobileNumberConfirmedAt;
    data['EmployerName'] = this.employerName;
    data['PlaceOfBirth'] = this.placeOfBirth;
    data['EmployerAddressTown'] = this.employerAddressTown;
    data['EmployerAddressBlock'] = this.employerAddressBlock;
    data['EmployerAddressRoad'] = this.employerAddressRoad;
    data['EmployerAddressHouse'] = this.employerAddressHouse;
    data['EmployerAddressFlat'] = this.employerAddressFlat;
    data['EmployerAddressAlpha'] = this.employerAddressAlpha;
    data['Resident'] = this.resident;
    data['MonthlyIncome'] = this.monthlyIncome;
    return data;
  }
}

class Documents {
  int documentID;
  int customerID;
  int type;
  String file;

  Documents({this.documentID, this.customerID, this.type, this.file});

  Documents.fromJson(Map<String, dynamic> json) {
    documentID = json['DocumentID'];
    customerID = json['CustomerID'];
    type = json['Type'];
    file = json['File'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentID'] = this.documentID;
    data['CustomerID'] = this.customerID;
    data['Type'] = this.type;
    data['File'] = this.file;
    return data;
  }
}

class Dependents {
  int iD;
  String userID;
  String appID;
  int companyID;
  String firstName;
  String middleName;
  String lastName;
  String identityExpiryDate;
  String licenceExpiryDate;
  String dateOfBirth;
  String gender;
  String department;
  String position;
  String mobileNumber;
  String countryCode;
  String otherContactNumber;
  String otherContactNumberCountryCode;
  String address;
  String mailingAddressTown;
  String mailingAddressBlock;
  String mailingAddressRoad;
  String mailingAddressHouse;
  String homeAddressTown;
  String homeAddressBlock;
  String homeAddressRoad;
  String homeAddressHouse;
  int salary;
  int relationshipType;
  String iBAN;
  String sourceOfIncome;
  String bank;
  String identityID;
  String passportID;
  String photo;
  int maritalStatus;
  String nationality;
  int iDType;
  String personalEmail;
  String corporateEmail;
  int primaryEmail;
  int status;
  List<Documents> documents;
  String dependents;
  String relationDescription;
  String staffNumber;
  String name;
  String email;
  bool subscribed;
  String corporateEmailConfirmedAt;
  String personalEmailConfirmedAt;
  String mobileNumberConfirmedAt;

  Dependents(
      {this.iD,
      this.userID,
      this.appID,
      this.companyID,
      this.firstName,
      this.middleName,
      this.lastName,
      this.identityExpiryDate,
      this.licenceExpiryDate,
      this.dateOfBirth,
      this.gender,
      this.department,
      this.position,
      this.mobileNumber,
      this.countryCode,
      this.otherContactNumber,
      this.otherContactNumberCountryCode,
      this.address,
      this.mailingAddressTown,
      this.mailingAddressBlock,
      this.mailingAddressRoad,
      this.mailingAddressHouse,
      this.homeAddressTown,
      this.homeAddressBlock,
      this.homeAddressRoad,
      this.homeAddressHouse,
      this.salary,
      this.relationshipType,
      this.iBAN,
      this.sourceOfIncome,
      this.bank,
      this.identityID,
      this.passportID,
      this.photo,
      this.maritalStatus,
      this.nationality,
      this.iDType,
      this.personalEmail,
      this.corporateEmail,
      this.primaryEmail,
      this.status,
      this.documents,
      this.dependents,
      this.relationDescription,
      this.staffNumber,
      this.name,
      this.email,
      this.subscribed,
      this.corporateEmailConfirmedAt,
      this.personalEmailConfirmedAt,
      this.mobileNumberConfirmedAt});

  Dependents.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userID = json['UserID'];
    appID = json['AppID'];
    companyID = json['CompanyID'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    identityExpiryDate = json['IdentityExpiryDate'];
    licenceExpiryDate = json['LicenceExpiryDate'];
    dateOfBirth = json['DateOfBirth'];
    gender = json['Gender'];
    department = json['Department'];
    position = json['Position'];
    mobileNumber = json['MobileNumber'];
    countryCode = json["CountryCode"];
    otherContactNumber = json["OtherContactNumber"];
    otherContactNumberCountryCode = json["OtherContactNumberCountryCode"];
    address = json['Address'];
    mailingAddressTown = json['MailingAddressTown'];
    mailingAddressBlock = json['MailingAddressBlock'];
    mailingAddressRoad = json['MailingAddressRoad'];
    mailingAddressHouse = json['MailingAddressHouse'];
    homeAddressTown = json['HomeAddressTown'];
    homeAddressBlock = json['HomeAddressBlock'];
    homeAddressRoad = json['HomeAddressRoad'];
    homeAddressHouse = json['HomeAddressHouse'];
    salary = json['Salary'];
    relationshipType = json['RelationshipType'];
    iBAN = json['IBAN'];
    sourceOfIncome = json['SourceOfIncome'];
    bank = json['Bank'];
    identityID = json['IdentityID'];
    passportID = json['PassportID'];
    photo = json['Photo'];
    maritalStatus = json['MaritalStatus'];
    nationality = json['Nationality'];
    iDType = json['IDType'];
    personalEmail = json['PersonalEmail'];
    corporateEmail = json['CorporateEmail'];
    primaryEmail = json['PrimaryEmail'];
    status = json['Status'];
    if (json['Documents'] != null) {
      documents = new List<Documents>();
      json['Documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    dependents = json['Dependents'];
    relationDescription = json['RelationDescription'];
    staffNumber = json['StaffNumber'];
    name = json['Name'];
    email = json['Email'];
    subscribed = json['Subscribed'];
    corporateEmailConfirmedAt = json['CorporateEmailConfirmedAt'];
    personalEmailConfirmedAt = json['PersonalEmailConfirmedAt'];
    mobileNumberConfirmedAt = json['MobileNumberConfirmedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['UserID'] = this.userID;
    data['AppID'] = this.appID;
    data['CompanyID'] = this.companyID;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['IdentityExpiryDate'] = this.identityExpiryDate;
    data['LicenceExpiryDate'] = this.licenceExpiryDate;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Gender'] = this.gender;
    data['Department'] = this.department;
    data['Position'] = this.position;
    data['MobileNumber'] = this.mobileNumber;
    data['CountryCode'] = this.countryCode;
    data['OtherContactNumber'] = this.otherContactNumber;
    data['OtherContactNumberCountryCode'] = this.otherContactNumberCountryCode;
    data['Address'] = this.address;
    data['MailingAddressTown'] = this.mailingAddressTown;
    data['MailingAddressBlock'] = this.mailingAddressBlock;
    data['MailingAddressRoad'] = this.mailingAddressRoad;
    data['MailingAddressHouse'] = this.mailingAddressHouse;
    data['HomeAddressTown'] = this.homeAddressTown;
    data['HomeAddressBlock'] = this.homeAddressBlock;
    data['HomeAddressRoad'] = this.homeAddressRoad;
    data['HomeAddressHouse'] = this.homeAddressHouse;
    data['Salary'] = this.salary;
    data['RelationshipType'] = this.relationshipType;
    data['IBAN'] = this.iBAN;
    data['SourceOfIncome'] = this.sourceOfIncome;
    data['Bank'] = this.bank;
    data['IdentityID'] = this.identityID;
    data['PassportID'] = this.passportID;
    data['Photo'] = this.photo;
    data['MaritalStatus'] = this.maritalStatus;
    data['Nationality'] = this.nationality;
    data['IDType'] = this.iDType;
    data['PersonalEmail'] = this.personalEmail;
    data['CorporateEmail'] = this.corporateEmail;
    data['PrimaryEmail'] = this.primaryEmail;
    data['Status'] = this.status;
    if (this.documents != null) {
      data['Documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['Dependents'] = this.dependents;
    data['RelationDescription'] = this.relationDescription;
    data['StaffNumber'] = this.staffNumber;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Subscribed'] = this.subscribed;
    data['CorporateEmailConfirmedAt'] = this.corporateEmailConfirmedAt;
    data['PersonalEmailConfirmedAt'] = this.personalEmailConfirmedAt;
    data['MobileNumberConfirmedAt'] = this.mobileNumberConfirmedAt;
    return data;
  }
}
