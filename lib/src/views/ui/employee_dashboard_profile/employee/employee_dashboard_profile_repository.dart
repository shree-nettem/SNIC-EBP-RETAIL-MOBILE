import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';

import 'employee_dashboard_profile_response.dart';

class EmployeeDashboardProfileRepository {
  final Dio _dio = Dio();
  var customerProfileURL = Constants.BASE_URL + '/Customer/Details';

  Future<ResultV1> getCustomerProfile(token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        customerProfileURL,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return ResultV1.success(
          EmployeeDashboardProfileResponse.fromJson(response.data));
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      return ResultV1.error(errorMessage);
    }
  }
}
