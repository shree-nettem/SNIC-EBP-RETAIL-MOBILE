import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/dio_exceptions.dart';
import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';

import 'model/my_medical_network_model.dart';
import 'model/save_favourite_response.dart';

class MedicalRepository {
  final Dio _dio = Dio();
  var getMyNetworks = Constants.BASE_URL + '/Medical/CustomerNetwork';

  //GET MY MEDICAL CUSTOMER NETWORKS
  Future<ResultV1> getMedicalNetworks(token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        getMyNetworks,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return ResultV1.success(MyMedicalNetworkModel.fromJson(response.data));
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      return ResultV1.error(errorMessage);
    }
  }

  //GET MY FAVOURITES
  var getMyFavorites = Constants.BASE_URL + '/Customer/GetPreference/Favorites';

  Future<ResultV1> getMedicalFavourites(token) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.get(
        getMyFavorites,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      return ResultV1.success(response.data);
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      return ResultV1.error(errorMessage);
    }
  }

  //  SAVE FAVOURITES
  var saveFavouriteURL =
      Constants.BASE_URL + '/Customer/SavePreference/Favorites';

  Future<ResultV1> saveFavourite(token, saveFavouriteMap) async {
    try {
      _dio.options.headers = {"Authorization": "Bearer " + token};
      Response response = await _dio.post(
        saveFavouriteURL,
        data: saveFavouriteMap,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return ResultV1.success(SaveFavouriteResponse.fromJson(response.data));
    } on DioError catch (error) {
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      return ResultV1.error(errorMessage);
    }
  }
}
