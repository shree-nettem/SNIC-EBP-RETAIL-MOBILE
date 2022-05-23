import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/dashboard/dashboard_controller.dart';
import 'package:ebpv2/src/views/ui/medical_ecard/widgets/medical_tabbar_screen.dart';
import 'package:ebpv2/src/views/ui/medical_ecard/widgets/motor_tabbbar_scree.dart';
import 'package:ebpv2/src/views/ui/medical_ecard/medical_ecard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalEcardScreen extends StatelessWidget {
  MedicalEcardScreen({Key key}) : super(key: key);

  final MedicalEcardXController _controller =
      Get.put(MedicalEcardXController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          CustomSilverBar(
            title: "eCards".tr,
            info: "ecards_help_text".tr,
            isBackButtonExist: true,
            isActionButtonExist: true,
            onBackClick: () {
              Get.find<DashboardXController>().changeTabIndex(0);
            },
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: GetBuilder(
                init: _controller,
                builder: (_) {
                  return _eCardTabbarView();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _eCardTabbarView() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          new Container(
            color: Colors.white,
            child: new TabBar(
              indicatorColor: MyColors.PrimaryColor,
              labelColor: MyColors.PrimaryColor,
              unselectedLabelColor: MyColors.GrayColor,
              controller: _controller.tabController,
              tabs: [
                new Tab(
                  text: "medical".tr,
                ),
                new Tab(
                  text: "motor".tr,
                ),
              ],
            ),
          ),
          Container(
            height: Get.height - 225,
            child: TabBarView(
              controller: _controller.tabController,
              children: [MedicalTabbarView(), MotorTabbbarView()],
            ),
          )
        ],
      ),
    );
  }
}
