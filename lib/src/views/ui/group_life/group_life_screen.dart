import 'dart:io';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/group_life/beneficiary/beneficiary_controller.dart';
import 'package:ebpv2/src/views/ui/group_life/beneficiary/beneficiary_screen.dart';
import 'package:ebpv2/src/views/ui/group_life/benefits/table_of_benefits_screen.dart';
import 'package:ebpv2/src/views/ui/group_life/group_life_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../medical_group/widgets/medical_group_custom_dropdown.dart';

class GroupLifeDashBoardScreen extends StatelessWidget {
  GroupLifeDashBoardScreen({Key key}) : super(key: key);
  GroupLifeXController _groupLifeController = Get.put(GroupLifeXController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _groupLifeController,
        builder: (cntrl) {
          return Scaffold(
            backgroundColor: MyColors.MainColor,
            resizeToAvoidBottomInset: true,
            body: ConditionalWillPopScope(
              shouldAddCallback: Platform.isAndroid ? true : false,
              onWillPop: () async {
                _groupLifeController.backActionClicked(context);
                return false;
              },
              child: CustomScrollView(
                // keyboardDismissBehavior:
                //     ScrollViewKeyboardDismissBehavior.onDrag,
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  CustomSilverBar(
                    title: "groupLife".tr,
                    info: "group_life_help_text".tr,
                    isBackButtonExist: true,
                    isActionButtonExist: true,
                    onBackClick: () {
                      _groupLifeController.backActionClicked(context);
                    },
                  ),
                  SliverFillRemaining(
                      hasScrollBody: false,
                      child: _customergroupLifeUI(context))
                ],
              ),
            ),
          );
        });
  }

  _customergroupLifeUI(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(
      //   maxHeight: double.infinity,
      // ),
      color: Colors.white,
      child: Column(
        children: [
          if (_groupLifeController.totalCompanies.length > 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: MedicalGroupCustomDropDown(
                options: _groupLifeController.totalCompaniesForDropdown,
                label: _groupLifeController.selectedCompany,
                onChanged: (value) {
                  _groupLifeController.selectedTokenFromDropDown(value);
                },
              ),
            ),
          new Container(
            child: new TabBar(
              indicatorColor: MyColors.PrimaryColor,
              labelColor: MyColors.PrimaryColor,
              unselectedLabelColor: MyColors.GrayColor,
              controller: _groupLifeController.tabController,
              tabs: [
                new Tab(
                  text: "beneficiaries".tr,
                ),
                new Tab(
                  text: "tableOfBenefits".tr,
                ),
              ],
            ),
          ),
          Container(
            height: _groupLifeController.getViewHeight(context),
            child: TabBarView(
              controller: _groupLifeController.tabController,
              children: [BeneficiaryScreen(), TableOfBenefitsScreen()],
            ),
          )
        ],
      ),
    );
  }
}
