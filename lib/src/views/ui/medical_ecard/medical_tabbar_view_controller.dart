import 'dart:convert';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/app_helper.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/auth/login/token_model.dart';
import 'package:ebpv2/src/views/ui/medical_ecard/medicalEcardsModel.dart';
import 'package:ebpv2/src/views/ui/medical_group/tob/product_company_list_model.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share_plus/share_plus.dart';

class MedicalTabbarViewXController extends GetxController {
  final AutoScrollController scrollController = new AutoScrollController();
  int pageNo = 0;
  String token;
  String savedCompanyId;
  String companyID;
  String userID;

  //
  List<ProductCompanyList> totalCompanies = [];
  List<String> totalCompaniesForDropdown = [];
  String selectedCompany = '';
  String email;
  String password;
  SharedPreferencesHelper _sharedPreferencesHelper;

  bool isCardFrontSide = true;
  RxBool isMedicalCardsLoading = false.obs;
  String backSideUrl = '';
  RxBool backUrlLoaded = false.obs;
  // GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  List<MedicalEcardsModel> totalEcards = []; //scroll to previous plan
  void scrollToPreviousPage() {
    if (pageNo != 0) {
      this.pageNo = pageNo - 1;
      scrollController.scrollToIndex(pageNo,
          preferPosition: AutoScrollPosition.middle);
      update();
    }
  }

//scroll to next plan
  void scrollToNextPage() {
    if (pageNo >= 0 && pageNo < totalEcards.length && totalEcards.length > 1) {
      this.pageNo = pageNo + 1;
      scrollController.scrollToIndex(pageNo,
          preferPosition: AutoScrollPosition.middle);
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  //toggle cards

  toggleCards({int currentIndex = 0}) {
    pageNo = currentIndex;
    if (isCardFrontSide) {
      isCardFrontSide = false;
      if (!backUrlLoaded.value) getBackCardApi();
    } else {
      isCardFrontSide = true;
    }
    // update();
  }

  /* GET TOKEN */
  getToken() async {
    _sharedPreferencesHelper = SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    savedCompanyId = await _sharedPreferencesHelper.getSavedCompanyId;
    userID = await _sharedPreferencesHelper.getCustomerId;
    var getCompanies = await _sharedPreferencesHelper.getCompanyId;
    List obj = json.decode(getCompanies);
    try {
      var company =
          obj.firstWhere((element) => element["Name"] == "Global ITs");
      companyID = company["Id"].toString();
    } catch (e) {
      try {
        var company =
            obj.firstWhere((element) => element["Name"] == selectedCompany);
        companyID = company["Id"].toString();
      } catch (e) {
        if (obj.length > 0) companyID = obj.first["Id"].toString();
      }
    }

    getEmail();
    getProductCompanyList();
  }

  void sharingData() async {
    var result = await DioClient().downloadTempFile(
      isCardFrontSide
          ? "http://20.203.8.34/Medical/CardImage?id=${totalEcards[pageNo].identityId}&lifecode=${totalEcards[pageNo].lifeCode}&principalLifeCode=${totalEcards[pageNo].principal}&customerId=${userID}&companyId=${companyID}"
          : backSideUrl,
    );

    try {
      await Share.shareFiles(
        [result.toString()],
        mimeTypes: ["image/png"],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void downloadImage() async {
    var result = await DioClient().downloadFile(
      isCardFrontSide
          ? "http://20.203.8.34/Medical/CardImage?id=${totalEcards[pageNo].identityId}&lifecode=${totalEcards[pageNo].lifeCode}&principalLifeCode=${totalEcards[pageNo].principal}&customerId=${userID}&companyId=${companyID}"
          : backSideUrl,
    );
    print(result);
  }

  // getBeificiaries() async {
  //   Result result = await DioClient().get('Life/GetBeneficiaries', token);

  // }

  void getMedicalCards() async {
    isMedicalCardsLoading.value = true;
    Result result =
        await DioClient().get('Medical/Cards', token, isLoading: false);

    if (result is SuccessState) {
      var jsonData = List<MedicalEcardsModel>.from(
          result.value.map((x) => MedicalEcardsModel.fromJson(x)));
      isMedicalCardsLoading.value = false;
      if (jsonData is List<MedicalEcardsModel>) {
        totalEcards = jsonData;
        print(totalEcards.length);
        update();
        // getProductCompanyList();
      } else {
        update();
      }
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.error.toString());
    }
  }

  void getBackCardApi() async {
    Result result = await DioClient().get(
        'Medical/CardBackLink?nationalId=${totalEcards[pageNo].identityId}&lifecode=${totalEcards[pageNo].lifeCode}&principalLifeCode=${totalEcards[pageNo].principal}',
        token);

    if (result is SuccessState) {
      backSideUrl = result.value["Link"].toString();
      backUrlLoaded.value = true;
      // update();
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.error.toString());
    }
  }

  getProductCompanyList() async {
    Result result = await DioClient().get(
        'Product/ProductCompanyList?code=MEDICAL', token,
        isLoading: false);
    if (result is SuccessState) {
      var jsonData = List<ProductCompanyList>.from(
          result.value.map((x) => ProductCompanyList.fromJson(x)));
      if (jsonData is List<ProductCompanyList>) {
        totalCompanies = jsonData;
        totalCompaniesForDropdown = jsonData.map((e) => e.companyName).toList();
        try {
          selectedCompany = totalCompanies
              .firstWhere(
                  (element) => element.companyId.toString() == savedCompanyId)
              .companyName;
        } catch (e) {
          selectedCompany = totalCompanies.first.companyName;
          companyID = totalCompanies.first.companyId.toString();
        }
        getMedicalCards();
        // if (totalCompanies.length == 1) {
        //   int companyId = totalCompanies[0].companyId;
        //   // getUpdatedToken(companyId);
        // }
        update();
      }
    } else if (result is ErrorState) {
      // Get.back();
      // errorMessage(result.msg.error.toString());
    }
  }

  Future<String> getEmail() async {
    email = await _sharedPreferencesHelper.getEmail;
    password = await _sharedPreferencesHelper.getPassword;

    return email;
  }

  selectedTokenFromDropDown(String selectedCompany) {
    selectedCompany = selectedCompany;
    int companyId = totalCompanies
        .firstWhere((element) => element.companyName == selectedCompany)
        .companyId;
    getUpdatedToken(companyId);
  }

  // GET UPDATED TOKEN
  getUpdatedToken(int companyId) async {
    var requestMap = {
      "Username": email,
      "Password": password ?? "",
      "grant_type": "password",
      "AppID": "EBP_RETAIL",
      "CompanyID": companyId,
      "InsurerID": 2,
    };

    Result result = await DioClient().post('token', requestMap);
    if (result is SuccessState) {
      var jsonData = TokenModel.fromJson(result.value);
      if (jsonData is TokenModel) {
        jsonData.companyId = companyId.toString();
        saveUserDetails(jsonData);
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

// SAVING DETAILS IN SHARED PREFERENCES
  void saveUserDetails(TokenModel tokenModel) async {
    var userDetails = TokenModel(
        accessToken: tokenModel.accessToken,
        tokenType: tokenModel.tokenType,
        expiresIn: tokenModel.expiresIn,
        name: tokenModel.name,
        companies: tokenModel.companies,
        issued: tokenModel.issued,
        expires: tokenModel.expires,
        companyId: tokenModel.companyId);

    AppHelper.saveKeepMeSignedIn(true);
    SharedPreferencesHelper.saveUserDetails(userDetails);
    getToken();
  }
}
