class ErrorMessageModel {
  String message;
  ModelState modelState;

  ErrorMessageModel({this.message, this.modelState});

  ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    modelState = json['ModelState'] != null
        ? new ModelState.fromJson(json['ModelState'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    if (this.modelState != null) {
      data['ModelState'] = this.modelState.toJson();
    }
    return data;
  }
}

class ModelState {
  List<String> errors;

  ModelState({this.errors});

  ModelState.fromJson(Map<String, dynamic> json) {
    errors = json['Errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Errors'] = this.errors;
    return data;
  }
}
