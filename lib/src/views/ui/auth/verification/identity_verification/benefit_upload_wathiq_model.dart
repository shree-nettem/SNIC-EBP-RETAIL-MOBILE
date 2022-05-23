class BenefitUploadWathiqModel {
  String messageStatus;
  String errorDescription;
  int errorCode;
  String timestamp;
  String name;
  String type;
  String hash;
  String downloadPath;
  String cipherMessageId;

  BenefitUploadWathiqModel(
      {this.messageStatus,
      this.errorDescription,
      this.errorCode,
      this.timestamp,
      this.name,
      this.type,
      this.hash,
      this.downloadPath,
      this.cipherMessageId});

  BenefitUploadWathiqModel.fromJson(Map<String, dynamic> json) {
    messageStatus = json['messageStatus'];
    errorDescription = json['errorDescription'];
    errorCode = json['errorCode'];
    timestamp = json['timestamp'];
    name = json['name'];
    type = json['type'];
    hash = json['hash'];
    downloadPath = json['downloadPath'];
    cipherMessageId = json['cipherMessageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageStatus'] = this.messageStatus;
    data['errorDescription'] = this.errorDescription;
    data['errorCode'] = this.errorCode;
    data['timestamp'] = this.timestamp;
    data['name'] = this.name;
    data['type'] = this.type;
    data['hash'] = this.hash;
    data['downloadPath'] = this.downloadPath;
    data['cipherMessageId'] = this.cipherMessageId;
    return data;
  }
}
