import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/claims/claims_inner_submit_screen.dart';
import 'package:ebpv2/src/views/ui/claims/claims_screen_controller.dart';
import 'package:ebpv2/src/views/ui/medical_claim/my_claims/my_claims_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClaimScreen extends StatelessWidget {
  final ClaimScreenXController _controller = Get.put(ClaimScreenXController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'claims'.tr,
            info: "claims_help_text".tr,
            isBackButtonExist: true,
            isActionButtonExist: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: GetBuilder(
                init: _controller,
                builder: (_) {
                  return _claimTabbarView();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _claimTabbarView() {
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
                  text: 'submitClaim'.tr,
                ),
                new Tab(
                  text: 'myClaims'.tr,
                ),
              ],
            ),
          ),
          Container(
            height: Get.height - 225,
            child: TabBarView(
              controller: _controller.tabController,
              children: [InnerSubmitClaimScreen(), MyClaimsScreen('Both')],
            ),
          )
        ],
      ),
    );
  }
}
