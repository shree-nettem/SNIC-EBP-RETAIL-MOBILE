// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) => VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  VehicleModel({
    this.vehicleModel,
    this.errorCode,
  });

  final List<VehicleModelElement> vehicleModel;
  final int errorCode;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    vehicleModel: json["vehicleModel"] == null ? null : List<VehicleModelElement>.from(json["vehicleModel"].map((x) => VehicleModelElement.fromJson(x))),
    errorCode: json["errorCode"] == null ? null : json["errorCode"],
  );

  Map<String, dynamic> toJson() => {
    "vehicleModel": vehicleModel == null ? null : List<dynamic>.from(vehicleModel.map((x) => x.toJson())),
    "errorCode": errorCode == null ? null : errorCode,
  };
}

class VehicleModelElement {
  VehicleModelElement({
    this.makeCode,
    this.make,
    this.modelDetails,
  });

  final String makeCode;
  final String make;
  final List<ModelDetail> modelDetails;

  factory VehicleModelElement.fromJson(Map<String, dynamic> json) => VehicleModelElement(
    makeCode: json["makeCode"] == null ? null : json["makeCode"],
    make: json["make"] == null ? null : json["make"],
    modelDetails: json["modelDetails"] == null ? null : List<ModelDetail>.from(json["modelDetails"].map((x) => ModelDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "makeCode": makeCode == null ? null : makeCode,
    "make": make == null ? null : make,
    "modelDetails": modelDetails == null ? null : List<dynamic>.from(modelDetails.map((x) => x.toJson())),
  };
}

class ModelDetail {
  ModelDetail({
    this.uniqueId,
    this.retailPrice,
    this.tradeInPrice,
    this.model,
    this.modelCode,
    this.modelYear,
    this.modelYearCode,
    this.make,
    this.makeCode,
    this.typeSpec,
    this.typeSpecCode,
    this.engineSize,
    this.numberofCylender,
    this.transmission,
    this.doors,
    this.seats,
    this.gears,
    this.bodyType,
    this.fuel,
    this.hp,
    this.finalDrive,
    this.recordDate,
    this.expiryDate,
    this.createdBy,
    this.currency,
    this.country,
  });

  final String uniqueId;
  final String retailPrice;
  final String tradeInPrice;
  final String model;
  final String modelCode;
  final String modelYear;
  final String modelYearCode;
  final String make;
  final String makeCode;
  final String typeSpec;
  final String typeSpecCode;
  final String engineSize;
  final String numberofCylender;
  final String transmission;
  final String doors;
  final String seats;
  final String gears;
  final String bodyType;
  final String fuel;
  final String hp;
  final String finalDrive;
  final String recordDate;
  final String expiryDate;
  final String createdBy;
  final String currency;
  final String country;

  factory ModelDetail.fromJson(Map<String, dynamic> json) => ModelDetail(
    uniqueId: json["uniqueId"] == null ? null : json["uniqueId"],
    retailPrice: json["retailPrice"] == null ? null : json["retailPrice"],
    tradeInPrice: json["tradeInPrice"] == null ? null : json["tradeInPrice"],
    model: json["model"] == null ? null : json["model"],
    modelCode: json["modelCode"] == null ? null : json["modelCode"],
    modelYear: json["modelYear"] == null ? null : json["modelYear"],
    modelYearCode: json["modelYearCode"] == null ? null : json["modelYearCode"],
    make: json["make"] == null ? null : json["make"],
    makeCode: json["makeCode"] == null ? null : json["makeCode"],
    typeSpec: json["typeSpec"] == null ? null : json["typeSpec"],
    typeSpecCode: json["typeSpecCode"] == null ? null : json["typeSpecCode"],
    engineSize: json["engineSize"] == null ? null : json["engineSize"],
    numberofCylender: json["numberofCylender"] == null ? null : json["numberofCylender"],
    transmission: json["transmission"] == null ? null : json["transmission"],
    doors: json["doors"] == null ? null : json["doors"],
    seats: json["seats"] == null ? null : json["seats"],
    gears: json["gears"] == null ? null : json["gears"],
    bodyType: json["bodyType"] == null ? null : json["bodyType"],
    fuel: json["fuel"] == null ? null : json["fuel"],
    hp: json["hp"] == null ? null : json["hp"],
    finalDrive: json["finalDrive"] == null ? null : json["finalDrive"],
    recordDate: json["recordDate"] == null ? null : json["recordDate"],
    expiryDate: json["expiryDate"] == null ? null : json["expiryDate"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    currency: json["currency"] == null ? null : json["currency"],
    country: json["country"] == null ? null : json["country"],
  );

  Map<String, dynamic> toJson() => {
    "uniqueId": uniqueId == null ? null : uniqueId,
    "retailPrice": retailPrice == null ? null : retailPrice,
    "tradeInPrice": tradeInPrice == null ? null : tradeInPrice,
    "model": model == null ? null : model,
    "modelCode": modelCode == null ? null : modelCode,
    "modelYear": modelYear == null ? null : modelYear,
    "modelYearCode": modelYearCode == null ? null : modelYearCode,
    "make": make == null ? null : make,
    "makeCode": makeCode == null ? null : makeCode,
    "typeSpec": typeSpec == null ? null : typeSpec,
    "typeSpecCode": typeSpecCode == null ? null : typeSpecCode,
    "engineSize": engineSize == null ? null : engineSize,
    "numberofCylender": numberofCylender == null ? null : numberofCylender,
    "transmission": transmission == null ? null : transmission,
    "doors": doors == null ? null : doors,
    "seats": seats == null ? null : seats,
    "gears": gears == null ? null : gears,
    "bodyType": bodyType == null ? null : bodyType,
    "fuel": fuel == null ? null : fuel,
    "hp": hp == null ? null : hp,
    "finalDrive": finalDrive == null ? null : finalDrive,
    "recordDate": recordDate == null ? null : recordDate,
    "expiryDate": expiryDate == null ? null : expiryDate,
    "createdBy": createdBy == null ? null : createdBy,
    "currency": currency == null ? null : currency,
    "country": country == null ? null : country,
  };
}
