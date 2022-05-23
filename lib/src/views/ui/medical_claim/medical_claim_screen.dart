import 'dart:io';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/medical_claim/medical_claim_screen_controller.dart';
import 'package:ebpv2/src/views/ui/medical_claim/my_claims/my_claims_screen.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/submit_claim_screen.dart';
import 'package:ebpv2/src/views/ui/medical_group/widgets/medical_group_custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'submit_claim/submit_claim_screen_controller.dart';

class MedicalClaimScreen extends StatelessWidget {
  MedicalClaimScreen({Key key}) : super(key: key);
  final MedicalClaimScreenXController _controller =
      Get.put(MedicalClaimScreenXController());
  final SubmitClaimScreenXController submitController =
      Get.put(SubmitClaimScreenXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: ConditionalWillPopScope(
        shouldAddCallback: Platform.isAndroid ? true : false,
        onWillPop: () async {
          _controller.backButtonClicked();
          return false;
        },
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            CustomSilverBar(
              title: "claims".tr,
              info: "claims_help_text".tr,
              isBackButtonExist: true,
              isActionButtonExist: true,
              onBackClick: () {
                _controller.backButtonClicked();
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: Colors.white,
                child: GetBuilder(
                  init: _controller,
                  builder: (_) {
                    return _claimTabbarView(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _claimTabbarView(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          if (_controller.totalCompanies.length > 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: MedicalGroupCustomDropDown(
                options: _controller.totalCompaniesForDropdown,
                label: _controller.selectedCompany,
                onChanged: (value) {
                  _controller.selectedTokenFromDropDown(value);
                },
              ),
            ),
          new Container(
            color: Colors.white,
            child: new TabBar(
              indicatorColor: MyColors.PrimaryColor,
              labelColor: MyColors.PrimaryColor,
              unselectedLabelColor: MyColors.GrayColor,
              controller: _controller.tabController,
              tabs: [
                new Tab(
                  text: "submitClaim".tr,
                ),
                new Tab(
                  text: "myClaims".tr,
                ),
              ],
            ),
          ),
          Container(
            height: _controller.getViewHeight(context),
            child: TabBarView(
              controller: _controller.tabController,
              children: [SubmitClaimScreen(), MyClaimsScreen('Medical')],
            ),
          )
        ],
      ),
    );
  }
}
