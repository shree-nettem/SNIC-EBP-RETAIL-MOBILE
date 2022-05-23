class GhadyHistoryModel {
  String date;
  num amount;
  num premium;
  num rate;

  GhadyHistoryModel({this.date, this.amount, this.premium, this.rate});

  GhadyHistoryModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'] != null ? json['Date'] : null;
    amount = json['Amount'] != null
        ? num.parse(json['Amount'].toStringAsFixed(3))
        : null;
    premium = json['Premium'] != null
        ? num.parse(json['Premium'].toStringAsFixed(3))
        : null;
    rate = json['Rate'] != null
        ? num.parse(json['Rate'].toStringAsFixed(3))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['Amount'] = this.amount;
    data['Premium'] = this.premium;
    data['Rate'] = this.rate;
    return data;
  }
}
