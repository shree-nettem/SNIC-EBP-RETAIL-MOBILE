import '../../../../utilities/colors.dart' as Style;
import '../../../../utilities/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GroupLifeScreen extends StatelessWidget {
  static final pageId = "/groupLifeScreen";

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
            _groupMedicalButton(),
            addVerticalHeight(20),
            _groupLifeButton(),
            addVerticalHeight(20),
            _groupLifeButton(),
            addVerticalHeight(20),
            _groupLifeButton(),
          ],
        ),
      ),
    );
  }

  Widget _groupMedicalButton() {
    return button(
      'Group Medical',
      () => {},
      isRounded: true,
    );
  }

  Widget _groupLifeButton() {
    return button(
      'Group Life',
      () => {},
      isRounded: true,
    );
  }
}
