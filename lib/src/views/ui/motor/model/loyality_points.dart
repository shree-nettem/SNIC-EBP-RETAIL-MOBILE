// To parse this JSON data, do
//
//     final loyalityPoints = loyalityPointsFromJson(jsonString);

import 'dart:convert';

LoyalityPoints loyalityPointsFromJson(String str) => LoyalityPoints.fromJson(json.decode(str));

String loyalityPointsToJson(LoyalityPoints data) => json.encode(data.toJson());

class LoyalityPoints {
  LoyalityPoints({
    this.result,
  });

  final Result result;

  factory LoyalityPoints.fromJson(Map<String, dynamic> json) => LoyalityPoints(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result.toJson(),
  };
}

class Result {
  Result({
    this.contactId,
    this.tier,
    this.outstandingPoints,
    this.eligibleAmount,
    this.rewardPoint,
  });

  final String contactId;
  final String tier;
  final double outstandingPoints;
  final double eligibleAmount;
  final double rewardPoint;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    contactId: json["ContactId"] == null ? null : json["ContactId"],
    tier: json["Tier"] == null ? null : json["Tier"],
    outstandingPoints: json["OutstandingPoints"] == null ? null : json["OutstandingPoints"],
    eligibleAmount: json["EligibleAmount"] == null ? null : json["EligibleAmount"],
    rewardPoint: json["RewardPoint"] == null ? null : json["RewardPoint"],
  );

  Map<String, dynamic> toJson() => {
    "ContactId": contactId == null ? null : contactId,
    "Tier": tier == null ? null : tier,
    "OutstandingPoints": outstandingPoints == null ? null : outstandingPoints,
    "EligibleAmount": eligibleAmount == null ? null : eligibleAmount,
    "RewardPoint": rewardPoint == null ? null : rewardPoint,
  };
}
