import 'dart:io';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/medical_claim/my_claims/my_claims_screen.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/minor_motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/windshiled_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/submit_motor_claim_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/motor_claim_details_controller.dart';
import 'controller/select_vehicle_controller.dart';

class MotorClaim extends StatelessWidget {
  MotorClaimXController _controller = Get.put(MotorClaimXController());
  SelectVehicleXController vehicleDetailsXController =
      Get.put(SelectVehicleXController());
  MinorMotorCalimXController minorMotorClaimXController =
      Get.put(MinorMotorCalimXController());
  MotorClaimDetailsXController claimDetailsXController =
      Get.put(MotorClaimDetailsXController());

  WindScreenClaimFlowXController windScreenClaimFlowXController =
      Get.put(WindScreenClaimFlowXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: ConditionalWillPopScope(
        shouldAddCallback: Platform.isAndroid ? true : false,
        onWillPop: () async {
          _controller.onBackPressed();
          return false;
        },
        child: CustomScrollView(
          slivers: <Widget>[
            CustomSilverBar(
              title: 'claims'.tr,
              info: "motor_claims_help_text".tr,
              isBackButtonExist: true,
              isActionButtonExist: true,
              onBackClick: () {
                _controller.onBackPressed();
              },
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
      ),
    );
  }

  _claimTabbarView() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: new TabBar(
              indicatorColor: MyColors.PrimaryColor,
              labelColor: MyColors.PrimaryColor,
              unselectedLabelColor: MyColors.GrayColor,
              controller: _controller.tabController,
              tabs: [
                Tab(
                  text: 'submitClaim'.tr,
                ),
                Tab(
                  text: 'myClaims'.tr,
                ),
              ],
            ),
          ),
          Container(
            height: Get.height - 225,
            child: TabBarView(
              controller: _controller.tabController,
              children: [SubmitMotorClaimScreen(), MyClaimsScreen('Motor')],
            ),
          )
        ],
      ),
    );
  }
}
