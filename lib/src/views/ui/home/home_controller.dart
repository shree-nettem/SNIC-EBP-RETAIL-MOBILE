// import 'package:ebpv2/src/models/result_v1.dart';
import 'dart:convert';

import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/views/ui/feedback/feedback_screen.dart';
import 'package:ebpv2/src/views/ui/home/model/contact_info_model.dart';
import 'package:ebpv2/src/views/ui/home/model/pending_payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilities/ui_constants.dart';
import '../../../utilities/utils.dart';
import 'home_repository.dart';

class HomeXController extends GetxController {
  var token;
  String name;
  final HomeRepository repository = HomeRepository();
  bool isMedicalTab = false;
  bool isLifeTab = false;
  int currentPos = 0;
  List<String> imgList = [];
  PendingPayment payment;
  List<PendingPayment> pendingPaymentList = [];
  bool autoPlay = true;
  bool isLoading = false;

  ContactInfoModel contactInfo;

  @override
  void onInit() {
    checkProductMedicalValid();

    super.onInit();
  }

  @override
  void onReady() {
    getAllImages();
    super.onReady();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    name = await _sharedPreferencesHelper.getName;
    getCountryCodes();
  }

  getCountryCodes() async {
    Result result =
        await DioClient().get('Values/ContactDetails', '', isLoading: false);
    if (result is SuccessState) {
      var jsonData = ContactInfoModel.fromJson(result.value);
      contactInfo = jsonData;
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.toString());
    }
  }

  autoPlaySlider(double visibleFraction) {
    var visiblePercentage = visibleFraction * 100;

    if (visiblePercentage == 100.0) {
      autoPlay = true;
    } else {
      autoPlay = false;
    }
    update();
  }

  void checkProductMedicalValid() async {
    await getToken();
    isLoading = true;
    update();
    Result result = await repository.fetchProductValid(token, "MEDICAL");

    if (result is SuccessState) {
      isLoading = false;
      var res = result.value;
      if (res) {
        print("TRUE");
        isMedicalTab = true;
      } else {
        print("FALSE");
        isMedicalTab = false;
      }
      update();
    } else if (result is ErrorState) {
      isLoading = false;
      errorMessage(result.msg.toString());
      update();
    }
  }

  void checkProductLifeValid() async {
    await getToken();
    Result result = await repository.fetchProductValid(token, "LIFE");
    Get.back();
    if (result is SuccessState) {
      var res = result.value;
      if (res) {
        print("TRUE");
        isLifeTab = true;
      } else {
        print("FALSE");
        isLifeTab = false;
      }
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
      update();
    }
  }

  logOut() {
    Utils.showAlertDialog(Get.context, "Are you sure?", "Confirm",
        title: "Logout", cancelTitle: "Cancel", okHandler: () {
      Get.toNamed(FeedbackScreen.pageId);
    });
    update();
  }

  void changed(int index) {
    currentPos = index;
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getAllImages() async {
    Result result =
        await DioClient().get('Product/GetBanners', '', isLoading: false);
    if (result is SuccessState) {
      print(result.value);
      imgList.addAll(List<String>.from(result.value));
      getPendingPayment();
      update();
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.toString());
    }
  }

  List<String> bannersFromJson(String str) =>
      List<String>.from(json.decode(str).map((x) => x));

  void getPendingPayment() async {
    Result result = await DioClient()
        .get('Payment/GetPendingTransaction', token, isLoading: false);
    if (result is SuccessState) {
      if (result.value != null) {
        payment = PendingPayment.fromJson(result.value);
        update();
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  void getAllPaymentList() async {
    isLoading = true;
    Result result = await DioClient()
        .get('Payment/GetPendingTransactions', token, isLoading: false);
    if (result != null) if (result is SuccessState) {
      isLoading = false;
      pendingPaymentList = List<PendingPayment>.from(
          result.value.map((x) => PendingPayment.fromJson(x)));

      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  void makePayment(PendingPayment item) async {
    final result = await Get.toNamed(AppRoutes.GENERALPAYMENTVIEW,
        arguments: {"item": item});

    debugPrint("RESULT 190 $result");

    if (result != null) if (result) getAllPaymentList();
  }
}
