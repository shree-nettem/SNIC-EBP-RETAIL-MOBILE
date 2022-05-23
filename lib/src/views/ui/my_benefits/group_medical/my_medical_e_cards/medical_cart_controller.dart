import 'package:ebpv2/src/models/result_v1.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import '../../../../../utilities/ui_constants.dart';
import '../../../../../utilities/utils.dart';
import 'package:get/get.dart';

import 'medical_card_model.dart';
import 'medical_card_repository.dart';

class MedicalCartController extends GetxController {
  var token;
  final MedicalCardRepository _repository = MedicalCardRepository();
  List<MedicalCardModel> eCardList = [];

  @override
  void onInit() {
    fetchMedicalECards();
    super.onInit();
  }

  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    print("TOKEN $token");
  }

  //FETCH MEDICAL E CARDS
  fetchMedicalECards() async {
    await getToken();
    Utils.showProgressDialog(Get.context, '', 'Loading...');
    ResultV1 result = await _repository.getMedicalECards(token);
    Get.back();
    if (result is SuccessState) {
      if (result.value.length > 0) {
        var data = List<MedicalCardModel>.from(
            result.value.map((i) => MedicalCardModel.fromJson(i)));
        eCardList = data;
        print("Success Medical E Card! " + eCardList.length.toString());
        update();
      } else {
        print("Success. But No records found!");
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
