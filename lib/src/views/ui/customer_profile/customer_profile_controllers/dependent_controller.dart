import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/customer_profile_controller.dart';
import 'package:get/get.dart';

import '../customer_profile_model.dart';

class DependentXController extends GetxController {
  RxBool isFormView = false.obs;
  RxBool isEditing = false.obs;

  CustomerProfileModel dependents;

  @override
  void onInit() {
    super.onInit();
    addingDataFromApi();
  }

  void addingDataFromApi() {
    dependents = Get.find<CustomerProfileController>().getCustomerDetails();
    update();
  }

  void isEditingChanging() {
    isEditing.value = true;
    update();
  }

  void addDependentClicked() {
    isFormView.toggle();
    isEditing.value = false;
    update();
  }

  String updateRelation(int index) {
    switch (index) {
      case 1:
        return "Spouse";
        break;
      case 2:
        return "Son";
        break;
      case 3:
        return "Daughter";
        break;
      default:
        return "Unknown";
    }
  }
}
