import 'dart:convert';

BenifitResponse benifitResponseFromJson(String str) =>
    BenifitResponse.fromJson(json.decode(str));

String benifitResponseToJson(BenifitResponse data) =>
    json.encode(data.toJson());

class BenifitResponse {
  BenifitResponse({
    this.status,
    this.result,
    this.error,
    this.errorText,
    this.date,
    this.authRespCode,
    this.authCode,
    this.transId,
    this.trackId,
    this.udf5,
    this.udf6,
    this.udf10,
    this.amt,
    this.udf3,
    this.udf4,
    this.udf1,
    this.udf2,
    this.ref,
    this.udf9,
    this.paymentId,
    this.udf7,
    this.udf8,
    this.isFullPaid,
  });

  final String status;
  final String result;
  final dynamic error;
  final dynamic errorText;
  final dynamic date;
  final dynamic authRespCode;
  final dynamic authCode;
  final int transId;
  final dynamic trackId;
  final dynamic udf5;
  final dynamic udf6;
  final dynamic udf10;
  final dynamic amt;
  final dynamic udf3;
  final dynamic udf4;
  final dynamic udf1;
  final dynamic udf2;
  final dynamic ref;
  final dynamic udf9;
  final int paymentId;
  final dynamic udf7;
  final dynamic udf8;
  final bool isFullPaid;

  factory BenifitResponse.fromJson(Map<String, dynamic> json) =>
      BenifitResponse(
        status: json["status"] == null ? null : json["status"],
        result: json["result"] == null ? null : json["result"],
        error: json["error"],
        errorText: json["errorText"],
        date: json["date"],
        authRespCode: json["authRespCode"],
        authCode: json["authCode"],
        transId: json["transId"] == null ? null : json["transId"],
        trackId: json["trackId"],
        udf5: json["udf5"],
        udf6: json["udf6"],
        udf10: json["udf10"],
        amt: json["amt"],
        udf3: json["udf3"],
        udf4: json["udf4"],
        udf1: json["udf1"],
        udf2: json["udf2"],
        ref: json["ref"],
        udf9: json["udf9"],
        paymentId: json["paymentId"] == null ? null : json["paymentId"],
        udf7: json["udf7"],
        udf8: json["udf8"],
        isFullPaid: json["IsFullPaid"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "result": result == null ? null : result,
        "error": error,
        "errorText": errorText,
        "date": date,
        "authRespCode": authRespCode,
        "authCode": authCode,
        "transId": transId == null ? null : transId,
        "trackId": trackId,
        "udf5": udf5,
        "udf6": udf6,
        "udf10": udf10,
        "amt": amt,
        "udf3": udf3,
        "udf4": udf4,
        "udf1": udf1,
        "udf2": udf2,
        "ref": ref,
        "udf9": udf9,
        "paymentId": paymentId == null ? null : paymentId,
        "udf7": udf7,
        "udf8": udf8,
        "IsFullPaid": isFullPaid,
      };
}
