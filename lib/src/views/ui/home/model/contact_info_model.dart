class ContactInfoModel {
  ContactInfoModel({
    this.contactTel,
    this.whatsAppNumber,
    this.emailSupport,
    this.rsaLocal,
    this.medNetLocal,
    this.medNetInternational,
  });

  String contactTel;
  String whatsAppNumber;
  String emailSupport;
  String rsaLocal;
  String medNetLocal;
  String medNetInternational;

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) =>
      ContactInfoModel(
        contactTel: json["ContactTel"] == null ? null : json["ContactTel"],
        whatsAppNumber:
            json["WhatsAppNumber"] == null ? null : json["WhatsAppNumber"],
        emailSupport:
            json["EmailSupport"] == null ? null : json["EmailSupport"],
        rsaLocal: json["RSALocal"] == null ? null : json["RSALocal"],
        medNetLocal: json["MedNetLocal"] == null ? null : json["MedNetLocal"],
        medNetInternational: json["MedNetInternational"] == null
            ? null
            : json["MedNetInternational"],
      );

  Map<String, dynamic> toJson() => {
        "ContactTel": contactTel == null ? null : contactTel,
        "WhatsAppNumber": whatsAppNumber == null ? null : whatsAppNumber,
        "EmailSupport": emailSupport == null ? null : emailSupport,
        "RSALocal": rsaLocal == null ? null : rsaLocal,
        "MedNetLocal": medNetLocal == null ? null : medNetLocal,
        "MedNetInternational":
            medNetInternational == null ? null : medNetInternational,
      };
}
