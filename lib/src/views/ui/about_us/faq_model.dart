class FAQModel {
  int iD;
  String title;
  String discription;

  FAQModel({this.iD, this.title, this.discription});

  FAQModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
    discription = json['Discription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Title'] = this.title;
    data['Discription'] = this.discription;
    return data;
  }
}
