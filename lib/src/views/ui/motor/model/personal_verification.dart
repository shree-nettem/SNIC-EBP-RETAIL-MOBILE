// To parse this JSON data, do
//
//     final personalVerification = personalVerificationFromJson(jsonString);

import 'dart:convert';

PersonalVerification personalVerificationFromJson(String str) => PersonalVerification.fromJson(json.decode(str));

String personalVerificationToJson(PersonalVerification data) => json.encode(data.toJson());

class PersonalVerification {
  PersonalVerification({
    this.personalVerification,
  });

  final bool personalVerification;

  factory PersonalVerification.fromJson(Map<String, dynamic> json) => PersonalVerification(
    personalVerification: json["PersonalVerification"] == null ? null : json["PersonalVerification"],
  );

  Map<String, dynamic> toJson() => {
    "PersonalVerification": personalVerification == null ? null : personalVerification,
  };
}
