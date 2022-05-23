import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/ui/employee_profile/employee_profile_model.dart';

class DependentProfileRepository {
  final Dio _dio = Dio();

  //SAVE MEMBER PROFILE
  var saveMemberProfileURL = Constants.BASE_URL + '/Customer/SaveMember';

  Future<ResultV1> saveMemberProfile(saveMemberProfileMap, token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.post(
        saveMemberProfileURL,
        data: saveMemberProfileMap,
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
  Future<ResultV1> uploadPhoto(image, token, n, dependentId) async {
    var uploadFileURL;
    if (n == 1) {
      uploadFileURL =
          Constants.BASE_URL + '/Customer/UploadPhoto?dependentId=$dependentId';
    } else if (n == 2) {
      uploadFileURL =
          Constants.BASE_URL + '/Customer/UploadID?dependentId=$dependentId';
    } else {
      uploadFileURL = Constants.BASE_URL +
          '/Customer/UploadPassport?dependentId=$dependentId';
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

//  DELETE PROFILE MEMBER
  var deleteDependentURL = Constants.BASE_URL + '/Customer/DeleteMember?id=';

  Future<ResultV1> deleteProfile(token, id) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.post(
        deleteDependentURL + id,
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
