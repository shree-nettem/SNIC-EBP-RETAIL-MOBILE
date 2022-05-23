import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import '../../../../../utilities/ui_constants.dart';
import '../../../../../utilities/utils.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/my_medical_e_cards/medical_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customer_tob_model.dart';
import 'table_of_benefits_repository.dart';

class TableOfBenefitsController extends GetxController {
  var token;
  final TableOfBenefitsRepository _repository = TableOfBenefitsRepository();
  List<CustomerTOBModel> customerTOBList = [];
  List<SubSections> subSectionList = [];
  List<MedicalCardModel> medicalCardList = [];
  List<bool> isChecked;
  List<String> idList = [];

  @override
  void onInit() {
    fetchCustomerTOB();
    fetchMedicalCard();
    super.onInit();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    print("TOKEN $token");
  }

  //FETCH CUSTOMER TOB
  fetchCustomerTOB() async {
    await getToken();
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result = await _repository.getCustomerTOB(token);
    Get.back();
    if (result is SuccessState) {
      if (result.value.length > 0) {
        var data = List<CustomerTOBModel>.from(
            result.value.map((i) => CustomerTOBModel.fromJson(i)));
        customerTOBList = data;
        var header = customerTOBList.where((x) => x.title == "Header").toList();
        if (header.isNotEmpty) {
          subSectionList.addAll(header[0].subSections);
        }
        print(
            "Success Customer TOB List! " + customerTOBList.length.toString());
        print("Success Sub Section List! " + subSectionList.length.toString());
        update();
      } else {
        print("Success. But No records found!");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  //FETCH MEDICAL CARD
  fetchMedicalCard() async {
    medicalCardList = [];
    await getToken();
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result = await _repository.getMedicalCard(token);
    Get.back();
    if (result is SuccessState) {
      if (result.value.length > 0) {
        var data = List<MedicalCardModel>.from(
            result.value.map((i) => MedicalCardModel.fromJson(i)));
        medicalCardList = data;
        print("Success Medical Card Data List! " + data.length.toString());
        isChecked = List<bool>.filled(medicalCardList.length, false);
        update();
      } else {
        print("Success. But No records found!");
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  isMedicalCardChecked(bool val, index, String identityID) {
    isChecked[index] = val;
    if (val) {
      idList.add(identityID);
    } else {
      idList.removeAt(index);
    }
    print("VALUE IS " + val.toString());
    update();
  }

  //LAUNCH URL
  void launchURL() async {
    if (idList.length > 0) {
      var beneficiaries = "";
      for (String name in idList) {
        beneficiaries = beneficiaries + name;
      }
      var certificateURL = Constants.BASE_URL +
          '/Medical/GetTravelCertificate?beneficiaries=$beneficiaries';

      await canLaunch(certificateURL)
          ? await launch(certificateURL)
          : throw 'Could not launch $certificateURL';
    } else {
      debugPrint("UN-CHECKED");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
