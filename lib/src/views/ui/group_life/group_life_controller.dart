import 'dart:convert';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/app_helper.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/auth/login/token_model.dart';
import 'package:ebpv2/src/views/ui/group_life/beneficiary/beneficiary_controller.dart';
import 'package:ebpv2/src/views/ui/group_life/benefits/benifits_controller.dart';
import 'package:ebpv2/src/views/ui/medical_group/tob/product_company_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupLifeXController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController tabController;

  String token;
  String savedCompanyId;
  List<ProductCompanyList> totalCompanies = [];
  List<String> totalCompaniesForDropdown = [];
  String selectedCompany = '';
  String email;
  String password;
  SharedPreferencesHelper _sharedPreferencesHelper;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    getToken();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void backActionClicked(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (Get.find<BeneficiaryXController>().hideAddBenificiaryScreen.value ==
        false) {
      Get.find<BeneficiaryXController>().changeBenificiaryUI();
    } else {
      Get.back();
    }
  }

  double getViewHeight(BuildContext context) {
    if (totalCompanies.length > 1)
      return Get.height - 225 - MediaQuery.of(context).viewInsets.bottom - 65;
    return Get.height - 225 - MediaQuery.of(context).viewInsets.bottom;
  }

  getToken() async {
    _sharedPreferencesHelper = SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    savedCompanyId = await _sharedPreferencesHelper.getSavedCompanyId;
    getEmail();
    checkProductAvailablity();
  }

  checkProductAvailablity() async {
    Result result = await DioClient()
        .get('Product/IsProductValid?code=LIFE', token, isLoading: false);
    if (result is SuccessState) {
      if (result.value == true) {
        getProductCompanyList();
        Get.find<BeneficiaryXController>().getToken();
        Get.find<BenifitsXController>().getToken();
      } else {
        errorMessageWithAction(
            "Sorry, this service is not available at this time",
            okBtnClicked: () {
          Get.back();
          Get.back();
        });
      }
    } else if (result is ErrorState) {
      Get.back();
      errorMessage(result.msg.toString());
    }
  }

  getProductCompanyList() async {
    Result result = await DioClient()
        .get('Product/ProductCompanyList?code=LIFE', token, isLoading: false);
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
          totalCompanies.length > 0
              ? selectedCompany = totalCompanies.first.companyName
              : selectedCompany = "";
        }

        if (totalCompanies.length == 1) {
          int companyId = totalCompanies[0].companyId;
          getUpdatedToken(companyId);
        }
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
    token = await _sharedPreferencesHelper.getAccessToken;
    return email;
  }

//
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
    Get.find<BeneficiaryXController>().getToken();
    Get.find<BenifitsXController>().getToken();
  }
}
