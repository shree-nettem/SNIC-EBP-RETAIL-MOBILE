class LoginErrorModel {
  LoginErrorModel({
    this.message,
    this.modelState,
  });

  String message;
  ModelState modelState;
}

class ModelState {
  ModelState({
    this.empty,
  });

  List<String> empty;
}
