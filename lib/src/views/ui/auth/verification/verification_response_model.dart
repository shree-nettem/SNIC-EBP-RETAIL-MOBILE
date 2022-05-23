class VerificationResponseModel {
  int id;
  int currentStepId;
  String currentStepName;
  String benefitResponse;
  String jumioResponse;
  String jumioAMLResponse;
  bool existingCustomer;

  VerificationResponseModel(
      {this.id,
      this.currentStepId,
      this.currentStepName,
      this.benefitResponse,
      this.jumioResponse,
      this.jumioAMLResponse,
      this.existingCustomer});

  VerificationResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    currentStepId = json['CurrentStepId'];
    currentStepName = json['CurrentStepName'];
    benefitResponse = json['BenefitResponse'];
    jumioResponse = json['JumioResponse'];
    jumioAMLResponse = json['JumioAmlResponse'] ?? null;
    existingCustomer = json['ExistingCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CurrentStepId'] = this.currentStepId;
    data['CurrentStepName'] = this.currentStepName;
    data['BenefitResponse'] = this.benefitResponse;
    data['JumioResponse'] = this.jumioResponse;
    data['JumioAmlResponse'] = this.jumioAMLResponse;
    data['ExistingCustomer'] = this.existingCustomer;
    return data;
  }
}
