import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/auth/verification/verification_controller.dart';
import 'package:ebpv2/src/views/ui/auth/verification/widgets/confirm_mobile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileEmailVerificationScreen extends StatelessWidget {
  final VerificationXController controller = Get.put(VerificationXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'mobile_email_verification'.tr,
            isBackButtonExist: false,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: GetBuilder(
              init: controller,
              builder: (_) {
                return verificationView();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget verificationView() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 8, left: 60, right: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.PrimaryColor),
                ),
                Expanded(
                  child: Divider(
                    height: 1,
                    color: Color.fromRGBO(209, 215, 219, 1),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromRGBO(209, 215, 219, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 1,
                    color: Color.fromRGBO(209, 215, 219, 1),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromRGBO(209, 215, 219, 1),
                    ),
                  ),
                ),
              ],
            ),
            ConfirmMobileView(),
            Spacer(),
            Column(
              children: [
                CustomLabel(
                  title: 'year_snic_insurance'.tr,
                  fontSize: 10,
                  color: Color.fromRGBO(209, 215, 219, 1),
                ),
                SizedBox(
                  height: 18,
                ),
                CustomLabel(
                  title: 'licensed_by_cbb'.tr,
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
