import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';

class MedicalCardRepository {
  final Dio _dio = Dio();
  var getECardURL = Constants.BASE_URL + '/Medical/Cards?companyId=1';

  //GET MY MEDICAL E CARDS
  Future<ResultV1> getMedicalECards(token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        getECardURL,
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
