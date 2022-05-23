import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
// import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/constants.dart';

class HomeRepository {
  final Dio _dio = Dio();
  var isProductValidURL = Constants.BASE_URL + '/Product/IsProductValid?code=';

  Future<Result> fetchProductValid(token, data) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        isProductValidURL + data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return Result.success(response.data);
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      var errorResponse = error.response.data["Message"];
      return Result.error(errorResponse);
    }
  }
}
