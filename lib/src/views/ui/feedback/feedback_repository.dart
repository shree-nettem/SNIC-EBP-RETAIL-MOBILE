import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';

class FeedbackRepository {
  final Dio _dio = Dio();
  var feedbackURL = Constants.BASE_URL + '/Customer/GetPreference/FeedBack';

  Future<ResultV1> getFeedBack(token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        feedbackURL,
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
