import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_check_box.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_horizontal_slider.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/motor/model/contact_details.dart';
import 'package:ebpv2/src/views/ui/motor/model/motor_switch_plan.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/screen/plan_screen.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/controller/renew_switch_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/widgets/motor_renew_plan_details_card.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/widgets/release_letter.dart';

import 'package:ebpv2/src/views/ui/motor/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import '../../../../../utilities/colors.dart';
import '../controller/motor_renewal_controller.dart';

class SwitchPlan extends StatelessWidget {
  final MotorRenewalXController controller = Get.find();

  final RenewSwitchController switchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: "planRenewal".tr,
            info: "motor_plan_renewal_help_text".tr,
            isBackButtonExist: true,
            isActionButtonExist: true,
            onBackClick: controller.onBackPressed,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: GetBuilder(
                init: switchController,
                builder: (_) {
                  return _motoInsuranceUI(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _motoInsuranceUI(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(25.0),
        color: Colors.white,
        height: controller.isReleaseletterViewVisibile &&
                !controller.isPlanViewVisible
            ? MediaQuery.of(context).size.height * 0.5
            : MediaQuery.of(context).size.height * 1.32,
        child: Column(children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: MyColors.PrimaryColor, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: CustomLabel(
                        title: controller.isReleaseletterViewVisibile &&
                                !controller.isPlanViewVisible
                            ? MyString.two
                            : MyString.three,
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                CustomLabel(
                  title: controller.isReleaseletterViewVisibile &&
                          !controller.isPlanViewVisible
                      ? "reviewPolicy".tr
                      : controller.isPlanViewVisible
                          ? "switchPlan".tr
                          : "payment".tr,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x336f8693),
                        offset: Offset(0, 6),
                        blurRadius: 9,
                        spreadRadius: 0),
                  ]),
              child: controller.isPaymentViewVisible
                  ? Obx(() {
                      return switchController.isPlanSwitchedAndQuoteIssue.value
                          ? PaymentScreen(switchController.issedQuote,
                              MyString.renewMotorflow)
                          : Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                    })
                  : controller.isReleaseletterViewVisibile
                      ? ReleaseLetterView()
                      : controller.isPlanViewVisible
                          ? Form(
                              key: controller.formKey,
                              child: Container(
                                child: Column(children: [
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        margin: EdgeInsets.only(bottom: 5),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            controller: switchController
                                                .scrollController,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: switchController
                                                .switchPlan.result.length,
                                            itemBuilder: (context, index) {
                                              return Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  child:
                                                      MotorRenewPlanDetailsCardView(
                                                    index: index,
                                                    data: null,
                                                    switchPlan: switchController
                                                        .switchPlan,
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                      /*Visibility(
                                visible: controller
                                        .premium
                                        .data[controller.selectedIndex.value]
                                        .recommended
                                    ? switchController.isRecommendedVisible =
                                        true
                                    : switchController.isRecommendedVisible =
                                        false,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20, right: 10),
                                    padding:
                                        EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
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
                                      title: MyString.recommended.capitalize,
                                      color: Colors.white,
                                      fontFamily: Constants.FONT_PROXIMA_NOVA,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )*/
                                    ],
                                  ),
                                  Visibility(
                                    visible: !switchController.isPlanSelected
                                        ? true
                                        : false,
                                    child: Center(
                                      child: HorizontalCustomalSider(
                                        onNextPageTap: () {
                                          switchController.scrollToNextPage();
                                        },
                                        onPreviousPageTap: () {
                                          switchController
                                              .scrollToPreviousPage();
                                        },
                                        pageNo: switchController.pageNo,
                                        maxCount: switchController
                                            .switchPlan.result.length,
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
                                  Visibility(
                                    visible: switchController
                                                .switchPlan
                                                .result[switchController
                                                    .selectedIndex.value]
                                                .optionalCovers
                                                .length >
                                            0
                                        ? true
                                        : false,
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0x336f8693),
                                                  offset: Offset(0, 6),
                                                  blurRadius: 9,
                                                  spreadRadius: 0),
                                            ]),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(
                                                    left: 5, bottom: 0),
                                                child: CustomLabel(
                                                  title: 'supplementaryBenifits'
                                                      .tr,
                                                  fontFamily: Constants
                                                      .FONT_PROXIMA_NOVA,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(
                                                    left: 5, bottom: 10),
                                                child: CustomLabel(
                                                  title: 'optional'.tr,
                                                  fontFamily: Constants
                                                      .FONT_SF_UI_TEXT_MEDIUM,
                                                  fontSize: 14,
                                                  color: MyColors.GrayColor,
                                                  fontWeight: FontWeight.w400,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: switchController
                                                      .switchPlan
                                                      .result[switchController
                                                          .selectedIndex.value]
                                                      .optionalCovers
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Center(
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5.0,
                                                                  right: 5.0,
                                                                  bottom: 5.0),
                                                          child:
                                                              supplementBenefits(
                                                            switchController
                                                                .switchPlan
                                                                .result[switchController
                                                                    .selectedIndex
                                                                    .value]
                                                                .optionalCovers[index],
                                                            index: index,
                                                            context: context,
                                                          )),
                                                    );
                                                  }),
                                            ])),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 20, bottom: 20, right: 5, left: 5),
                                    height: 1,
                                    color:
                                        MyColors.PrimaryColor.withOpacity(0.3),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: CustomLabel(
                                      title: 'rsaAndReplacementOption'.tr,
                                      fontFamily: Constants.FONT_PROXIMA_NOVA,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: Obx(() {
                                      return switchController
                                                  .eligibleOption.value ==
                                              "SELECT"
                                          ? CustomDropDown(
                                              label: switchController
                                                  .eligibleOption.value,
                                              options: switchController
                                                  .eligibleUpgradeList,
                                              onChanged: (val) {
                                                switchController
                                                    .eligibleOption.value = val;
                                                switchController
                                                    .calculateTotalPremeium();
                                                switchController.update();
                                              },
                                            )
                                          : CustomDropDown(
                                              label: switchController
                                                  .eligibleOption.value,
                                              options: switchController
                                                  .eligibleUpgradeList,
                                              onChanged: (val) {
                                                switchController
                                                    .eligibleOption.value = val;
                                                switchController
                                                    .calculateTotalPremeium();
                                                switchController.update();
                                              },
                                            );
                                    }),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 20, bottom: 5),
                                          child: Row(
                                            children: [
                                              CustomLabel(
                                                title: 'basicPremium'.tr,
                                                fontFamily: Constants
                                                    .FONT_SF_UI_TEXT_REGULAR,
                                                fontSize: 14,
                                              ),
                                              Spacer(),
                                              CustomLabel(
                                                title:
                                                    'BHD${switchController.switchPlan.result[switchController.selectedIndex.value].strBasicPremium}',
                                                fontFamily: Constants
                                                    .FONT_SF_UI_TEXT_REGULAR,
                                                fontSize: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Obx(() {
                                          return switchController
                                                      .supplimentBenifitTotal
                                                      .value !=
                                                  0.0
                                              ? Visibility(
                                                  visible: switchController
                                                              .isSupplementaryBenifitsVisible &&
                                                          switchController
                                                                  .supplimentBenifitTotal
                                                                  .value >
                                                              0.0
                                                      ? true
                                                      : false,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    child: Row(
                                                      children: [
                                                        CustomLabel(
                                                          title:
                                                              'supplementaryBenifits'
                                                                  .tr,
                                                          fontFamily: Constants
                                                              .FONT_SF_UI_TEXT_REGULAR,
                                                          fontSize: 14,
                                                        ),
                                                        Spacer(),
                                                        CustomLabel(
                                                          title:
                                                              'BHD${switchController.calculateSupplementaryBenifitsTotal()}',
                                                          fontFamily: Constants
                                                              .FONT_SF_UI_TEXT_REGULAR,
                                                          fontSize: 14,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        }),
                                        Obx(() {
                                          return switchController
                                                      .policyFees.value !=
                                                  0.0
                                              ? Visibility(
                                                  visible: switchController
                                                          .isPolicyfees
                                                      ? true
                                                      : false,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    child: Row(
                                                      children: [
                                                        CustomLabel(
                                                          title:
                                                              'policyFees'.tr,
                                                          fontFamily: Constants
                                                              .FONT_SF_UI_TEXT_REGULAR,
                                                          fontSize: 14,
                                                          maxLines: 2,
                                                        ),
                                                        Spacer(),
                                                        CustomLabel(
                                                          title:
                                                              'BHD${switchController.policyFees.value.toString()}',
                                                          fontFamily: Constants
                                                              .FONT_SF_UI_TEXT_REGULAR,
                                                          fontSize: 14,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        }),
                                        Visibility(
                                          visible: switchController.isVatVisible
                                              ? true
                                              : false,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: Row(
                                              children: [
                                                CustomLabel(
                                                  title: 'vat'.tr,
                                                  fontFamily: Constants
                                                      .FONT_SF_UI_TEXT_REGULAR,
                                                  fontSize: 14,
                                                  maxLines: 2,
                                                ),
                                                Spacer(),
                                                CustomLabel(
                                                  title:
                                                      'BHD${switchController.vat.value.toStringAsFixed(3)}',
                                                  fontFamily: Constants
                                                      .FONT_SF_UI_TEXT_REGULAR,
                                                  fontSize: 14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 20.0, bottom: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomLabel(
                                                title: 'newTotal'.tr,
                                                color: MyColors.PrimaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              Spacer(),
                                              CustomLabel(
                                                title:
                                                    'BHD ${switchController.calculateTotalPremeium()}',
                                                color: MyColors.PrimaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ]),
                              ),
                            )
                          : Container()),

          /* Visibility(
            visible: switchController.isDiscountVisilbe ? true : false,
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: [
                  CustomLabel(
                    title: MyString.discounts,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                  Spacer(),
                  CustomLabel(
                    title: 'BHD10',
                    color: MyColors.requiredFieldColor,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),*/
          SizedBox(
            height: 30,
          ),
          Visibility(
            visible: controller.isPaymentViewVisible ? false : true,
            child: CustomButton(
              title: 'next'.tr,
              width: 90,
              height: 26,
              buttonAction: () {
                print(switchController.eligibleOption.value);
                // if (switchController.eligibleOption.value != "SELECT") {
                controller.updateNxtButtonClick();
                // } else {
                //   errorMessage("Please select RSA option");
                // }

                /*   */ /*switchController.getCalculatingPremium(
                    policyIDate:controller.detail.policyInceptionDate,
                    quotationNumber: controller.detail.quotationNumber,
                    policySi:controller.detail.policySumInsured);
                */ /*//motorXController.expansionCardKey[1].currentState.collapse();*/
              },
            ),
          ),
        ]));
  }

  supplementBenefits(EligibleUpgrade optionalCovers,
      {int index, BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: CustomCheckBox(
            text: optionalCovers.label,
            value: switchController != null ? optionalCovers.isSelected : false,
            onTap: () {
              switchController != null
                  ? switchController.switchSupplimentBenifits(index)
                  : null;
            },
          ),
        ),
        // Spacer(),
        SizedBox(
          width: 10,
        ),
        CustomLabel(
          textAlign: TextAlign.end,
          title: "BHD ${optionalCovers.price}",
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          maxLines: 1,
        ),
      ],
    );
  }
}
