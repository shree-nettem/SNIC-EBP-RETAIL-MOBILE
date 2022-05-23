// To parse this JSON data, do
//
//     final pendingPayment = pendingPaymentFromJson(jsonString);

import 'dart:convert';

PendingPayment pendingPaymentFromJson(String str) =>
    PendingPayment.fromJson(json.decode(str));

String pendingPaymentToJson(PendingPayment data) => json.encode(data.toJson());

class PendingPayment {
  PendingPayment({
    this.id,
    this.customerId,
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
  final double amount;
  final dynamic discount;
  dynamic points;
  final String type;
  final String referenceId;
  final dynamic response;
  final dynamic responseId;
  final dynamic paymentMethod;
  final String status;
  final String description;
  final dynamic paidAt;
  final DateTime createdAt;

  factory PendingPayment.fromJson(Map<String, dynamic> json) => PendingPayment(
        id: json["ID"] == null ? null : json["ID"],
        customerId: json["CustomerId"] == null ? null : json["CustomerId"],
        amount: json["Amount"] == null ? null : json["Amount"],
        discount: json["Discount"],
        points: json["Points"],
        type: json["Type"] == null ? null : json["Type"],
        referenceId: json["ReferenceId"] == null ? null : json["ReferenceId"],
        response: json["Response"],
        responseId: json["ResponseId"],
        paymentMethod: json["PaymentMethod"],
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
        "Amount": amount == null ? null : amount,
        "Discount": discount,
        "Points": points,
        "Type": type == null ? null : type,
        "ReferenceId": referenceId == null ? null : referenceId,
        "Response": response,
        "ResponseId": responseId,
        "PaymentMethod": paymentMethod,
        "Status": status == null ? null : status,
        "Description": description == null ? null : description,
        "PaidAt": paidAt,
        "CreatedAt": createdAt == null ? null : createdAt.toIso8601String(),
      };
}
