import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_saving_home_controller.dart';
import '../../ghady_existing_plan/ghady_existing_plans_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'ghady_start_saving_home_controller.dart';
import 'ghady_start_saving_tab_one.dart';

class GhadyStartSavingHomeView extends StatelessWidget {
  final GhadyStartSavingHomeXController controller =
      Get.put(GhadyStartSavingHomeXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'ghady_saving_plan'.tr,
            info: "ghady_help_text".tr,
            isBackButtonExist: true,
            isActionButtonExist: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: GetBuilder(
                init: controller,
                builder: (_) {
                  return GhadySavingHomeView();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GhadySavingHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GhadySavingHomeTabView(),
      ],
    );
  }
}

class GhadySavingHomeTabView extends StatelessWidget {
  final GhadySavingHomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Container(
          color: Colors.white,
          child: new TabBar(
            indicatorColor: MyColors.PrimaryColor,
            labelColor: MyColors.PrimaryColor,
            unselectedLabelColor: MyColors.GrayColor,
            controller: controller.tabController,
            tabs: [
              new Tab(
                text: 'Ghady',
              ),
              new Tab(
                text: 'Existing Plans',
              ),
            ],
          ),
        ),
        Container(
          height: Get.height - 255,
          child: TabBarView(
            controller: controller.tabController,
            children: [
              GhadyStartSavingTabOne(),
              GhadyExistingPlansView(),
            ],
          ),
        )
      ],
    );
  }
}
