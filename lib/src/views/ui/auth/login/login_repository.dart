import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';

import 'login_model.dart';

class LoginRepository {
  final Dio _dio = Dio();

  //LOGIN API CALL
  var loginURL = 'Authenticate';
  Future<ResultV1> login(var email, var password) async {
    var loginMap = {
      "Username": email,
      "Password": password,
      "AppID": "EBP_RETAIL",
    };

    try {
      Response response = await _dio.post(
        loginURL,
        data: loginMap,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return ResultV1.success(LoginModel.fromJson(response.data));
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print("Error " + error.type.toString());
    }
  }

  //CUSTOMER CHECK
  var customerCheckURL = Constants.BASE_URL + '/Customer/Check';
  Future<ResultV1> checkProfile(token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        customerCheckURL,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return ResultV1.success(response.data);
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      return ResultV1.error(errorMessage);
    }
  }
}
