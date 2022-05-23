import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';

class DashboardRepository {
  final Dio _dio = Dio();
  var isProductValidURL = Constants.BASE_URL + '/Product/IsProductValid?code=';

  Future<ResultV1> fetchProductValid(token, data) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        isProductValidURL + data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return ResultV1.success(response.data);
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      var errorResponse = error.response.data["Message"];
      return ResultV1.error(errorResponse);
    }
  }
}
