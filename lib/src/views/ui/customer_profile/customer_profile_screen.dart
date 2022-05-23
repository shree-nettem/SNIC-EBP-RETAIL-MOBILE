import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_inner_dependents_screen.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_inner_profile_screen.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/customer_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilities/colors.dart';

class CustomerProfileScreen extends StatelessWidget {
  final CustomerProfileController controller =
      Get.put(CustomerProfileController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'account'.tr,
            info: "customer_account_help_text".tr,
            isBackButtonExist: true,
            isActionButtonExist: true,
            onBackClick: () {
              controller.backActionClicked(fromMainMenuAccount: true);
            },
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: GetBuilder(
                init: controller,
                builder: (_) {
                  return _customerProfileUI(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _customerProfileUI(BuildContext context) {
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
              controller: controller.tabController,
              tabs: [
                new Tab(
                  text: 'profile'.tr,
                ),
                new Tab(
                  text: 'dependants'.tr,
                ),
              ],
            ),
          ),
          Container(
            height: Get.height - 255,
            child: TabBarView(
              controller: controller.tabController,
              children: [
                InnerProfileView(),
                InnerDependentsView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
