class EmployeeProfileModel {
  int iD;

  EmployeeProfileModel({this.iD});

  EmployeeProfileModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    return data;
  }
}

class EmployeeProfileErrorModel {
  String message;

  EmployeeProfileErrorModel({this.message});

  EmployeeProfileErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    return data;
  }
}

class EmployeeProfileResponse {
  final EmployeeProfileModel employeeProfileModel;
  final String error;

  EmployeeProfileResponse({
    this.employeeProfileModel,
    this.error,
  });

  EmployeeProfileResponse.fromJson(Map<String, dynamic> json)
      : employeeProfileModel = EmployeeProfileModel.fromJson(json),
        error = null;

  EmployeeProfileResponse.withError(String errorValue)
      : employeeProfileModel = null,
        error = errorValue;
}
