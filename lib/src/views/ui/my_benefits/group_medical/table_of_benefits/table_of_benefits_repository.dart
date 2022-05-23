import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';

class TableOfBenefitsRepository {
  final Dio _dio = Dio();
  var getCustomerTOBURL =
      Constants.BASE_URL + '/Medical/CustomerTOB?companyId=1';

  //GET CUSTOMER TABLE OF BENEFITS
  Future<ResultV1> getCustomerTOB(token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        getCustomerTOBURL,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return ResultV1.success(response.data);
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      return ResultV1.error(errorMessage);
    }
  }

  //GET MEDICAL CARD
  var getMedicalCardURL = Constants.BASE_URL + '/Medical/Cards?companyId=1';

  Future<ResultV1> getMedicalCard(token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        getMedicalCardURL,
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
