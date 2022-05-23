class LoyaltyPointsDetailsModel {
  LoyaltyPointsDetailsResult loyaltyPointsDetailsResult;

  LoyaltyPointsDetailsModel({this.loyaltyPointsDetailsResult});

  LoyaltyPointsDetailsModel.fromJson(Map<String, dynamic> json) {
    loyaltyPointsDetailsResult = json['result'] != null
        ? new LoyaltyPointsDetailsResult.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loyaltyPointsDetailsResult != null) {
      data['result'] = this.loyaltyPointsDetailsResult.toJson();
    }
    return data;
  }
}

class LoyaltyPointsDetailsResult {
  String contactId;
  String tier;
  num outstandingPoints = 0;
  num eligibleAmount;
  num rewardPoint;

  LoyaltyPointsDetailsResult(
      {this.contactId,
      this.tier,
      this.outstandingPoints,
      this.eligibleAmount,
      this.rewardPoint});

  LoyaltyPointsDetailsResult.fromJson(Map<String, dynamic> json) {
    contactId = json['ContactId'] ?? "";
    tier = json['Tier'] ?? "";
    outstandingPoints = json['OutstandingPoints'] ?? 0;
    eligibleAmount = json['EligibleAmount'];
    rewardPoint = json['RewardPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ContactId'] = this.contactId;
    data['Tier'] = this.tier;
    data['OutstandingPoints'] = this.outstandingPoints;
    data['EligibleAmount'] = this.eligibleAmount;
    data['RewardPoint'] = this.rewardPoint;
    return data;
  }
}
