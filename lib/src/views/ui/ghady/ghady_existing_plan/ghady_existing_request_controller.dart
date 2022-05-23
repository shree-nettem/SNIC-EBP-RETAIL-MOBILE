import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_existing_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GhadyExistingRequestController extends GetxController {
  String token;
  List<GhadyExistingRequestModel> ghadyRequestList = [];

  @override
  void onInit() {
    super.onInit();

    fetchGhadyRequest();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  fetchGhadyRequest() async {
    await getToken();
    Result result = await DioClient().get('Saving/GetRequests', token);
    if (result is SuccessState) {
      ghadyRequestList = (result.value as List)
          .map((data) => GhadyExistingRequestModel.fromJson(data))
          .toList();
      debugPrint("GHADY_REQUEST_LIST");
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
