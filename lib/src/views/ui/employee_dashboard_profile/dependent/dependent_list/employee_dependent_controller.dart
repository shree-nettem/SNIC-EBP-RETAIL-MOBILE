import 'package:ebpv2/src/views/ui/employee_dashboard_profile/employee/employee_dashboard_profile_response.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EmployeeDependentXController extends GetxController {
  List<Dependents> dependents = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      dependents = Get.arguments['dependents'];
      print("DEPENDENT SIZE " + dependents.length.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
