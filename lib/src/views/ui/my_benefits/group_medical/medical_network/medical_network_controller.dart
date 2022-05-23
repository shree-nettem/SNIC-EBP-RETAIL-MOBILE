import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import '../../../../../utilities/ui_constants.dart';
import '../../../../../utilities/utils.dart';
import 'package:get/get.dart';

import 'medical_repository.dart';
import 'model/my_favourite_response.dart';
import 'model/my_medical_network_model.dart';
import 'model/save_favourite_response.dart';

class MedicalNetworkXController extends GetxController {
  var token;
  final MedicalRepository _repository = MedicalRepository();
  List<Provider> providerList = [];
  List<Provider> filteredFavoriteList = [];
  List<MyFavouritesResponse> favoriteList = [];
  var longContact;

  @override
  void onInit() {
    fetchMedicalNetworks();
    super.onInit();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    print("TOKEN $token");
  }

  //FETCH MEDICAL NETWORKS
  fetchMedicalNetworks() async {
    await getToken();
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result = await _repository.getMedicalNetworks(token);
    Get.back();
    if (result is SuccessState) {
      if (result.value is MyMedicalNetworkModel) {
        providerList = result.value.provider;
        var contactSupport = result.value.contactSupport;
        longContact = "Local\n" +
            contactSupport.local +
            "\n\n International\n" +
            contactSupport.international;
        print("Success List Medical Networks!");
        fetchMyMedicalFavourites(token);
        update();
      } else {
        print("Success Null");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  //FETCH MEDICAL FAVOURITES
  fetchMyMedicalFavourites(token) async {
    ResultV1 result = await _repository.getMedicalFavourites(token);
    if (result is SuccessState) {
      if (result.value.length > 0) {
        var data = List<MyFavouritesResponse>.from(
            result.value.map((i) => MyFavouritesResponse.fromJson(i)));
        favoriteList = data;
        print("Success List Medical Favourites! " +
            favoriteList.length.toString());
        if (favoriteList.length > 0) {
          getFavorites();
        }
      } else {
        print("No records found");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  void getFavorites() {
    for (var fav in favoriteList) {
      var duplicateProvider = providerList
          .where((x) =>
              x.pROVIDERID.toLowerCase().contains(fav.branchID.toLowerCase()))
          .toList();

      filteredFavoriteList.addAll(duplicateProvider);
    }
    print("Filtered List " + filteredFavoriteList.length.toString());
    update();
  }

  //UPDATE THE FAVOURITE
  void makeFavourite(String id) async {
    var saveFavouriteMap = {"BranchID": id, "Favorite": true};
    print("SAVE MAP " + saveFavouriteMap.toString());
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result = await _repository.saveFavourite(token, saveFavouriteMap);
    Get.back();
    if (result is SuccessState) {
      if (result.value is SaveFavouriteResponse) {
        var id = result.value.id;
        print("Success Favourite " + id.toString());
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
