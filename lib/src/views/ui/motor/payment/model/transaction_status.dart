// To parse this JSON data, do
//
//     final transactionStatusResponse = transactionStatusResponseFromJson(jsonString);

import 'dart:convert';

TransactionStatusResponse transactionStatusResponseFromJson(String str) => TransactionStatusResponse.fromJson(json.decode(str));

String transactionStatusResponseToJson(TransactionStatusResponse data) => json.encode(data.toJson());

class TransactionStatusResponse {
  TransactionStatusResponse({
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
  final String response;
  final String responseId;
  final String paymentMethod;
  final String status;
  final String description;
  final DateTime paidAt;
  final DateTime createdAt;

  factory TransactionStatusResponse.fromJson(Map<String, dynamic> json) => TransactionStatusResponse(
    id: json["ID"] == null ? null : json["ID"],
    customerId: json["CustomerId"] == null ? null : json["CustomerId"],
    customer: json["Customer"],
    amount: json["Amount"] == null ? null : json["Amount"],
    discount: json["Discount"],
    points: json["Points"] == null ? null : json["Points"],
    type: json["Type"] == null ? null : json["Type"],
    referenceId: json["ReferenceId"] == null ? null : json["ReferenceId"],
    response: json["Response"] == null ? null : json["Response"],
    responseId: json["ResponseId"] == null ? null : json["ResponseId"],
    paymentMethod: json["PaymentMethod"] == null ? null : json["PaymentMethod"],
    status: json["Status"] == null ? null : json["Status"],
    description: json["Description"] == null ? null : json["Description"],
    paidAt: json["PaidAt"] == null ? null : DateTime.parse(json["PaidAt"]),
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
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
    "Response": response == null ? null : response,
    "ResponseId": responseId == null ? null : responseId,
    "PaymentMethod": paymentMethod == null ? null : paymentMethod,
    "Status": status == null ? null : status,
    "Description": description == null ? null : description,
    "PaidAt": paidAt == null ? null : paidAt.toIso8601String(),
    "CreatedAt": createdAt == null ? null : createdAt.toIso8601String(),
  };
}
