class JumioErrorModel {
  String errorCode;
  String errorMessage;
  String scanReference;

  JumioErrorModel({this.errorCode, this.errorMessage, this.scanReference});

  JumioErrorModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    scanReference = json['scanReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorMessage'] = this.errorMessage;
    data['scanReference'] = this.scanReference;
    return data;
  }
}
