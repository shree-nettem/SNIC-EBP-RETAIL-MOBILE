class CustomerTOBModel {
  String title;
  List<SubSections> subSections;

  CustomerTOBModel({this.title, this.subSections});

  CustomerTOBModel.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    if (json['SubSections'] != null) {
      subSections = [];
      json['SubSections'].forEach((v) {
        subSections.add(new SubSections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    if (this.subSections != null) {
      data['SubSections'] = this.subSections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubSections {
  String ref;
  String title;
  String value;
  String notes;
  String remarks;

  SubSections({this.ref, this.title, this.value, this.notes, this.remarks});

  SubSections.fromJson(Map<String, dynamic> json) {
    ref = json['Ref'];
    title = json['Title'];
    value = json['Value'];
    notes = json['Notes'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Ref'] = this.ref;
    data['Title'] = this.title;
    data['Value'] = this.value;
    data['Notes'] = this.notes;
    data['Remarks'] = this.remarks;
    return data;
  }
}
