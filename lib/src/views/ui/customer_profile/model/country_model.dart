class CountryModel {
  List<CountryResult> result;

  CountryModel({this.result});

  CountryModel.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      result = [];
      json['countries'].forEach((v) {
        result.add(new CountryResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['countries'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryResult {
  String name;
  String value;

  CountryResult({this.name, this.value});

  CountryResult.fromJson(Map<String, dynamic> json) {
    name = json['country'];
    value = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.name;
    data['code'] = this.value;
    return data;
  }
}
