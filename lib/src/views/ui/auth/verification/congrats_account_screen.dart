import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CongratsAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: congratsView(),
      ),
    );
  }

  Widget congratsView() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(207, 215, 219, 1),
            Color.fromRGBO(255, 255, 255, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 48.0, right: 48, top: 48),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                Images.logo,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Images.check_circle,
                    height: 58,
                    width: 58,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  CustomLabel(
                    title: "Congratulations",
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  CustomLabel(
                    title: "Your account has been created",
                    fontSize: 18,
                    height: 1.8,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: CustomButton(
                      title: 'Start',
                      width: 114,
                      fontSize: 12,
                      height: 26,
                      buttonAction: () {
                        Get.offAllNamed(AppRoutes.LOGIN);
                      },
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                CustomLabel(
                  title: "©2021 SNIC insurance",
                  fontSize: 10,
                  color: Color.fromRGBO(209, 215, 219, 1),
                ),
                SizedBox(
                  height: 18,
                ),
                CustomLabel(
                  title:
                      "Licensed by the Central Bank of Bahrain as a conventional insurance firm",
                  fontSize: 10,
                  color: Color.fromRGBO(209, 215, 219, 1),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
