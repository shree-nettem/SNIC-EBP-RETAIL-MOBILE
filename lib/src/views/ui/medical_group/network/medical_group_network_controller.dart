import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/group_life/benefits/benifites_model.dart';
import 'package:ebpv2/src/views/ui/medical_group/network/customer_medical_network.dart';
import 'package:ebpv2/src/views/ui/medical_group/network/favorite_medical_network.dart';
import 'package:ebpv2/src/views/ui/medical_group/tob/medical_table_of_benefits_controller.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/medical_network/model/my_favourite_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalGroupNetwornXController extends GetxController {
  List<String> filteredFavoriteList = [
    "Ruyan Department Store National Pharmacy",
    "Ruyan Department Store National Pharmacy"
  ];

  bool lang = false;

  List<BenefitsSubSection> medicalNetwork = [];

  List<MyFavouritesResponse> favoriteList = [];

  List<MedicalProvider> totalHospitals = [];

  List<MedicalProvider> totalFilteredHospitals = [];
  List<FavoriteMedicalNetwork> totalFavHospitals = [];

//filter objects for ospitals
  List<String> totalCities = [];
  List<String> totslCategories = [];
  List<String> totalSpecilization = [];

  // selected filter from dropdowns
  String selectedCity = 'select'.tr;
  String selectedCategory = 'select'.tr;
  String selectedSpecilization = 'select'.tr;
  String searchText = '';
  ContactSupport contactSupport;

  var longContact;

  bool viewHospital = false;

  bool filterActivate = false;

  String token;

  int currentLoadedIndex = 10;

  void toggleViewHospital() {
    viewHospital = viewHospital == true ? false : true;
    update();
  }

  void activateFitlerAction() {
    filterActivate = filterActivate == true ? false : true;
    if (!filterActivate) {
      selectedCity = 'select'.tr;
      selectedCategory = 'select'.tr;
      selectedSpecilization = 'select'.tr;
      filteredHospitalFromFilters();
    }

    update();
  }

  @override
  void onInit() {
    // getToken();

    super.onInit();
  }

  void getMoreDataPagination() {
    if (totalFilteredHospitals.length > currentLoadedIndex) {
      currentLoadedIndex = currentLoadedIndex + 10;
      currentLoadedIndex = currentLoadedIndex >= totalFilteredHospitals.length
          ? totalFilteredHospitals.length
          : currentLoadedIndex;
    } else {
      currentLoadedIndex = totalFilteredHospitals.length;
    }
    update();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    lang = await _sharedPreferencesHelper.getLang;
    debugPrint("LANGUAGE CODE $lang");
    getMedialNetwork();
  }

  String filterFavHospitalName(String branchId, {isTitle = true}) {
    MedicalProvider item =
        totalHospitals.firstWhere((element) => element.providerId == branchId);

    return isTitle ? item.providerName : item.cityDescription;
  }

  bool checkingFavHospital(String providerId) {
    try {
      FavoriteMedicalNetwork item = totalFavHospitals
          .firstWhere((element) => element.branchId == providerId);
      return item != null ? true : false;
    } catch (e) {
      return false;
    }
  }

  gettingFilterDataForHospital() {
    var citites =
        totalHospitals.map((element) => element.cityDescription).toList();
    totalCities.add("select".tr);
    totalCities.addAll({...citites}.toList());

    var categorie = totalHospitals
        .map((element) => element.providerTypeDescription)
        .toList();
    totslCategories.add("Select".tr);
    totslCategories.addAll({...categorie}.toList());
    var specilization =
        totalHospitals.map((element) => element.specialityDescription).toList();
    totalSpecilization.add("Select".tr);
    totalSpecilization.addAll({...specilization}.toList());
  }

  filteredHospitalFromFilters() {
    var filteredData = filterWithText(
        filterCities(filterSpecs(filterCategories(totalHospitals))));
    totalFilteredHospitals = filteredData;

    currentLoadedIndex =
        totalFilteredHospitals.length > 10 ? 10 : totalFilteredHospitals.length;
    update();
  }

// filtering cities
  List<MedicalProvider> filterCities(List<MedicalProvider> data) {
    FocusScope.of(Get.context).unfocus();
    if (selectedCity == "Select".tr) {
      return data;
    }
    var filteredHosp =
        data.where((i) => i.cityDescription == selectedCity).toList();
    return filteredHosp;
  }

  // filtering categories
  List<MedicalProvider> filterCategories(List<MedicalProvider> data) {
    if (selectedCategory == "Select".tr) {
      return data;
    }
    var filteredHosp = data
        .where((i) => i.providerTypeDescription == selectedCategory)
        .toList();
    return filteredHosp;
  }

  // filtering Specilization
  List<MedicalProvider> filterSpecs(List<MedicalProvider> data) {
    if (selectedSpecilization == "Select".tr) {
      return data;
    }
    var filteredHosp = data
        .where((i) => i.specialityDescription == selectedSpecilization)
        .toList();
    return filteredHosp;
  }

  // filtering with text
  List<MedicalProvider> filterWithText(List<MedicalProvider> data) {
    if (searchText == "") {
      return data;
    }
    var filteredHosp = data
        .where((i) =>
            i.providerName.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return filteredHosp;
  }

  getMedialNetwork() async {
    Result result = await DioClient()
        .get('Medical/CustomerNetwork', token, isLoading: false);
    // Get.back();
    if (result is SuccessState) {
      if (result.value == null) {
        return;
      }

      CustomerMedicalNetwork jsonData =
          CustomerMedicalNetwork.fromJson(result.value);
      totalHospitals = jsonData.provider;
      totalFilteredHospitals = jsonData.provider;
      gettingFilterDataForHospital();
      getFavoriteMedicalNetwork();
      MedicalTabbleOfBenefitsXController tobController =
          Get.isRegistered<MedicalTabbleOfBenefitsXController>()
              ? Get.find<MedicalTabbleOfBenefitsXController>()
              : Get.put(MedicalTabbleOfBenefitsXController());
      tobController.contactSupport = jsonData.contactSupport;
      this.contactSupport = jsonData.contactSupport;
    } else if (result is ErrorState) {}
  }

  getFavoriteMedicalNetwork() async {
    Result result = await DioClient()
        .get('Customer/GetPreference/Favorites', token, isLoading: false);
    if (result is SuccessState) {
      if (result.value == null) {
        return;
      }

      var jsonData = List<FavoriteMedicalNetwork>.from(
          result.value.map((x) => FavoriteMedicalNetwork.fromJson(x)));
      totalFavHospitals = jsonData;
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  saveFavoriteHospitals(String branchID, {bool addingNewHosp = true}) async {
    if (addingNewHosp) {
      FavoriteMedicalNetwork newHosp =
          FavoriteMedicalNetwork(branchId: branchID, favorite: true);
      totalFavHospitals.add(newHosp);
    } else {
      try {
        FavoriteMedicalNetwork item = totalFavHospitals
            .firstWhere((element) => element.branchId == branchID);
        totalFavHospitals.remove(item);
      } catch (e) {
        errorMessage(e.toString());
      }
    }

    var requestMap =
        List<dynamic>.from(totalFavHospitals.map((x) => x.toJson()));
    print(requestMap.length);
    Result result = await DioClient().post(
        'Customer/SavePreference/Favorites', requestMap,
        token: token, isPostData: true, isHeaderJsonType: true);

    if (result is SuccessState) {
      getFavoriteMedicalNetwork();
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }
}
