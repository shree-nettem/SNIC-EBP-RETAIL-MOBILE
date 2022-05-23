import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_horizontal_slider.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_rich_text.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/motor_plan_details_card.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/suppliment_benifits.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/controller/renew_switch_controller.dart';

import 'package:ebpv2/src/views/ui/motor/payment/widgets/payment_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../controller/motor_renewal_controller.dart';

class SwitchPlanScreen extends StatelessWidget {
  final RenewSwitchController controller = Get.find();

  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Stack(
          children: [
            Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(bottom: 5),
              height: MediaQuery.of(context).size.height / 1.85,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  controller: controller.scrollController,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: MotorPlanDetailsCardView(index: index),
                      ),
                    );
                  }),
            ),
            Visibility(
              visible: controller.isRecommendedVisible ? true : false,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 20, right: 10),
                  padding: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                  decoration: new BoxDecoration(
                    color: Color(0xff40a2be),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x666f8693),
                          offset: Offset(0, 5),
                          blurRadius: 10,
                          spreadRadius: 0)
                    ],
                  ),
                  child: CustomLabel(
                    title: 'recommended'.tr.capitalize,
                    color: Colors.white,
                    fontFamily: Constants.FONT_PROXIMA_NOVA,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
        Visibility(
          visible: !controller.isPlanSelected ? true : false,
          child: Center(
            child: HorizontalCustomalSider(
              onNextPageTap: () {
                controller.scrollToNextPage();
              },
              onPreviousPageTap: () {
                controller.scrollToPreviousPage();
              },
              pageNo: controller.pageNo,
              maxCount: 5,
            ),
          ),
        ),
        /* Visibility(
          visible: !controller.isPlanSelected ? true : false,
          child: Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                */ /*    InkWell(
                  onTap: () {
                    motorXController.expansionCardKey[1].currentState.collapse();
                  },
                  child: CustomTextButton(
                    leadingIcon: Icons.keyboard_arrow_left,
                    title: "Back",
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    maxLines: 2,
                    color: MyColors.mainBackgroundColor,
                  ),
                ),
                Spacer(),*/ /*
                CustomButton(
                  title: MyString.selectPlanBtnTxt,
                  isActive: false,
                  height: 26,
                  buttonAction: () {
                    controller.setSelectedPlan(controller.pageNo);

                    //motorXController.expansionCardKey[1].currentState.collapse();
                  },
                  bgColor: MyColors.VerticalDividerColor,
                ),
              ],
            ),
          ),
        ),*/
        SizedBox(
          height: 15,
        ),
        SupplimentBenefits(),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          height: 1,
          color: MyColors.PrimaryColor.withOpacity(0.3),
        ),
        Visibility(
          visible: controller.isPlanSelected ? false : true,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  child: PaymentDetailsScreen(
                    isDiscountVisilbe: false,
                  )),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: 1,
                color: MyColors.PrimaryColor.withOpacity(0.3),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  children: [
                    CustomLabel(
                      title: 'total'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                    ),
                    Spacer(),
                    CustomRichText(spanText1: "BHD", spanText2: "290")
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: 1,
                color: MyColors.PrimaryColor.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
