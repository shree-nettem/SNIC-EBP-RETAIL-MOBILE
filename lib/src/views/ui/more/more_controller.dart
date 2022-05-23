import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:get/get.dart';

class MoreXController extends GetxController {
  RxBool toggleForAccount = false.obs;
  String dbemail;
  String savedBiometricemail;
  String dbpassword;
  SharedPreferencesHelper _sharedPreferencesHelper;
  @override
  void onInit() {
    super.onInit();
    _sharedPreferencesHelper = SharedPreferencesHelper();
    getUsernameAndPasswordFromDB();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String> getUsernameAndPasswordFromDB() async {
    dbemail = await _sharedPreferencesHelper.getEmail;
    savedBiometricemail = await _sharedPreferencesHelper.getBioMetricEmail;
    dbpassword = await _sharedPreferencesHelper.getPassword;

    if (dbemail == savedBiometricemail) {
      toggleForAccount.value = true;
    }

    return dbpassword;
  }

  saveBiometricLoginDetails() {
    if (!toggleForAccount.value) {
      //  SharedPreferencesHelper().setUserId(userId);
      SharedPreferencesHelper().setBioMetricEmail(dbemail);
      SharedPreferencesHelper().setBioMetricPassword(dbpassword);
      toggleForAccount.value = true;
    } else {
      SharedPreferencesHelper().removeBiometricLoginData();
      toggleForAccount.value = false;
    }
  }
}
