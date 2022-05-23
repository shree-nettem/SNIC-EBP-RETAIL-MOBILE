// To parse this JSON data, do
//
//     final customerMedicalNetwork = customerMedicalNetworkFromJson(jsonString);

import 'dart:convert';

CustomerMedicalNetwork customerMedicalNetworkFromJson(String str) =>
    CustomerMedicalNetwork.fromJson(json.decode(str));

String customerMedicalNetworkToJson(CustomerMedicalNetwork data) =>
    json.encode(data.toJson());

class CustomerMedicalNetwork {
  CustomerMedicalNetwork({
    this.network,
    this.contactSupport,
    this.provider,
  });

  Network network;
  ContactSupport contactSupport;
  List<MedicalProvider> provider;

  factory CustomerMedicalNetwork.fromJson(Map<String, dynamic> json) =>
      CustomerMedicalNetwork(
        network:
            json["Network"] == null ? null : networkValues.map[json["Network"]],
        contactSupport: json["ContactSupport"] == null
            ? null
            : ContactSupport.fromJson(json["ContactSupport"]),
        provider: json["Provider"] == null
            ? null
            : List<MedicalProvider>.from(
                json["Provider"].map((x) => MedicalProvider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Network": network == null ? null : networkValues.reverse[network],
        "ContactSupport":
            contactSupport == null ? null : contactSupport.toJson(),
        "Provider": provider == null
            ? null
            : List<dynamic>.from(provider.map((x) => x.toJson())),
      };
}

class ContactSupport {
  ContactSupport({
    this.local,
    this.international,
  });

  String local;
  String international;

  factory ContactSupport.fromJson(Map<String, dynamic> json) => ContactSupport(
        local: json["Local"] == null ? null : json["Local"],
        international:
            json["International"] == null ? null : json["International"],
      );

  Map<String, dynamic> toJson() => {
        "Local": local == null ? null : local,
        "International": international == null ? null : international,
      };
}

enum Network { PREMIUM_PLUS }

final networkValues = EnumValues({"Premium Plus": Network.PREMIUM_PLUS});

class MedicalProvider {
  MedicalProvider({
    this.providerName,
    this.providerId,
    this.latitude,
    this.longitude,
    this.cityDescription,
    this.countryDescription,
    this.specialityDescription,
    this.phoneNumber1,
    this.providerTypeDescription,
    this.branchId,
    this.branches,
  });

  String providerName;
  String providerId;
  String latitude;
  String longitude;
  String cityDescription;
  String countryDescription;
  String specialityDescription;
  String phoneNumber1;
  String providerTypeDescription;
  dynamic branchId;
  List<Branch> branches;

  factory MedicalProvider.fromJson(Map<String, dynamic> json) =>
      MedicalProvider(
        providerName:
            json["PROVIDER_NAME"] == null ? null : json["PROVIDER_NAME"],
        providerId: json["PROVIDER_ID"] == null ? null : json["PROVIDER_ID"],
        latitude: json["LATITUDE"] == null ? null : json["LATITUDE"],
        longitude: json["LONGITUDE"] == null ? null : json["LONGITUDE"],
        cityDescription:
            json["CITY_DESCRIPTION"] == null ? null : json["CITY_DESCRIPTION"],
        countryDescription: json["COUNTRY_DESCRIPTION"] == null
            ? null
            : json["COUNTRY_DESCRIPTION"],
        specialityDescription: json["SPECIALITY_DESCRIPTION"] == null
            ? null
            : json["SPECIALITY_DESCRIPTION"],
        phoneNumber1:
            json["PHONE_NUMBER1"] == null ? null : json["PHONE_NUMBER1"],
        providerTypeDescription: json["PROVIDER_TYPE_DESCRIPTION"] == null
            ? null
            : json["PROVIDER_TYPE_DESCRIPTION"],
        branchId: json["BRANCH_ID"],
        branches: json["BRANCHES"] == null
            ? null
            : List<Branch>.from(
                json["BRANCHES"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "PROVIDER_NAME": providerName == null ? null : providerName,
        "PROVIDER_ID": providerId == null ? null : providerId,
        "LATITUDE": latitude == null ? null : latitude,
        "LONGITUDE": longitude == null ? null : longitude,
        "CITY_DESCRIPTION": cityDescription == null ? null : cityDescription,
        "COUNTRY_DESCRIPTION":
            countryDescription == null ? null : countryDescription,
        "SPECIALITY_DESCRIPTION":
            specialityDescription == null ? null : specialityDescription,
        "PHONE_NUMBER1": phoneNumber1 == null ? null : phoneNumber1,
        "PROVIDER_TYPE_DESCRIPTION":
            providerTypeDescription == null ? null : providerTypeDescription,
        "BRANCH_ID": branchId,
        "BRANCHES": branches == null
            ? null
            : List<dynamic>.from(branches.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    this.id,
    this.providerId,
    this.branchId,
    this.countryDescription,
    this.cityDescription,
    this.phoneNumber1,
    this.longitude,
    this.latitude,
    this.branchName,
    this.typeDescription,
    this.specialityDescription,
    this.networkId,
  });

  int id;
  String providerId;
  String branchId;
  String countryDescription;
  String cityDescription;
  String phoneNumber1;
  String longitude;
  String latitude;
  String branchName;
  String typeDescription;
  String specialityDescription;
  Network networkId;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["ID"] == null ? null : json["ID"],
        providerId: json["PROVIDER_ID"] == null ? null : json["PROVIDER_ID"],
        branchId: json["BRANCH_ID"] == null ? null : json["BRANCH_ID"],
        countryDescription: json["COUNTRY_DESCRIPTION"] == null
            ? null
            : json["COUNTRY_DESCRIPTION"],
        cityDescription:
            json["CITY_DESCRIPTION"] == null ? null : json["CITY_DESCRIPTION"],
        phoneNumber1:
            json["PHONE_NUMBER1"] == null ? null : json["PHONE_NUMBER1"],
        longitude: json["LONGITUDE"] == null ? null : json["LONGITUDE"],
        latitude: json["LATITUDE"] == null ? null : json["LATITUDE"],
        branchName: json["BRANCH_NAME"] == null ? null : json["BRANCH_NAME"],
        typeDescription:
            json["TYPE_DESCRIPTION"] == null ? null : json["TYPE_DESCRIPTION"],
        specialityDescription: json["SPECIALITY_DESCRIPTION"] == null
            ? null
            : json["SPECIALITY_DESCRIPTION"],
        networkId: json["NETWORK_ID"] == null
            ? null
            : networkValues.map[json["NETWORK_ID"]],
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "PROVIDER_ID": providerId == null ? null : providerId,
        "BRANCH_ID": branchId == null ? null : branchId,
        "COUNTRY_DESCRIPTION":
            countryDescription == null ? null : countryDescription,
        "CITY_DESCRIPTION": cityDescription == null ? null : cityDescription,
        "PHONE_NUMBER1": phoneNumber1 == null ? null : phoneNumber1,
        "LONGITUDE": longitude == null ? null : longitude,
        "LATITUDE": latitude == null ? null : latitude,
        "BRANCH_NAME": branchName == null ? null : branchName,
        "TYPE_DESCRIPTION": typeDescription == null ? null : typeDescription,
        "SPECIALITY_DESCRIPTION":
            specialityDescription == null ? null : specialityDescription,
        "NETWORK_ID":
            networkId == null ? null : networkValues.reverse[networkId],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
