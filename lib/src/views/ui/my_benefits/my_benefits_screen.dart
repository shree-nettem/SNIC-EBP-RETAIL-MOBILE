import '../../../utilities/colors.dart' as Style;
import '../../../utilities/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'group_life/group_life_screen.dart';
import 'group_medical/group_medical_screen.dart';
import 'group_medical/medical_network/my_benefits_controller.dart';

class MyBenefitsScreen extends StatelessWidget {
  static final pageId = "/myBenefitsScreen";
  final MyBenefitsXController controller = Get.put(MyBenefitsXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      appBar: appBar("My Benefits"),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return groupMedicalUI();
        },
      ),
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
            Visibility(
              visible: controller.isMedicalTab,
              child: _groupMedicalButton(),
            ),
            addVerticalHeight(20),
            Visibility(
              visible: controller.isLifeTab,
              child: _groupLifeButton(),
            ),
            addVerticalHeight(20),
          ],
        ),
      ),
    );
  }

  Widget _groupMedicalButton() {
    return button(
      'Group Medical',
      () => {
        Get.toNamed(GroupMedicalScreen.pageId),
      },
      isRounded: true,
    );
  }

  Widget _groupLifeButton() {
    return button(
      'Group Life',
      () => {
        Get.toNamed(GroupLifeScreen.pageId),
      },
      isRounded: true,
    );
  }
}
