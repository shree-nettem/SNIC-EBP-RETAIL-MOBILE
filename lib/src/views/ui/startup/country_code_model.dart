class CountryCodeModel {
  CountryCodeModel({
    this.result,
  });

  List<CountryCodeResult> result;

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) =>
      CountryCodeModel(
        result: json["result"] == null
            ? null
            : List<CountryCodeResult>.from(
                json["result"].map((x) => CountryCodeResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? null
            : List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class CountryCodeResult {
  CountryCodeResult({
    this.name,
    this.dialCode,
    this.code,
  });

  String name;
  String dialCode;
  String code;

  factory CountryCodeResult.fromJson(Map<String, dynamic> json) =>
      CountryCodeResult(
        name: json["Name"] == null ? null : json["Name"],
        dialCode: json["DialCode"] == null ? null : json["DialCode"],
        code: json["Code"] == null ? null : json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name == null ? null : name,
        "DialCode": dialCode == null ? null : dialCode,
        "Code": code == null ? null : code,
      };
}
