class BenefitUploadTokenModel {
  String messageStatus;
  int errorCode;
  String errorDescription;
  String token;
  String timestamp;
  String cipherMessageId;

  BenefitUploadTokenModel(
      {this.messageStatus,
      this.errorCode,
      this.errorDescription,
      this.token,
      this.timestamp,
      this.cipherMessageId});

  BenefitUploadTokenModel.fromJson(Map<String, dynamic> json) {
    messageStatus = json['messageStatus'];
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    token = json['token'];
    timestamp = json['timestamp'];
    cipherMessageId = json['cipherMessageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageStatus'] = this.messageStatus;
    data['errorCode'] = this.errorCode;
    data['errorDescription'] = this.errorDescription;
    data['token'] = this.token;
    data['timestamp'] = this.timestamp;
    data['cipherMessageId'] = this.cipherMessageId;
    return data;
  }
}
