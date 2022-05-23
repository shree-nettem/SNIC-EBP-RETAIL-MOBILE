class VerificationModel {
  int iD;
  int currentStepId;
  String currentStepName;
  String benefitResponse;
  String jumioResponse;

  VerificationModel(
      {this.iD,
      this.currentStepId,
      this.currentStepName,
      this.benefitResponse,
      this.jumioResponse});

  VerificationModel.fromJson(Map<String, dynamic> json) {
    iD = json['Id'];
    currentStepId = json['CurrentStepId'];
    currentStepName = json['CurrentStepName'];
    benefitResponse = json['BenefitResponse'] ?? null;
    jumioResponse = json['JumioResponse'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CurrentStepId'] = this.currentStepId;
    data['CurrentStepName'] = this.currentStepName;
    data['BenefitResponse'] = this.benefitResponse;
    data['JumioResponse'] = this.jumioResponse;
    return data;
  }
}
