class ProductCompanyList {
  ProductCompanyList({
    this.companyId,
    this.companyName,
  });

  int companyId;
  String companyName;

  factory ProductCompanyList.fromJson(Map<String, dynamic> json) =>
      ProductCompanyList(
        companyId: json["CompanyID"] == null ? null : json["CompanyID"],
        companyName: json["CompanyName"] == null ? null : json["CompanyName"],
      );

  Map<String, dynamic> toJson() => {
        "CompanyID": companyId == null ? null : companyId,
        "CompanyName": companyName == null ? null : companyName,
      };
}
