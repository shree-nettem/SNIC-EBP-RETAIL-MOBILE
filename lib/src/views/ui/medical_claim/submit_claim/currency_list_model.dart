class CurrencyList {
  CurrencyList({
    this.result,
  });

  List<CurrencyResult> result;

  factory CurrencyList.fromJson(Map<String, dynamic> json) => CurrencyList(
        result: json["Result"] == null
            ? null
            : List<CurrencyResult>.from(
                json["Result"].map((x) => CurrencyResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Result": result == null
            ? null
            : List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class CurrencyResult {
  CurrencyResult({
    this.value,
    this.text,
  });

  String value;
  String text;

  factory CurrencyResult.fromJson(Map<String, dynamic> json) => CurrencyResult(
        value: json["Value"] == null ? null : json["Value"],
        text: json["Text"] == null ? null : json["Text"],
      );

  Map<String, dynamic> toJson() => {
        "Value": value == null ? null : value,
        "Text": text == null ? null : text,
      };
}
