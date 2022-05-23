import 'dart:convert';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/customer_profile_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/model/country_model.dart';
import 'package:ebpv2/src/views/ui/customer_profile/model/town_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../customer_profile_model.dart';

class MailingInfoXController extends GetxController {
  TextEditingController mailRoadController,
      mailHouseController,
      addressBlockController,
      homeRoadController,
      homeHouseController,
      homeBlockController,
      homeFlatController,
      flatMailController;

  RxBool isEditing = true.obs;
  RxBool isEditClicked = false.obs;
  final formKey = GlobalKey<FormState>();
  String mailTown, homeTown;
  List<CountryResult> countries = [];
  List<String> totalTowns;
  List<String> totalBlocks;
  String selectedMailingTown = "";
  String selectedMailingBlock = "Select";
  String selectedHomeTown = "";
  String selectedhomeBlock = "Select";
  bool isMailVisible = false;
  CustomerProfileModel customerDetails;
  final CustomerProfileController profileController = Get.find();
  var token;
  SharedPreferencesHelper _sharedPreferencesHelper = SharedPreferencesHelper();
  List<TownList> townList = [];

  @override
  void onInit() {
    mailRoadController = TextEditingController();
    mailHouseController = TextEditingController();
    addressBlockController = TextEditingController();
    homeRoadController = TextEditingController();
    homeHouseController = TextEditingController();
    flatMailController = TextEditingController();
    homeFlatController = TextEditingController();
    homeBlockController = TextEditingController();

    totalBlocks = ["Select", "1211", "1311"];

    getToken();
    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    token = await _sharedPreferencesHelper.getAccessToken;
    debugPrint("TOKEN $token");
  }

  unFocus() {
    FocusScope.of(Get.context).unfocus();
  }

  void changeEditingStatus() {
    isEditing.toggle();
    isEditClicked.value = true;

    unFocus();
    update();
  }

  setData(bool isVisible) {
    if (!isMailVisible) {
      customerDetails = profileController.customerDetails;
      mailRoadController.text = customerDetails.details.mailingAddressRoad;
      mailHouseController.text = customerDetails.details.mailingAddressHouse;
      homeRoadController.text = customerDetails.details.homeAddressRoad;
      homeHouseController.text = customerDetails.details.homeAddressHouse;
      addressBlockController.text = customerDetails.details.mailingAddressBlock;

      selectedMailingTown = customerDetails.details.mailingAddressTown;
      selectedMailingBlock = customerDetails.details.mailingAddressBlock;
      flatMailController.text = customerDetails.details.mailingAddressFlat;
      homeBlockController.text = customerDetails.details.homeAddressBlock;
      selectedHomeTown = customerDetails.details.homeAddressTown;
      // homeHouseController.text = details.details.mail;
      isMailVisible = true;

      getTowns(selectedMailingTown);
      update();
    }
  }

  /* LOAD TOWN FROM THE LOCAL JSON FILE */
  getTowns(selectedMailingTown) async {
    String data = await rootBundle.loadString('assets/json/town_list.json');
    Map<String, dynamic> mapData =
        new Map<String, dynamic>.from(json.decode(data));
    townList = mapData['town_list']
        .map((data) => TownList.fromJson(data))
        .toList()
        .cast<TownList>();
    print("TOWN_NAME ${townList}");

    if (selectedMailingTown != null) {
      int i = townList.indexWhere((element) =>
          element.townName.toLowerCase() ==
          selectedMailingTown.toString().toLowerCase());
      mailTown = townList[i].townName;
    }

    if (selectedHomeTown != null) {
      int i = townList.indexWhere((element) =>
          element.townName.toLowerCase() ==
          selectedHomeTown.toString().toLowerCase());
      homeTown = townList[i].townName;
    }

    update();
  }

  /* SAVE IDENTITY INFO TO THE SERVER */
  saveMailInfo() {
    var mailInfoRequestMap = {
      "MailingAddressTown": selectedMailingTown,
      "MailingAddressBlock": selectedMailingBlock,
      "MailingAddressRoad": mailRoadController.text,
      "MailingAddressHouse": mailHouseController.text,
      "MailingAddressFlat": flatMailController.text,
      "HomeAddressTown": selectedHomeTown,
      "HomeAddressBlock": selectedHomeTown,
      "HomeAddressRoad": homeRoadController.text,
      "HomeAddressHouse": homeHouseController.text,
    };

    debugPrint("MAIL $mailInfoRequestMap");
    postMailInfo(mailInfoRequestMap);
  }

  /*  POST MAIL INFORMATION */
  postMailInfo(mailInfoRequestMap) async {
    Result result = await DioClient().post(
      'Customer/SaveProfileMailingAddress',
      mailInfoRequestMap,
      token: token,
      isPostData: true,
    );
    if (result is SuccessState) {
      updateCustomerIdentityDetails();
      successMessage("Successfully updated!");
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  /* UPDATE CUSTOMER IDENTITY DETAILS */
  updateCustomerIdentityDetails() {
    final customerDetails =
        Get.find<CustomerProfileController>().customerDetails;

    customerDetails.details.mailingAddressTown = selectedMailingTown;
    customerDetails.details.mailingAddressBlock = selectedMailingBlock;
    customerDetails.details.mailingAddressRoad = mailRoadController.text;
    customerDetails.details.mailingAddressHouse = mailHouseController.text;
    customerDetails.details.homeAddressTown = selectedHomeTown;
    customerDetails.details.homeAddressBlock = selectedhomeBlock;
    customerDetails.details.homeAddressRoad = homeRoadController.text;
    customerDetails.details.homeAddressHouse = homeHouseController.text;
    update();
  }

  @override
  void onClose() {
    mailRoadController.dispose();
    mailHouseController.dispose();
    homeRoadController.dispose();
    homeHouseController.dispose();
    flatMailController.dispose();
    homeFlatController.dispose();
    homeBlockController.dispose();
    addressBlockController.dispose();
    super.onClose();
  }
}
