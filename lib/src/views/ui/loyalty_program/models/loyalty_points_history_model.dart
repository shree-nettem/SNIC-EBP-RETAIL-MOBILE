import 'package:ebpv2/src/utilities/utils.dart';

class LoyaltyPointsHistoryModel {
  List<LoyaltyPointsHistoryResult> loyaltyPointsHistoryResult;

  LoyaltyPointsHistoryModel({this.loyaltyPointsHistoryResult});

  LoyaltyPointsHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      loyaltyPointsHistoryResult = <LoyaltyPointsHistoryResult>[];
      json['result'].forEach((v) {
        loyaltyPointsHistoryResult
            .add(new LoyaltyPointsHistoryResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loyaltyPointsHistoryResult != null) {
      data['result'] =
          this.loyaltyPointsHistoryResult.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoyaltyPointsHistoryResult {
  String customerLoyaltyTransactionId;
  num value;
  String transactionType;
  String date;
  String activity;

  LoyaltyPointsHistoryResult(
      {this.customerLoyaltyTransactionId,
      this.value,
      this.transactionType,
      this.date,
      this.activity});

  LoyaltyPointsHistoryResult.fromJson(Map<String, dynamic> json) {
    customerLoyaltyTransactionId = json['CustomerLoyaltyTransactionId'] ?? "";
    value = json['Value'];
    transactionType = json['TransactionType'] ?? "";
    date = json['Date'] != null ? Utils.getOnlyDate(json['Date']) : null;
    activity = json['Activity'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerLoyaltyTransactionId'] = this.customerLoyaltyTransactionId;
    data['Value'] = this.value;
    data['TransactionType'] = this.transactionType;
    data['Date'] = this.date;
    data['Activity'] = this.activity;
    return data;
  }
}
