class LifeBenificiaries {
  LifeBenificiaries({
    this.beneficiaryId,
    this.customerId,
    this.companyId,
    this.beneficiaryName,
    this.beneficiaryDateOfBirth,
    this.beneficiaryMobile,
    this.beneficiaryAddress,
    this.beneficiaryPercentage,
    this.guardianName,
    this.guardianIdNo,
    this.guardianRelation,
    this.guardianDateOfBirth,
    this.guardianAddress,
    this.guardianMobile,
    this.guardianGender,
    this.guardianNationality,
    this.beneficiaryIdNo,
    this.beneficiaryRelation,
    this.guardianEmail,
    this.beneficiaryMobileCountryCode,
    this.guardianMobileCountryCode,
  });

  int beneficiaryId;
  int customerId;
  int companyId;
  String beneficiaryName;
  DateTime beneficiaryDateOfBirth;
  String beneficiaryMobile;
  String beneficiaryAddress;
  double beneficiaryPercentage;
  dynamic guardianName;
  dynamic guardianIdNo;
  dynamic guardianRelation;
  DateTime guardianDateOfBirth;
  dynamic guardianAddress;
  dynamic guardianMobile;
  dynamic guardianGender;
  dynamic guardianNationality;
  String beneficiaryIdNo;
  String beneficiaryRelation;
  dynamic guardianEmail;
  dynamic beneficiaryMobileCountryCode;
  dynamic guardianMobileCountryCode;

  factory LifeBenificiaries.fromJson(Map<String, dynamic> json) =>
      LifeBenificiaries(
        beneficiaryId:
            json["BeneficiaryID"] == null ? null : json["BeneficiaryID"],
        customerId: json["CustomerID"] == null ? null : json["CustomerID"],
        companyId: json["CompanyID"] == null ? null : json["CompanyID"],
        beneficiaryName:
            json["BeneficiaryName"] == null ? null : json["BeneficiaryName"],
        beneficiaryDateOfBirth: json["BeneficiaryDateOfBirth"] == null
            ? null
            : DateTime.parse(json["BeneficiaryDateOfBirth"]),
        beneficiaryMobile: json["BeneficiaryMobile"] == null
            ? null
            : json["BeneficiaryMobile"],
        beneficiaryAddress: json["BeneficiaryAddress"] == null
            ? null
            : json["BeneficiaryAddress"],
        beneficiaryPercentage: json["BeneficiaryPercentage"] == null
            ? null
            : json["BeneficiaryPercentage"],
        guardianName: json["GuardianName"],
        guardianIdNo: json["GuardianIDNo"],
        guardianRelation: json["GuardianRelation"],
        guardianDateOfBirth: json["GuardianDateOfBirth"] == null
            ? null
            : DateTime.parse(
                json["GuardianDateOfBirth"],
              ),
        guardianAddress: json["GuardianAddress"],
        guardianMobile: json["GuardianMobile"],
        guardianGender: json["GuardianGender"],
        guardianNationality: json["GuardianNationality"],
        beneficiaryIdNo:
            json["BeneficiaryIDNo"] == null ? null : json["BeneficiaryIDNo"],
        beneficiaryRelation: json["BeneficiaryRelation"] == null
            ? null
            : json["BeneficiaryRelation"],
        guardianEmail: json["GuardianEmail"],
        beneficiaryMobileCountryCode: json["BeneficiaryMobileCountryCode"],
        guardianMobileCountryCode: json["GuardianMobileCountryCode"],
      );

  Map<String, dynamic> toJson() => {
        "BeneficiaryID": beneficiaryId == null ? null : beneficiaryId,
        "CustomerID": customerId == null ? null : customerId,
        "CompanyID": companyId == null ? null : companyId,
        "BeneficiaryName": beneficiaryName == null ? null : beneficiaryName,
        "BeneficiaryDateOfBirth": beneficiaryDateOfBirth == null
            ? null
            : beneficiaryDateOfBirth.toIso8601String(),
        "BeneficiaryMobile":
            beneficiaryMobile == null ? null : beneficiaryMobile,
        "BeneficiaryAddress":
            beneficiaryAddress == null ? null : beneficiaryAddress,
        "BeneficiaryPercentage":
            beneficiaryPercentage == null ? null : beneficiaryPercentage,
        "GuardianName": guardianName,
        "GuardianIDNo": guardianIdNo,
        "GuardianRelation": guardianRelation,
        "GuardianDateOfBirth": guardianDateOfBirth == null
            ? null
            : guardianDateOfBirth.toIso8601String(),
        "GuardianAddress": guardianAddress,
        "GuardianMobile": guardianMobile,
        "GuardianGender": guardianGender,
        "GuardianNationality": guardianNationality,
        "BeneficiaryIDNo": beneficiaryIdNo == null ? null : beneficiaryIdNo,
        "BeneficiaryRelation":
            beneficiaryRelation == null ? null : beneficiaryRelation,
        "GuardianEmail": guardianEmail,
        "BeneficiaryMobileCountryCode": beneficiaryMobileCountryCode,
        "GuardianMobileCountryCode": guardianMobileCountryCode,
      };
}
