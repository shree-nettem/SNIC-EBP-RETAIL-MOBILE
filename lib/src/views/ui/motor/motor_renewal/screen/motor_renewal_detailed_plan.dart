import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/motor/model/renew_plan_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import '../../../../../utilities/colors.dart';
import '../controller/motor_renewal_controller.dart';

class MotorRenewalDeatiledPlanScreen extends StatelessWidget {
  final MotorRenewalXController controller = Get.put(MotorRenewalXController());
  final String quotationNumber, policyIDate, modelGroup, vehicleMake, policySi;
  RenewPlanDetails detail;

  MotorRenewalDeatiledPlanScreen(this.quotationNumber, this.policyIDate,
      this.modelGroup, this.vehicleMake, this.detail, this.policySi);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'planRenewal'.tr,
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
          Row(
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
                      title: MyString.one,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              CustomLabel(
                title: 'motorInsurance'.tr,
                color: MyColors.PrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            padding: EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              color: Color(0xfffcfcfc),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Color(0x336f8693),
                    offset: Offset(0, 6),
                    blurRadius: 9,
                    spreadRadius: 0)
              ],
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0.0, top: 20, bottom: 10),
                    child: CustomLabel(
                      title: 'motorInsurance'.tr,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        bottom: 0,
                        width: 2,
                        child: Container(
                          color: MyColors.themeColor,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 18),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "policyName".tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title: controller.detail.actualPolicyName
                                          .toUpperCase(),
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "quoteNo".tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title: controller.detail.quotationNumber,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "make_model".tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title:
                                          '${this.vehicleMake} ${this.modelGroup}',
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "plateNo".tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title: controller.detail.registrationNo,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "expiryDate".tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title: Utils.formatDateTimeDisplay(
                                          controller.detail.policyExpiryDate),
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "chassisNumber".tr.toUpperCase(),
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title: controller.detail.chassisNumber,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "startDate".tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title: Utils.formatDateTimeDisplay(
                                          controller
                                              .detail.policyInceptionDate),
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "previousMotorValue".tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title:
                                          "BHD ${controller.detail.sumInsured}",
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    CustomLabel(
                                      title: "previousPremium".tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    CustomLabel(
                                      title:
                                          "BHD ${controller.detail.totalPremium}",
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              motorRenewalPlanDetails(
                                  controller.detail.planCovers),
                              Divider(
                                height: 1,
                                color: MyColors.PrimaryColor,
                              ),
                              motorRenewalSupplementaryDetails(
                                  controller.detail.optionalCovers),
                            ],
                          )),
                    ],
                  )
                ]),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            child: CustomButton(
              title: "continueBtn".tr,
              width: 120,
              height: 30,
              buttonAction: () {
                controller.getCalculatingPremium(
                    policyIDate: policyIDate,
                    quotationNumber: quotationNumber,
                    modelGroup: this.modelGroup,
                    vehicleMake: this.vehicleMake,
                    updatePremium: false,
                    policySi: this.policySi);
                //motorXController.expansionCardKey[1].currentState.collapse();
              },
            ),
          ),
        ]));
  }

  motorRenewalPlanDetails(List<EligibleUpgrade> planCovers) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(children: [
        InkWell(
          onTap: () {
            if (controller.detail.isPlanCoversExpanded) {
              controller.detail.isPlanCoversExpanded = false;
            } else {
              controller.detail.isPlanCoversExpanded = true;
            }
            controller.update();
          },
          child: Row(
            children: [
              CustomLabel(
                title: "policyBenefits".tr,
                color: MyColors.PrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              Spacer(),
              Icon(
                controller.detail.isPlanCoversExpanded
                    ? Icons.remove
                    : Icons.add,
                size: 15,
              ),
            ],
          ),
        ),
        Visibility(
          visible: controller.detail.isPlanCoversExpanded ? true : false,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: Column(
                children: List.from(planCovers.map((item) => Theme(
                    data: ThemeData(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomLabel(
                            title: item.label,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            fontSize: 12,
                            maxLines: 2,
                          ),
                          item.value == "Covered" || item.value == "Not Covered"
                              ? SvgPicture.asset(
                                  item.value == "Covered"
                                      ? Images.tick
                                      : Images.cancel,
                                  width: 12,
                                  height: 12,
                                )
                              : Flexible(
                                  child: CustomLabel(
                                    title: item.value,
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                    fontSize: 12,
                                    maxLines: 2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ],
                      ),
                    ))))),
          ),
        ),
      ]),
    );
  }

  motorRenewalSupplementaryDetails(List<EligibleUpgrade> planCovers) {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(children: [
          InkWell(
            onTap: () {
              if (controller.detail.isSupplementaryBenefitsExpanded) {
                controller.detail.isSupplementaryBenefitsExpanded = false;
              } else {
                controller.detail.isSupplementaryBenefitsExpanded = true;
              }
              controller.update();
            },
            child: Row(
              children: [
                CustomLabel(
                  title: "supplementaryBenifits".tr.toUpperCase(),
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                Spacer(),
                Icon(
                  controller.detail.isSupplementaryBenefitsExpanded
                      ? Icons.remove
                      : Icons.add,
                  size: 15,
                ),
              ],
            ),
          ),
          Visibility(
            visible: controller.detail.isSupplementaryBenefitsExpanded
                ? true
                : false,
            child: planCovers.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Column(
                        children: List.from(planCovers.map((item) => Theme(
                            data: ThemeData(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: MyColors.PrimaryColor,
                                    height: 2,
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  CustomLabel(
                                    title: item.label,
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                    fontSize: 12,
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            ))))),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CustomLabel(
                        textAlign: TextAlign.left,
                        title: "No Supplementary benefits added",
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontSize: 12,
                      ),
                    ),
                  ),
          ),
        ]));
  }
}
