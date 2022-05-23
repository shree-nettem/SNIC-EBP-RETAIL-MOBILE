import 'package:ebpv2/src/views/ui/dashboard/dashboard_controller.dart';
import 'package:ebpv2/src/views/ui/home/home_controller.dart';
import 'package:ebpv2/src/views/ui/more/more_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardXController>(() => DashboardXController());
    Get.lazyPut(() => HomeXController());
    Get.lazyPut(() => MoreXController());
  }
}
