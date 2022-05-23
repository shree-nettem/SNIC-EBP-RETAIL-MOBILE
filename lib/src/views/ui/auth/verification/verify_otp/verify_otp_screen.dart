import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/auth/verification/verify_otp/verify_otp_controller.dart';
import 'package:ebpv2/src/views/ui/auth/verification/widgets/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOTPScreen extends StatelessWidget {
  final VerifyOtpXController controller = Get.put(VerifyOtpXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: "Mobile & E-mail Verification",
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
                    color: Color.fromRGBO(209, 215, 219, 1),
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
                    color: Color.fromRGBO(209, 215, 219, 1),
                  ),
                ),
              ],
            ),
            OTPView(),
            Spacer(),
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
