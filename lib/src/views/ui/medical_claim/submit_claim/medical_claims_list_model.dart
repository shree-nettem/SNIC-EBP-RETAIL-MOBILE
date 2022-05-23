import 'dart:convert';

List<MedicalClaimsListModel> medicalClaimsListModelFromJson(String str) =>
    List<MedicalClaimsListModel>.from(
        json.decode(str).map((x) => MedicalClaimsListModel.fromJson(x)));

String medicalClaimsListModelToJson(List<MedicalClaimsListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MedicalClaimsListModel {
  MedicalClaimsListModel({
    this.assignees,
    this.beneficiary,
    this.customer,
    this.directDebits,
    this.documents,
    this.history,
    this.requestId,
    this.insurerId,
    this.workflowId,
    this.workId,
    this.activeWorkId,
    this.actionId,
    this.id,
    this.type,
    this.referenceId,
    this.customerId,
    this.beneficiaryId,
    this.productName,
    this.currency,
    this.productCategory,
    this.productCode,
    this.description,
    this.amount,
    this.approvedAmount,
    this.installments,
    this.paymentFrequency,
    this.paymentMethod,
    this.status,
    this.requestDate,
    this.inputs,
    this.updateByCompanyId,
    this.updateByUser,
    this.updateByRole,
    this.updateDate,
    this.isClosed,
    this.companyId,
    this.username,
    this.role,
    this.product,
    this.requestBy,
  });

  List<Assignee> assignees;
  dynamic beneficiary;
  Customer customer;
  List<dynamic> directDebits;
  List<Document> documents;
  List<History> history;
  int requestId;
  int insurerId;
  String workflowId;
  String workId;
  String activeWorkId;
  dynamic actionId;
  String id;
  String type;
  String referenceId;
  int customerId;
  dynamic beneficiaryId;
  String productName;
  String currency;
  String productCategory;
  String productCode;
  dynamic description;
  double amount;
  double approvedAmount;
  int installments;
  int paymentFrequency;
  int paymentMethod;
  int status;
  DateTime requestDate;
  dynamic inputs;
  int updateByCompanyId;
  String updateByUser;
  String updateByRole;
  DateTime updateDate;
  bool isClosed;
  int companyId;
  String username;
  String role;
  Product product;
  dynamic requestBy;

  factory MedicalClaimsListModel.fromJson(Map<String, dynamic> json) =>
      MedicalClaimsListModel(
        assignees: json["Assignees"] == null
            ? null
            : List<Assignee>.from(
                json["Assignees"].map((x) => Assignee.fromJson(x))),
        beneficiary: json["Beneficiary"],
        customer: json["Customer"] == null
            ? null
            : Customer.fromJson(json["Customer"]),
        directDebits: json["DirectDebits"] == null
            ? null
            : List<dynamic>.from(json["DirectDebits"].map((x) => x)),
        documents: json["Documents"] == null
            ? null
            : List<Document>.from(
                json["Documents"].map((x) => Document.fromJson(x))),
        history: json["History"] == null
            ? null
            : List<History>.from(
                json["History"].map((x) => History.fromJson(x))),
        requestId: json["RequestID"] == null ? null : json["RequestID"],
        insurerId: json["InsurerId"] == null ? null : json["InsurerId"],
        workflowId: json["WorkflowID"] == null ? null : json["WorkflowID"],
        workId: json["WorkID"] == null ? null : json["WorkID"],
        activeWorkId:
            json["ActiveWorkID"] == null ? null : json["ActiveWorkID"],
        actionId: json["ActionID"],
        id: json["ID"] == null ? null : json["ID"],
        type: json["Type"] == null ? null : json["Type"],
        referenceId: json["ReferenceID"] == null ? null : json["ReferenceID"],
        customerId: json["CustomerID"] == null ? null : json["CustomerID"],
        beneficiaryId: json["BeneficiaryID"],
        productName: json["ProductName"] == null ? null : json["ProductName"],
        currency: json["Currency"] == null ? null : json["Currency"],
        productCategory:
            json["ProductCategory"] == null ? null : json["ProductCategory"],
        productCode: json["ProductCode"] == null ? null : json["ProductCode"],
        description: json["Description"],
        amount: json["Amount"] == null ? null : json["Amount"],
        approvedAmount:
            json["ApprovedAmount"] == null ? null : json["ApprovedAmount"],
        installments:
            json["Installments"] == null ? null : json["Installments"],
        paymentFrequency:
            json["PaymentFrequency"] == null ? null : json["PaymentFrequency"],
        paymentMethod:
            json["PaymentMethod"] == null ? null : json["PaymentMethod"],
        status: json["Status"] == null ? null : json["Status"],
        requestDate: json["RequestDate"] == null
            ? null
            : DateTime.parse(json["RequestDate"]),
        inputs: json["Inputs"],
        updateByCompanyId: json["UpdateByCompanyId"] == null
            ? null
            : json["UpdateByCompanyId"],
        updateByUser:
            json["UpdateByUser"] == null ? null : json["UpdateByUser"],
        updateByRole:
            json["UpdateByRole"] == null ? null : json["UpdateByRole"],
        updateDate: json["UpdateDate"] == null
            ? null
            : DateTime.parse(json["UpdateDate"]),
        isClosed: json["IsClosed"] == null ? null : json["IsClosed"],
        companyId: json["CompanyId"] == null ? null : json["CompanyId"],
        username: json["Username"] == null ? null : json["Username"],
        role: json["Role"] == null ? null : json["Role"],
        product:
            json["Product"] == null ? null : Product.fromJson(json["Product"]),
        requestBy: json["RequestBy"],
      );

  Map<String, dynamic> toJson() => {
        "Assignees": assignees == null
            ? null
            : List<dynamic>.from(assignees.map((x) => x.toJson())),
        "Beneficiary": beneficiary,
        "Customer": customer == null ? null : customer.toJson(),
        "DirectDebits": directDebits == null
            ? null
            : List<dynamic>.from(directDebits.map((x) => x)),
        "Documents": documents == null
            ? null
            : List<dynamic>.from(documents.map((x) => x.toJson())),
        "History": history == null
            ? null
            : List<dynamic>.from(history.map((x) => x.toJson())),
        "RequestID": requestId == null ? null : requestId,
        "InsurerId": insurerId == null ? null : insurerId,
        "WorkflowID": workflowId == null ? null : workflowId,
        "WorkID": workId == null ? null : workId,
        "ActiveWorkID": activeWorkId == null ? null : activeWorkId,
        "ActionID": actionId,
        "ID": id == null ? null : id,
        "Type": type == null ? null : type,
        "ReferenceID": referenceId == null ? null : referenceId,
        "CustomerID": customerId == null ? null : customerId,
        "BeneficiaryID": beneficiaryId,
        "ProductName": productName == null ? null : productName,
        "Currency": currency == null ? null : currency,
        "ProductCategory": productCategory == null ? null : productCategory,
        "ProductCode": productCode == null ? null : productCode,
        "Description": description,
        "Amount": amount == null ? null : amount,
        "ApprovedAmount": approvedAmount == null ? null : approvedAmount,
        "Installments": installments == null ? null : installments,
        "PaymentFrequency": paymentFrequency == null ? null : paymentFrequency,
        "PaymentMethod": paymentMethod == null ? null : paymentMethod,
        "Status": status == null ? null : status,
        "RequestDate":
            requestDate == null ? null : requestDate.toIso8601String(),
        "Inputs": inputs,
        "UpdateByCompanyId":
            updateByCompanyId == null ? null : updateByCompanyId,
        "UpdateByUser": updateByUser == null ? null : updateByUser,
        "UpdateByRole": updateByRole == null ? null : updateByRole,
        "UpdateDate": updateDate == null ? null : updateDate.toIso8601String(),
        "IsClosed": isClosed == null ? null : isClosed,
        "CompanyId": companyId == null ? null : companyId,
        "Username": username == null ? null : username,
        "Role": role == null ? null : role,
        "Product": product == null ? null : product.toJson(),
        "RequestBy": requestBy,
      };
}

class Assignee {
  Assignee({
    this.id,
    this.requestId,
    this.companyId,
    this.role,
    this.username,
    this.action,
  });

  int id;
  int requestId;
  int companyId;
  dynamic role;
  String username;
  int action;

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
        id: json["ID"] == null ? null : json["ID"],
        requestId: json["RequestID"] == null ? null : json["RequestID"],
        companyId: json["CompanyID"] == null ? null : json["CompanyID"],
        role: json["Role"],
        username: json["Username"] == null ? null : json["Username"],
        action: json["Action"] == null ? null : json["Action"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "RequestID": requestId == null ? null : requestId,
        "CompanyID": companyId == null ? null : companyId,
        "Role": role,
        "Username": username == null ? null : username,
        "Action": action == null ? null : action,
      };
}

class Customer {
  Customer({
    this.id,
    this.userId,
    this.appId,
    this.companyId,
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
    this.mailingAddressTown,
    this.mailingAddressBlock,
    this.mailingAddressRoad,
    this.mailingAddressHouse,
    this.mailingAddressFlat,
    this.homeAddressTown,
    this.homeAddressBlock,
    this.homeAddressRoad,
    this.homeAddressHouse,
    this.homeAddressFlat,
    this.salary,
    this.relationshipType,
    this.iban,
    this.sourceOfIncome,
    this.bank,
    this.identityId,
    this.passportId,
    this.photo,
    this.maritalStatus,
    this.nationality,
    this.idType,
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
  });

  int id;
  String userId;
  String appId;
  int companyId;
  String firstName;
  dynamic middleName;
  String lastName;
  DateTime identityExpiryDate;
  DateTime licenceExpiryDate;
  DateTime dateOfBirth;
  String gender;
  dynamic department;
  dynamic position;
  String mobileNumber;
  dynamic otherContactNumber;
  dynamic address;
  dynamic mailingAddressTown;
  dynamic mailingAddressBlock;
  dynamic mailingAddressRoad;
  dynamic mailingAddressHouse;
  dynamic mailingAddressFlat;
  dynamic homeAddressTown;
  dynamic homeAddressBlock;
  dynamic homeAddressRoad;
  dynamic homeAddressHouse;
  dynamic homeAddressFlat;
  int salary;
  int relationshipType;
  dynamic iban;
  dynamic sourceOfIncome;
  dynamic bank;
  String identityId;
  dynamic passportId;
  dynamic photo;
  int maritalStatus;
  String nationality;
  int idType;
  dynamic personalEmail;
  dynamic corporateEmail;
  int primaryEmail;
  int status;
  dynamic documents;
  dynamic dependents;
  dynamic relationDescription;
  dynamic staffNumber;
  String name;
  dynamic email;
  bool subscribed;
  dynamic corporateEmailConfirmedAt;
  dynamic personalEmailConfirmedAt;
  dynamic mobileNumberConfirmedAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["ID"] == null ? null : json["ID"],
        userId: json["UserID"] == null ? null : json["UserID"],
        appId: json["AppID"] == null ? null : json["AppID"],
        companyId: json["CompanyID"] == null ? null : json["CompanyID"],
        firstName: json["FirstName"] == null ? null : json["FirstName"],
        middleName: json["MiddleName"],
        lastName: json["LastName"] == null ? null : json["LastName"],
        identityExpiryDate: json["IdentityExpiryDate"] == null
            ? null
            : DateTime.parse(json["IdentityExpiryDate"]),
        licenceExpiryDate: json["LicenceExpiryDate"] == null
            ? null
            : DateTime.parse(json["LicenceExpiryDate"]),
        dateOfBirth: json["DateOfBirth"] == null
            ? null
            : DateTime.parse(json["DateOfBirth"]),
        gender: json["Gender"] == null ? null : json["Gender"],
        department: json["Department"],
        position: json["Position"],
        mobileNumber:
            json["MobileNumber"] == null ? null : json["MobileNumber"],
        otherContactNumber: json["OtherContactNumber"],
        address: json["Address"],
        mailingAddressTown: json["MailingAddressTown"],
        mailingAddressBlock: json["MailingAddressBlock"],
        mailingAddressRoad: json["MailingAddressRoad"],
        mailingAddressHouse: json["MailingAddressHouse"],
        mailingAddressFlat: json["MailingAddressFlat"],
        homeAddressTown: json["HomeAddressTown"],
        homeAddressBlock: json["HomeAddressBlock"],
        homeAddressRoad: json["HomeAddressRoad"],
        homeAddressHouse: json["HomeAddressHouse"],
        homeAddressFlat: json["HomeAddressFlat"],
        salary: json["Salary"] == null ? null : json["Salary"],
        relationshipType:
            json["RelationshipType"] == null ? null : json["RelationshipType"],
        iban: json["IBAN"],
        sourceOfIncome: json["SourceOfIncome"],
        bank: json["Bank"],
        identityId: json["IdentityID"] == null ? null : json["IdentityID"],
        passportId: json["PassportID"],
        photo: json["Photo"],
        maritalStatus:
            json["MaritalStatus"] == null ? null : json["MaritalStatus"],
        nationality: json["Nationality"] == null ? null : json["Nationality"],
        idType: json["IDType"] == null ? null : json["IDType"],
        personalEmail: json["PersonalEmail"],
        corporateEmail: json["CorporateEmail"],
        primaryEmail:
            json["PrimaryEmail"] == null ? null : json["PrimaryEmail"],
        status: json["Status"] == null ? null : json["Status"],
        documents: json["Documents"],
        dependents: json["Dependents"],
        relationDescription: json["RelationDescription"],
        staffNumber: json["StaffNumber"],
        name: json["Name"] == null ? null : json["Name"],
        email: json["Email"],
        subscribed: json["Subscribed"] == null ? null : json["Subscribed"],
        corporateEmailConfirmedAt: json["CorporateEmailConfirmedAt"],
        personalEmailConfirmedAt: json["PersonalEmailConfirmedAt"],
        mobileNumberConfirmedAt: json["MobileNumberConfirmedAt"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "UserID": userId == null ? null : userId,
        "AppID": appId == null ? null : appId,
        "CompanyID": companyId == null ? null : companyId,
        "FirstName": firstName == null ? null : firstName,
        "MiddleName": middleName,
        "LastName": lastName == null ? null : lastName,
        "IdentityExpiryDate": identityExpiryDate == null
            ? null
            : identityExpiryDate.toIso8601String(),
        "LicenceExpiryDate": licenceExpiryDate == null
            ? null
            : licenceExpiryDate.toIso8601String(),
        "DateOfBirth":
            dateOfBirth == null ? null : dateOfBirth.toIso8601String(),
        "Gender": gender == null ? null : gender,
        "Department": department,
        "Position": position,
        "MobileNumber": mobileNumber == null ? null : mobileNumber,
        "OtherContactNumber": otherContactNumber,
        "Address": address,
        "MailingAddressTown": mailingAddressTown,
        "MailingAddressBlock": mailingAddressBlock,
        "MailingAddressRoad": mailingAddressRoad,
        "MailingAddressHouse": mailingAddressHouse,
        "MailingAddressFlat": mailingAddressFlat,
        "HomeAddressTown": homeAddressTown,
        "HomeAddressBlock": homeAddressBlock,
        "HomeAddressRoad": homeAddressRoad,
        "HomeAddressHouse": homeAddressHouse,
        "HomeAddressFlat": homeAddressFlat,
        "Salary": salary == null ? null : salary,
        "RelationshipType": relationshipType == null ? null : relationshipType,
        "IBAN": iban,
        "SourceOfIncome": sourceOfIncome,
        "Bank": bank,
        "IdentityID": identityId == null ? null : identityId,
        "PassportID": passportId,
        "Photo": photo,
        "MaritalStatus": maritalStatus == null ? null : maritalStatus,
        "Nationality": nationality == null ? null : nationality,
        "IDType": idType == null ? null : idType,
        "PersonalEmail": personalEmail,
        "CorporateEmail": corporateEmail,
        "PrimaryEmail": primaryEmail == null ? null : primaryEmail,
        "Status": status == null ? null : status,
        "Documents": documents,
        "Dependents": dependents,
        "RelationDescription": relationDescription,
        "StaffNumber": staffNumber,
        "Name": name == null ? null : name,
        "Email": email,
        "Subscribed": subscribed == null ? null : subscribed,
        "CorporateEmailConfirmedAt": corporateEmailConfirmedAt,
        "PersonalEmailConfirmedAt": personalEmailConfirmedAt,
        "MobileNumberConfirmedAt": mobileNumberConfirmedAt,
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

class History {
  History({
    this.id,
    this.requestId,
    this.status,
    this.actionId,
    this.note,
    this.referenceId,
    this.companyId,
    this.role,
    this.username,
    this.userId,
    this.date,
    this.approvedAmount,
  });

  int id;
  int requestId;
  int status;
  dynamic actionId;
  String note;
  String referenceId;
  int companyId;
  String role;
  String username;
  String userId;
  DateTime date;
  double approvedAmount;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["ID"] == null ? null : json["ID"],
        requestId: json["RequestID"] == null ? null : json["RequestID"],
        status: json["Status"] == null ? null : json["Status"],
        actionId: json["ActionID"],
        note: json["Note"] == null ? null : json["Note"],
        referenceId: json["ReferenceID"] == null ? null : json["ReferenceID"],
        companyId: json["CompanyId"] == null ? null : json["CompanyId"],
        role: json["Role"] == null ? null : json["Role"],
        username: json["Username"] == null ? null : json["Username"],
        userId: json["UserID"] == null ? null : json["UserID"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        approvedAmount:
            json["ApprovedAmount"] == null ? null : json["ApprovedAmount"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "RequestID": requestId == null ? null : requestId,
        "Status": status == null ? null : status,
        "ActionID": actionId,
        "Note": note == null ? null : note,
        "ReferenceID": referenceId == null ? null : referenceId,
        "CompanyId": companyId == null ? null : companyId,
        "Role": role == null ? null : role,
        "Username": username == null ? null : username,
        "UserID": userId == null ? null : userId,
        "Date": date == null ? null : date.toIso8601String(),
        "ApprovedAmount": approvedAmount == null ? null : approvedAmount,
      };
}

class Product {
  Product({
    this.claimantId,
    this.relation,
    this.dateOfBirth,
    this.idNumber,
    this.cardNumber,
    this.medicalProvider,
    this.country,
    this.companyNName,
    this.iban,
    this.dateOfClaim,
    this.notes,
    this.claimId,
    this.name,
    this.companyName,
  });

  dynamic claimantId;
  String relation;
  DateTime dateOfBirth;
  dynamic idNumber;
  int cardNumber;
  String medicalProvider;
  String country;
  String companyNName;
  String iban;
  String dateOfClaim;
  String notes;
  int claimId;
  String name;
  String companyName;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        claimantId: json["ClaimantID"],
        relation: json["Relation"] == null ? null : json["Relation"],
        dateOfBirth: json["DateOfBirth"] == null
            ? null
            : DateTime.parse(json["DateOfBirth"]),
        idNumber: json["IDNumber"],
        cardNumber: json["CardNumber"] == null ? null : json["CardNumber"],
        medicalProvider:
            json["MedicalProvider"] == null ? null : json["MedicalProvider"],
        country: json["Country"] == null ? null : json["Country"],
        companyNName:
            json["CompanyNName"] == null ? null : json["CompanyNName"],
        iban: json["IBAN"] == null ? null : json["IBAN"],
        dateOfClaim: json["DateOfClaim"] == null ? null : json["DateOfClaim"],
        notes: json["Notes"] == null ? null : json["Notes"],
        claimId: json["ClaimID"] == null ? null : json["ClaimID"],
        name: json["Name"] == null ? null : json["Name"],
        companyName: json["CompanyName"] == null ? null : json["CompanyName"],
      );

  Map<String, dynamic> toJson() => {
        "ClaimantID": claimantId,
        "Relation": relation == null ? null : relation,
        "DateOfBirth":
            dateOfBirth == null ? null : dateOfBirth.toIso8601String(),
        "IDNumber": idNumber,
        "CardNumber": cardNumber == null ? null : cardNumber,
        "MedicalProvider": medicalProvider == null ? null : medicalProvider,
        "Country": country == null ? null : country,
        "CompanyNName": companyNName == null ? null : companyNName,
        "IBAN": iban == null ? null : iban,
        "DateOfClaim": dateOfClaim == null ? null : dateOfClaim,
        "Notes": notes == null ? null : notes,
        "ClaimID": claimId == null ? null : claimId,
        "Name": name == null ? null : name,
        "CompanyName": companyName == null ? null : companyName,
      };
}
