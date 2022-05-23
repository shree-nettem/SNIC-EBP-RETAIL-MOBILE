class EmployeeDashboardProfileResponse {
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
  String otherContactNumber;
  String address;
  int salary;
  int relationshipType;
  String iBAN;
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
  List<Dependents> dependents;
  String relationDescription;
  String staffNumber;
  String name;
  String email;
  bool subscribed;

  EmployeeDashboardProfileResponse(
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
        this.otherContactNumber,
        this.address,
        this.salary,
        this.relationshipType,
        this.iBAN,
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
        this.subscribed});

  EmployeeDashboardProfileResponse.fromJson(Map<String, dynamic> json) {
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
    otherContactNumber = json['OtherContactNumber'];
    address = json['Address'];
    salary = json['Salary'];
    relationshipType = json['RelationshipType'];
    iBAN = json['IBAN'];
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
      dependents  = [];
      json['Dependents'].forEach((v) {
        dependents.add(new Dependents.fromJson(v));
      });
    }
    relationDescription = json['RelationDescription'];
    staffNumber = json['StaffNumber'];
    name = json['Name'];
    email = json['Email'];
    subscribed = json['Subscribed'];
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
    data['OtherContactNumber'] = this.otherContactNumber;
    data['Address'] = this.address;
    data['Salary'] = this.salary;
    data['RelationshipType'] = this.relationshipType;
    data['IBAN'] = this.iBAN;
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
  String otherContactNumber;
  String address;
  int salary;
  int relationshipType;
  String iBAN;
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
        this.otherContactNumber,
        this.address,
        this.salary,
        this.relationshipType,
        this.iBAN,
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
        this.subscribed});

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
    otherContactNumber = json['OtherContactNumber'];
    address = json['Address'];
    salary = json['Salary'];
    relationshipType = json['RelationshipType'];
    iBAN = json['IBAN'];
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
    dependents = json['Dependents'];
    relationDescription = json['RelationDescription'];
    staffNumber = json['StaffNumber'];
    name = json['Name'];
    email = json['Email'];
    subscribed = json['Subscribed'];
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
    data['OtherContactNumber'] = this.otherContactNumber;
    data['Address'] = this.address;
    data['Salary'] = this.salary;
    data['RelationshipType'] = this.relationshipType;
    data['IBAN'] = this.iBAN;
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
    return data;
  }
}


