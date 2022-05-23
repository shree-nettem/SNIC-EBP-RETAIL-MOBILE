import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';

class RegisterRepository {
  final Dio _dio = Dio();
  var registerURL = Constants.BASE_URL + '/Registration';

  Future<ResultV1> register(var email, var password, var idNumber) async {
    var registerMap = {
      "Email": email,
      "AppID": "EBP_RETAIL",
      "AppRoleID": "NEW",
      "Password": password,
      "ConfirmPassword": password,
      "IdentityID": idNumber
    };

    try {
      Response response = await _dio.post(
        registerURL,
        data: registerMap,
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
