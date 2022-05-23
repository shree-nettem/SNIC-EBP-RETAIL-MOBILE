import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_check_box.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/motor/model/calculating_premium_renewal_flow.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/contact_deatils_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/controller/renew_switch_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/widgets/motor_renew_plan_details_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utilities/colors.dart';
import '../controller/motor_renewal_controller.dart';

class ReviewPolicy extends StatelessWidget {
  final MotorRenewalXController controller = Get.find();

  final RenewSwitchController switchController = Get.find();
  final String policyIDate, quotationNumber, policySi;
  final CalculatingPremium premium;
  ReviewPolicy(
      this.policyIDate, this.quotationNumber, this.premium, this.policySi);
  ContactDeatilsController _contactDeatilsController =
      Get.put(ContactDeatilsController());

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
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: GetBuilder(
                init: controller,
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
        margin: EdgeInsets.all(30.0),
        color: Colors.white,
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
                        title: MyString.two,
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                CustomLabel(
                  title: "reviewPolicy".tr,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 1.1,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MotorRenewPlanDetailsCardView(
                      index: 0,
                      data: premium,
                      switchPlan: null,
                    ),
                    Visibility(
                      visible: premium.optionalCovers.length > 0 ? true : false,
                      child: Container(
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
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10, bottom: 0),
                                  child: CustomLabel(
                                    textAlign: TextAlign.start,
                                    title: 'supplementaryBenifits'.tr,
                                    fontFamily: Constants.FONT_PROXIMA_NOVA,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  // alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10, bottom: 10),
                                  child: CustomLabel(
                                    textAlign: TextAlign.start,
                                    title: 'optional'.tr,
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_MEDIUM,
                                    fontSize: 14,
                                    color: MyColors.GrayColor,
                                    fontWeight: FontWeight.w400,
                                    maxLines: 1,
                                  ),
                                ),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: premium.optionalCovers.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0,
                                                right: 0.0,
                                                bottom: 5.0),
                                            child: supplementBenefits(
                                              premium.optionalCovers[index],
                                              index: index,
                                              context: context,
                                            )),
                                      );
                                    }),
                              ])),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 10),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: CustomLabel(
                        title: "rsaAndReplacementOption".tr,
                        fontFamily: Constants.FONT_PROXIMA_NOVA,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Obx(() {
                        return controller.eligibleOption.value == "SELECT"
                            ? CustomDropDown(
                                label: controller.eligibleOption.value,
                                options: controller.eligibleUpgradeList,
                                onChanged: (val) {
                                  controller.eligibleOption.value = val;
                                  controller.calculateTotalPremeium();
                                  controller.update();
                                },
                              )
                            : CustomDropDown(
                                label: controller.eligibleOption.value,
                                options: controller.eligibleUpgradeList,
                                onChanged: (val) {
                                  controller.eligibleOption.value = val;
                                  controller.calculateTotalPremeium();
                                  controller.update();
                                },
                              );
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0, bottom: 10),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  CustomLabel(
                                    title: "basicPremium".tr,
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                    fontSize: 14,
                                  ),
                                  Spacer(),
                                  CustomLabel(
                                    title: 'BHD ${premium.strBasicPremium}',
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                            Obx(() {
                              return controller.supplimentBenifitTotal.value !=
                                      0.0
                                  ? Visibility(
                                      visible: controller
                                                  .isSupplementaryBenifitsVisible &&
                                              controller.supplimentBenifitTotal
                                                      .value >
                                                  0.0
                                          ? true
                                          : false,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        child: Row(
                                          children: [
                                            CustomLabel(
                                              title: "supplementaryBenifits".tr,
                                              fontFamily: Constants
                                                  .FONT_SF_UI_TEXT_REGULAR,
                                              fontSize: 14,
                                            ),
                                            Spacer(),
                                            CustomLabel(
                                              title:
                                                  'BHD ${controller.calculateSupplementaryBenifitsTotal()}',
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
                              return controller.policyFees.value != 0.0
                                  ? Visibility(
                                      visible: controller.isPolicyfees
                                          ? true
                                          : false,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        child: Row(
                                          children: [
                                            CustomLabel(
                                              title: "policyFees".tr,
                                              fontFamily: Constants
                                                  .FONT_SF_UI_TEXT_REGULAR,
                                              fontSize: 14,
                                              maxLines: 2,
                                            ),
                                            Spacer(),
                                            CustomLabel(
                                              title:
                                                  'BHD ${controller.policyFees.value.toString()}',
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
                              visible: controller.isVatVisible &&
                                      controller.vat.value != 0
                                  ? true
                                  : false,
                              child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "vat".tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      fontSize: 14,
                                      maxLines: 2,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title:
                                          'BHD ${controller.vat.value.toStringAsFixed(3)}',
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomLabel(
                                    title: "newTotal".tr,
                                    color: MyColors.PrimaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  Spacer(),
                                  CustomLabel(
                                    title:
                                        'BHD ${controller.calculateTotalPremeium()}',
                                    color: MyColors.PrimaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          title: "switchPlan".tr,
                          width: 120,
                          height: 26,
                          buttonAction: () {
                            switchController.getSwitchPlan(
                                quotationNumber, policyIDate, this.premium);
                            //motorXController.expansionCardKey[1].currentState.collapse();
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomButton(
                          title: "next".tr,
                          width: 90,
                          height: 26,
                          buttonAction: () {
                            if (controller.eligibleOption.value == "SELECT") {
                              errorMessage("Please select RSA option");
                            } else {
                              controller.getCalculatingPremium(
                                  policyIDate: policyIDate,
                                  quotationNumber: quotationNumber,
                                  updatePremium: true,
                                  policySi: policySi);
                            }

                            //motorXController.expansionCardKey[1].currentState.collapse();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLabel(
                      title: "needAssistance".tr,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        _contactDeatilsController
                            .getContactDetails(MyString.call);
                      },
                      child: CustomLabel(
                        title: "contactUs".tr,
                        color: MyColors.VerticalDividerColor,
                        underLine: true,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }

  supplementBenefits(EligibleUpgrade optionalCover,
      {int index, BuildContext context}) {
    return Row(
      children: [
        Flexible(
          child: CustomCheckBox(
            text: optionalCover.label,
            value: controller != null ? optionalCover.isSelected : false,
            onTap: () {
              controller != null
                  ? controller.switchSupplimentBenifits(index)
                  : null;
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        // Spacer(),
        CustomLabel(
          textAlign: TextAlign.end,
          title: "BHD ${optionalCover.price}",
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          maxLines: 1,
        ),
      ],
    );
  }
}
