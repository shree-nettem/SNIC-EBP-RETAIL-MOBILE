import 'dart:io';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/medical_group/network/medical_group_network_screen.dart';
import 'package:ebpv2/src/views/ui/medical_group/medical_group_screen_controller.dart';
import 'package:ebpv2/src/views/ui/medical_group/tob/medical_table_of_benefits.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/medical_group_custom_dropdown.dart';

class MedicalGroupScreen extends StatelessWidget {
  MedicalGroupScreen({Key key}) : super(key: key);

  final MedicalGroupScreenXController _controller =
      Get.put(MedicalGroupScreenXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: ConditionalWillPopScope(
        onWillPop: () async {
          _controller.onBackClicked();
          return false;
        },
        shouldAddCallback: Platform.isAndroid ? true : false,
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            CustomSilverBar(
              title: "medical".tr,
              info: "group_medical_help_text".tr,
              isBackButtonExist: true,
              isActionButtonExist: true,
              onBackClick: () {
                _controller.onBackClicked();
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: Colors.white,
                child: GetBuilder(
                  init: _controller,
                  builder: (_) {
                    return _medicalTabbarView(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _medicalTabbarView(BuildContext context) {
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
                  text: "tableOfBenefits".tr,
                ),
                new Tab(
                  text: "network".tr,
                ),
              ],
            ),
          ),
          Container(
            height: _controller.getViewHeight(context),
            child: TabBarView(
              controller: _controller.tabController,
              children: [
                MedicalTableOfBenefits(),
                MedicalGroupNetworkScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
