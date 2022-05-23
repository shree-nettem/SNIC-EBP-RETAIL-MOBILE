import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';

import 'employee_profile_model.dart';

class EmployeeProfileRepository {
  final Dio _dio = Dio();

  //SAVE PROFILE
  var saveProfileURL = Constants.BASE_URL + '/Customer/SaveProfile';

  Future<ResultV1> saveProfile(saveProfileMap, token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.post(
        saveProfileURL,
        data: saveProfileMap,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return ResultV1.success(EmployeeProfileResponse.fromJson(response.data));
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      var errorResponse = error.response.data;
      EmployeeProfileErrorModel errorModel =
          EmployeeProfileErrorModel.fromJson(errorResponse);
      if (errorModel is EmployeeProfileErrorModel) {
        var errorMessage = errorModel.message;
        if (errorMessage != null && errorMessage.length > 0) {
          return ResultV1.error(
              EmployeeProfileResponse.withError(errorMessage));
        }
      } else {
        return ResultV1.error(EmployeeProfileResponse.withError(errorMessage));
      }
      return ResultV1.error(EmployeeProfileResponse.withError(errorMessage));
    }
  }

  //  SAVE PROFILE PICTURE
  Future<ResultV1> uploadPhoto(image, token, n) async {
    var uploadFileURL;
    if (n == 1) {
      uploadFileURL = Constants.BASE_URL + '/Customer/UploadPhoto';
    } else if (n == 2) {
      uploadFileURL = Constants.BASE_URL + '/Customer/UploadID';
    } else {
      uploadFileURL = Constants.BASE_URL + '/Customer/UploadPassport';
    }

    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};

      Map<String, MultipartFile> fileMap = {};
      String fileName = image.path;
      fileMap['image'] = MultipartFile(image.openRead(), await image.length(),
          filename: fileName);
      var formData = FormData.fromMap(fileMap);

      Response response = await _dio.post(
        uploadFileURL,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return ResultV1.success(response.statusCode);
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      return ResultV1.error(errorMessage);
    }
  }
}
