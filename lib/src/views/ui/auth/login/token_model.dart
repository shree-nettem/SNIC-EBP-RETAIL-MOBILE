class TokenModel {
  String accessToken;
  String tokenType;
  int expiresIn;
  String name;
  String companies;
  String issued;
  String expires;
  String companyId;

  TokenModel(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.name,
      this.companies,
      this.issued,
      this.expires,
      this.companyId});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    name = json['Name'];
    companies = json['Companies'];
    issued = json['.issued'];
    expires = json['.expires'];
    companyId = json['companyId'] != null ? json['companyId'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['Name'] = this.name;
    data['Companies'] = this.companies;
    data['.issued'] = this.issued;
    data['.expires'] = this.expires;
    return data;
  }
}
