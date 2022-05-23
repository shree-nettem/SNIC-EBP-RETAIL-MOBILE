import 'package:ebpv2/src/router/app_routes.dart';

import '../../../utilities/colors.dart' as Style;
import '../../../utilities/ui_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'feedback_controller.dart';

class FeedbackScreen extends StatelessWidget {
  static final pageId = "/feedbackScreen";
  final FeedbackXController controller = Get.put(FeedbackXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return feedbackUI();
        },
      ),
    );
  }

  //FEEDBACK UI
  Widget feedbackUI() {
    return SafeArea(
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _titleUI(),
            addVerticalHeight(35.0),
            _thankYouSubHeadTextUI(
                "Thank you for using Employee Benefits Platform."),
            addVerticalHeight(20.0),
            _thankYouSubHeadTextUI("You have signed out successfully."),
            addVerticalHeight(30.0),
            _buildLoginButtonUI(),
            addVerticalHeight(30.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
              child: _thankYouSubHeadTextUI(
                  "How was your experience with our portal?"),
            ),
            addVerticalHeight(25.0),
            _feedbackIconsUI(),
          ],
        ),
      ),
    );
  }

  //APP TITLE
  Widget _titleUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: label(
        "Employee Benefits Platform",
        textAlign: TextAlign.center,
        fontSize: 28.0,
        color: Color(0xFF707070),
        maxLines: 2,
      ),
    );
  }

  //THANK YOU FOR USING
  Widget _thankYouSubHeadTextUI(String title) {
    return Container(
      child: label(
        title,
        textAlign: TextAlign.center,
        fontSize: MediumFontSize,
        color: Color(0xFF707070),
        maxLines: 2,
      ),
    );
  }

  /* LOGIN BUTTON */
  Widget _buildLoginButtonUI() {
    return Center(
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: button(
            'Log In Again',
            () => {
              Get.offAllNamed(AppRoutes.LOGIN),
            },
            isRounded: true,
          ),
        ),
      ),
    );
  }

//  FEEDBACK ICONS UI
  Widget _feedbackIconsUI() {
    return Visibility(
      visible: controller.isVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const <Widget>[
          Icon(
            MdiIcons.emoticonAngry,
            color: Style.MyColors.darkRed,
          ),
          Icon(
            MdiIcons.emoticonAngry,
            color: Colors.red,
          ),
          Icon(
            MdiIcons.emoticonNeutral,
            color: Style.MyColors.darkYellow,
          ),
          Icon(
            MdiIcons.emoticonHappy,
            color: Style.MyColors.shadeYellow700,
          ),
          Icon(
            MdiIcons.emoticon,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
