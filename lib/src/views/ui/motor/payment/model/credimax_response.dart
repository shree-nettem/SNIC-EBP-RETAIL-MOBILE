// To parse this JSON data, do
//
//     final crediMaxResponse = crediMaxResponseFromJson(jsonString);

import 'dart:convert';

CrediMaxResponse crediMaxResponseFromJson(String str) =>
    CrediMaxResponse.fromJson(json.decode(str));

String crediMaxResponseToJson(CrediMaxResponse data) =>
    json.encode(data.toJson());

class CrediMaxResponse {
  CrediMaxResponse(
      {this.result,
      this.paymentTransaction,
      this.isFullPaid,
      this.paymentLink});

  final Result result;
  final PaymentTransaction paymentTransaction;
  final bool isFullPaid;
  final String paymentLink;

  factory CrediMaxResponse.fromJson(Map<String, dynamic> json) =>
      CrediMaxResponse(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        paymentTransaction: json["PaymentTransaction"] == null
            ? null
            : PaymentTransaction.fromJson(json["PaymentTransaction"]),
        isFullPaid: json["IsFullPaid"],
        paymentLink: json["PaymentLink"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result.toJson(),
        "PaymentTransaction":
            paymentTransaction == null ? null : paymentTransaction.toJson(),
        "IsFullPaid": isFullPaid,
        "PaymentLink": paymentLink
      };
}

class PaymentTransaction {
  PaymentTransaction({
    this.id,
    this.customerId,
    this.customer,
    this.amount,
    this.discount,
    this.points,
    this.type,
    this.referenceId,
    this.response,
    this.responseId,
    this.paymentMethod,
    this.status,
    this.description,
    this.paidAt,
    this.createdAt,
  });

  final int id;
  final int customerId;
  final dynamic customer;
  final double amount;
  final dynamic discount;
  final double points;
  final String type;
  final String referenceId;
  final dynamic response;
  final dynamic responseId;
  final String paymentMethod;
  final String status;
  final String description;
  final dynamic paidAt;
  final DateTime createdAt;

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      PaymentTransaction(
        id: json["ID"] == null ? null : json["ID"],
        customerId: json["CustomerId"] == null ? null : json["CustomerId"],
        customer: json["Customer"],
        amount: json["Amount"] == null ? null : json["Amount"],
        discount: json["Discount"],
        points: json["Points"] == null ? null : json["Points"],
        type: json["Type"] == null ? null : json["Type"],
        referenceId: json["ReferenceId"] == null ? null : json["ReferenceId"],
        response: json["Response"],
        responseId: json["ResponseId"],
        paymentMethod:
            json["PaymentMethod"] == null ? null : json["PaymentMethod"],
        status: json["Status"] == null ? null : json["Status"],
        description: json["Description"] == null ? null : json["Description"],
        paidAt: json["PaidAt"],
        createdAt: json["CreatedAt"] == null
            ? null
            : DateTime.parse(json["CreatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "CustomerId": customerId == null ? null : customerId,
        "Customer": customer,
        "Amount": amount == null ? null : amount,
        "Discount": discount,
        "Points": points == null ? null : points,
        "Type": type == null ? null : type,
        "ReferenceId": referenceId == null ? null : referenceId,
        "Response": response,
        "ResponseId": responseId,
        "PaymentMethod": paymentMethod == null ? null : paymentMethod,
        "Status": status == null ? null : status,
        "Description": description == null ? null : description,
        "PaidAt": paidAt,
        "CreatedAt": createdAt == null ? null : createdAt.toIso8601String(),
      };
}

class Result {
  Result({
    this.merchant,
    this.result,
    this.session,
    this.successIndicator,
    this.trackId,
  });

  final String merchant;
  final String result;
  final Session session;
  final String successIndicator;
  final String trackId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        merchant: json["merchant"] == null ? null : json["merchant"],
        result: json["result"] == null ? null : json["result"],
        session:
            json["session"] == null ? null : Session.fromJson(json["session"]),
        successIndicator:
            json["successIndicator"] == null ? null : json["successIndicator"],
        trackId: json["TrackId"] == null ? null : json["TrackId"],
      );

  Map<String, dynamic> toJson() => {
        "merchant": merchant == null ? null : merchant,
        "result": result == null ? null : result,
        "session": session == null ? null : session.toJson(),
        "successIndicator": successIndicator == null ? null : successIndicator,
        "TrackId": trackId == null ? null : trackId,
      };
}

class Session {
  Session({
    this.id,
    this.updateStatus,
    this.version,
  });

  final String id;
  final String updateStatus;
  final String version;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"] == null ? null : json["id"],
        updateStatus:
            json["updateStatus"] == null ? null : json["updateStatus"],
        version: json["version"] == null ? null : json["version"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "updateStatus": updateStatus == null ? null : updateStatus,
        "version": version == null ? null : version,
      };
}
