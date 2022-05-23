import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';
import 'controller/motor_renewal_controller.dart';

class MotorRenewalScreen extends StatelessWidget {
  final MotorRenewalXController controller = Get.put(MotorRenewalXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: CustomScrollView(
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
      ),
    );
  }

  Widget _motoInsuranceUI(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30.0),
      color: Colors.white,
      child: Column(
        children: [
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
                      title: "1",
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              CustomLabel(
                title: 'selectPlanTOReview'.tr,
                color: MyColors.PrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ],
          ),
          Obx(() {
            return controller.totalExisitingMotorPlan != null &&
                    controller.totalExisitingMotorPlan.value.length > 0
                ? Column(
                    children: List.from(
                        controller.totalExisitingMotorPlan.map((item) => Theme(
                              data: ThemeData()
                                  .copyWith(dividerColor: Colors.transparent),
                              child: Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 10),
                                  padding: EdgeInsets.all(20.0),
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
                                  child: InkWell(
                                    onTap: () {
                                      controller.getRenewablePlanDetails(
                                          item.proposalNumber,
                                          item.policyIDate,
                                          item.modelGroup,
                                          item.vehicleMake,
                                          item.policySi,
                                          item.policyPartyName);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 0.0, top: 0, bottom: 10),
                                          child: CustomLabel(
                                            title: 'motorInsurance'.tr,
                                            color: MyColors.PrimaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Stack(children: [
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
                                              margin: EdgeInsets.only(left: 10),
                                              child: Column(children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10.0,
                                                      top: 10.0,
                                                      bottom: 10.0),
                                                  child: Row(
                                                    children: [
                                                      CustomLabel(
                                                        title: 'policyName'.tr,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      Spacer(),
                                                      CustomLabel(
                                                        title: item.productName,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                      right: 10.0,
                                                      top: 10.0,
                                                      bottom: 10.0),
                                                  child: Row(
                                                    children: [
                                                      CustomLabel(
                                                        title: 'quoteNo'.tr,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      Spacer(),
                                                      CustomLabel(
                                                        title:
                                                            item.proposalNumber,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                      right: 10.0,
                                                      top: 10.0,
                                                      bottom: 10.0),
                                                  child: Row(
                                                    children: [
                                                      CustomLabel(
                                                        title: 'make_model'.tr,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      Spacer(),
                                                      CustomLabel(
                                                        title:
                                                            '${item.vehicleMake} ${item.modelGroup}',
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                      right: 10.0,
                                                      top: 10.0,
                                                      bottom: 10.0),
                                                  child: Row(
                                                    children: [
                                                      CustomLabel(
                                                        title: 'plateNo'.tr,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      Spacer(),
                                                      CustomLabel(
                                                        title: item
                                                            .registrationNumber,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                      right: 10.0,
                                                      top: 10.0,
                                                      bottom: 10.0),
                                                  child: Row(
                                                    children: [
                                                      CustomLabel(
                                                        title: 'expiryDate'.tr,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      Spacer(),
                                                      CustomLabel(
                                                        title: item
                                                            .policyExpiryDate,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ] /*List.from(controller
                                                  .totalExisitingMotorPlan
                                                  .map((item) => Theme(
                                                      data: ThemeData().copyWith(
                                                          dividerColor: Colors
                                                              .transparent),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.toNamed(AppRoutes
                                                              .MOTOR_RENEWAL_DETAILED_PLAN);
                                                        },
                                                        child:
                                                            motorRenewelPlanItemDetails(
                                                                item),
                                                      ))))),*/
                                                  )),
                                        ]),
                                      ],
                                    ),
                                  )),
                            ))))
                : Container();
          }),
        ],
      ),
    );
  }

  motorRenewelPlanItemDetails() {
    return Visibility(
      visible: true,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: [
            CustomLabel(
              title: 'policyName'.tr,
              color: MyColors.PrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            Spacer(),
            CustomLabel(
              title: 'Honda Insurance',
              color: MyColors.PrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
