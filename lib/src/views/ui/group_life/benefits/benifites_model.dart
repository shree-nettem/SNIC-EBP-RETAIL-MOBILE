class BenefitsModel {
  BenefitsModel({
    this.title,
    this.subSections,
  });

  String title;
  List<BenefitsSubSection> subSections;

  factory BenefitsModel.fromJson(Map<String, dynamic> json) => BenefitsModel(
        title: json["Title"] == null ? null : json["Title"],
        subSections: json["SubSections"] == null
            ? null
            : List<BenefitsSubSection>.from(
                json["SubSections"].map((x) => BenefitsSubSection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Title": title == null ? null : title,
        "SubSections": subSections == null
            ? null
            : List<dynamic>.from(subSections.map((x) => x.toJson())),
      };
}

class BenefitsSubSection {
  BenefitsSubSection({
    this.ref,
    this.title,
    this.value,
    this.notes,
    this.remarks,
  });

  String ref;
  String title;
  String value;
  String notes;
  String remarks;

  factory BenefitsSubSection.fromJson(Map<String, dynamic> json) =>
      BenefitsSubSection(
        ref: json["Ref"] == null ? null : json["Ref"],
        title: json["Title"] == null ? null : json["Title"],
        value: json["Value"] == null ? null : json["Value"],
        notes: json["Notes"] == null ? null : json["Notes"],
        remarks: json["Remarks"] == null ? null : json["Remarks"],
      );

  Map<String, dynamic> toJson() => {
        "Ref": ref == null ? null : ref,
        "Title": title == null ? null : title,
        "Value": value == null ? null : value,
        "Notes": notes == null ? null : notes,
        "Remarks": remarks == null ? null : remarks,
      };
}
