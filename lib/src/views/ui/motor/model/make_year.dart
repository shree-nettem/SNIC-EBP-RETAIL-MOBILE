// To parse this JSON data, do
//
//     final makeYear = makeYearFromJson(jsonString);

import 'dart:convert';

MakeYear makeYearFromJson(String str) => MakeYear.fromJson(json.decode(str));

String makeYearToJson(MakeYear data) => json.encode(data.toJson());

class MakeYear {
  MakeYear({
    this.years,
  });

  final List<int> years;

  factory MakeYear.fromJson(Map<String, dynamic> json) => MakeYear(
    years: json["Years"] == null ? null : List<int>.from(json["Years"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Years": years == null ? null : List<dynamic>.from(years.map((x) => x)),
  };
}
