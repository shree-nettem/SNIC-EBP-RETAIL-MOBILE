// To parse this JSON data, do
//
//     final contactDetails = contactDetailsFromJson(jsonString);

import 'dart:convert';

ContactDetails contactDetailsFromJson(String str) => ContactDetails.fromJson(json.decode(str));

String contactDetailsToJson(ContactDetails data) => json.encode(data.toJson());

class ContactDetails {
  ContactDetails({
    this.contactTel,
    this.whatsAppNumber,
    this.emailSupport,
    this.rsaLocal,
    this.medNetLocal,
    this.medNetInternational,
  });

  final String contactTel;
  final String whatsAppNumber;
  final String emailSupport;
  final String rsaLocal;
  final String medNetLocal;
  final String medNetInternational;

  factory ContactDetails.fromJson(Map<String, dynamic> json) => ContactDetails(
    contactTel: json["ContactTel"] == null ? null : json["ContactTel"],
    whatsAppNumber: json["WhatsAppNumber"] == null ? null : json["WhatsAppNumber"],
    emailSupport: json["EmailSupport"] == null ? null : json["EmailSupport"],
    rsaLocal: json["RSALocal"] == null ? null : json["RSALocal"],
    medNetLocal: json["MedNetLocal"] == null ? null : json["MedNetLocal"],
    medNetInternational: json["MedNetInternational"] == null ? null : json["MedNetInternational"],
  );

  Map<String, dynamic> toJson() => {
    "ContactTel": contactTel == null ? null : contactTel,
    "WhatsAppNumber": whatsAppNumber == null ? null : whatsAppNumber,
    "EmailSupport": emailSupport == null ? null : emailSupport,
    "RSALocal": rsaLocal == null ? null : rsaLocal,
    "MedNetLocal": medNetLocal == null ? null : medNetLocal,
    "MedNetInternational": medNetInternational == null ? null : medNetInternational,
  };
}
