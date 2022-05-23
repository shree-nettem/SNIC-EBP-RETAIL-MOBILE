import '../../../../utilities/colors.dart' as Style;
import '../../../../utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/table_of_benefits/table_of_benefits_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'medical_network/medical_network_screen.dart';
import 'my_medical_e_cards/medical_e_card_screen.dart';

class GroupMedicalScreen extends StatelessWidget {
  static final pageId = "/groupMedicalScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      appBar: appBar("Welcome to Your Employee Benefits"),
      body: groupMedicalUI(),
    );
  }

  Widget groupMedicalUI() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            addVerticalHeight(20),
            _myMedicalNetworkButton(),
            addVerticalHeight(20),
            _myTableOfBenefitsButton(),
            addVerticalHeight(20),
            _myClaimsButton(),
            addVerticalHeight(20),
            _myMedicalECardsButton(),
          ],
        ),
      ),
    );
  }

  Widget _myMedicalNetworkButton() {
    return button(
      'My Medical Network',
      () => {
        Get.toNamed(MedicalNetworkScreen.pageId),
      },
      isRounded: true,
    );
  }

  Widget _myTableOfBenefitsButton() {
    return button(
      'My Table Of Benefits',
      () => {
        Get.toNamed(TableOfBenefitsScreen.pageId),
      },
      isRounded: true,
    );
  }

  Widget _myClaimsButton() {
    return button(
      'My Claims',
      () => {},
      isRounded: true,
    );
  }

  Widget _myMedicalECardsButton() {
    return button(
      'My Medical E-Cards',
      () => {
        Get.toNamed(MedicalECardScreen.pageId),
      },
      isRounded: true,
    );
  }
}
