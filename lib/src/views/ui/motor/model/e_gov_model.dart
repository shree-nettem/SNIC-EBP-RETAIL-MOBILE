// To parse this JSON data, do
//
//     final eGovResponse = eGovResponseFromJson(jsonString);

import 'dart:convert';

EGovResponse eGovResponseFromJson(String str) => EGovResponse.fromJson(json.decode(str));

String eGovResponseToJson(EGovResponse data) => json.encode(data.toJson());

class EGovResponse {
  EGovResponse({
    this.soapenvEnvelope,
  });

  final SoapenvEnvelope soapenvEnvelope;

  factory EGovResponse.fromJson(Map<String, dynamic> json) => EGovResponse(
    soapenvEnvelope: json["soapenv\u0024Envelope"] == null ? null : SoapenvEnvelope.fromJson(json["soapenv\u0024Envelope"]),
  );

  Map<String, dynamic> toJson() => {
    "soapenv\u0024Envelope": soapenvEnvelope == null ? null : soapenvEnvelope.toJson(),
  };
}

class SoapenvEnvelope {
  SoapenvEnvelope({
    this.xmlns,
    this.xmlnsSoapenv,
    this.xmlnsXsd,
    this.xmlnsXsi,
    this.soapenvBody,
  });

  final List<Xmln> xmlns;
  final String xmlnsSoapenv;
  final String xmlnsXsd;
  final String xmlnsXsi;
  final SoapenvBody soapenvBody;

  factory SoapenvEnvelope.fromJson(Map<String, dynamic> json) => SoapenvEnvelope(
    xmlns: json["xmlns"] == null ? null : List<Xmln>.from(json["xmlns"].map((x) => Xmln.fromJson(x))),
    xmlnsSoapenv: json["xmlns\u0024soapenv"] == null ? null : json["xmlns\u0024soapenv"],
    xmlnsXsd: json["xmlns\u0024xsd"] == null ? null : json["xmlns\u0024xsd"],
    xmlnsXsi: json["xmlns\u0024xsi"] == null ? null : json["xmlns\u0024xsi"],
    soapenvBody: json["soapenv\u0024Body"] == null ? null : SoapenvBody.fromJson(json["soapenv\u0024Body"]),
  );

  Map<String, dynamic> toJson() => {
    "xmlns": xmlns == null ? null : List<dynamic>.from(xmlns.map((x) => x.toJson())),
    "xmlns\u0024soapenv": xmlnsSoapenv == null ? null : xmlnsSoapenv,
    "xmlns\u0024xsd": xmlnsXsd == null ? null : xmlnsXsd,
    "xmlns\u0024xsi": xmlnsXsi == null ? null : xmlnsXsi,
    "soapenv\u0024Body": soapenvBody == null ? null : soapenvBody.toJson(),
  };
}

class SoapenvBody {
  SoapenvBody({
    this.retrieveInsurancePolicyResponse,
  });

  final RetrieveInsurancePolicyResponse retrieveInsurancePolicyResponse;

  factory SoapenvBody.fromJson(Map<String, dynamic> json) => SoapenvBody(
    retrieveInsurancePolicyResponse: json["retrieveInsurancePolicyResponse"] == null ? null : RetrieveInsurancePolicyResponse.fromJson(json["retrieveInsurancePolicyResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "retrieveInsurancePolicyResponse": retrieveInsurancePolicyResponse == null ? null : retrieveInsurancePolicyResponse.toJson(),
  };
}

class RetrieveInsurancePolicyResponse {
  RetrieveInsurancePolicyResponse({
    this.xmlns,
    this.retrieveInsurancePolicyReturn,
  });

  final String xmlns;
  final RetrieveInsurancePolicyReturn retrieveInsurancePolicyReturn;

  factory RetrieveInsurancePolicyResponse.fromJson(Map<String, dynamic> json) => RetrieveInsurancePolicyResponse(
    xmlns: json["xmlns"] == null ? null : json["xmlns"],
    retrieveInsurancePolicyReturn: json["retrieveInsurancePolicyReturn"] == null ? null : RetrieveInsurancePolicyReturn.fromJson(json["retrieveInsurancePolicyReturn"]),
  );

  Map<String, dynamic> toJson() => {
    "xmlns": xmlns == null ? null : xmlns,
    "retrieveInsurancePolicyReturn": retrieveInsurancePolicyReturn == null ? null : retrieveInsurancePolicyReturn.toJson(),
  };
}

class RetrieveInsurancePolicyReturn {
  RetrieveInsurancePolicyReturn({
    this.xmlns,
    this.ownerNumber,
    this.insuranceDate,
    this.insuranceDueDate,
    this.statusCode,
    this.statusMessage,
  });

  final String xmlns;
  final OwnerNumber ownerNumber;
  final OwnerNumber insuranceDate;
  final OwnerNumber insuranceDueDate;
  final OwnerNumber statusCode;
  final OwnerNumber statusMessage;

  factory RetrieveInsurancePolicyReturn.fromJson(Map<String, dynamic> json) => RetrieveInsurancePolicyReturn(
    xmlns: json["xmlns"] == null ? null : json["xmlns"],
    ownerNumber: json["OwnerNumber"] == null ? null : OwnerNumber.fromJson(json["OwnerNumber"]),
    insuranceDate: json["insuranceDate"] == null ? null : OwnerNumber.fromJson(json["insuranceDate"]),
    insuranceDueDate: json["insuranceDueDate"] == null ? null : OwnerNumber.fromJson(json["insuranceDueDate"]),
    statusCode: json["statusCode"] == null ? null : OwnerNumber.fromJson(json["statusCode"]),
    statusMessage: json["statusMessage"] == null ? null : OwnerNumber.fromJson(json["statusMessage"]),
  );

  Map<String, dynamic> toJson() => {
    "xmlns": xmlns == null ? null : xmlns,
    "OwnerNumber": ownerNumber == null ? null : ownerNumber.toJson(),
    "insuranceDate": insuranceDate == null ? null : insuranceDate.toJson(),
    "insuranceDueDate": insuranceDueDate == null ? null : insuranceDueDate.toJson(),
    "statusCode": statusCode == null ? null : statusCode.toJson(),
    "statusMessage": statusMessage == null ? null : statusMessage.toJson(),
  };
}

class OwnerNumber {
  OwnerNumber({
    this.t,
  });

  final String t;

  factory OwnerNumber.fromJson(Map<String, dynamic> json) => OwnerNumber(
    t: json["\u0024t"] == null ? null : json["\u0024t"],
  );

  Map<String, dynamic> toJson() => {
    "\u0024t": t == null ? null : t,
  };
}

class Xmln {
  Xmln();

  factory Xmln.fromJson(Map<String, dynamic> json) => Xmln(
  );

  Map<String, dynamic> toJson() => {
  };
}
