import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/plan/model/policy_details.dart';
import 'package:ebpv2/src/views/ui/plan/plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PlanDetails extends StatelessWidget {
  final PlanXController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: 'plans'.tr,
            info: "plans_help_text".tr,
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
                  return _motorInsuranceUI(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _motorInsuranceUI(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 15.0, top: 0, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(
                    title: controller.detail.productName,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
                    decoration: new BoxDecoration(
                        color: controller
                            .colorByStatus(controller.detail.statusCaption),
                        borderRadius: BorderRadius.circular(11)),
                    child: CustomLabel(
                      title: controller.detail.statusCaption,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  /* CustomButton(
                    title: MyString.manage,
                    buttonAction: () {

                    },
                    fontSize: 12,
                  )*/
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 5, bottom: 15),
              padding: EdgeInsets.only(
                  top: 20.0, right: 20.0, left: 20.0, bottom: 10.0),
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
              child: Container(
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        CustomLabel(
                          title: 'policyNo'.tr,
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        Spacer(),
                        CustomLabel(
                          title: controller.detail.policyNumber,
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        CustomLabel(
                          title: 'make_model'.tr,
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        Spacer(),
                        CustomLabel(
                          title:
                              '${controller.detail.vehicleMake}, ${controller.detail.VehicleModelName}, ${controller.detail.vehicleYear}',
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        CustomLabel(
                          title: 'registrationNo'.tr,
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
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        CustomLabel(
                          title: 'expiryDate'.tr,
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
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        CustomLabel(
                          title: 'startDate'.tr,
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        Spacer(),
                        CustomLabel(
                          title: Utils.formatDateTimeDisplay(
                              controller.detail.policyInceptionDate),
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        CustomLabel(
                          title: 'renewMotorValue'.tr.toUpperCase(),
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        Spacer(),
                        CustomLabel(
                          title: "BHD ${controller.detail.sumInsured}",
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        CustomLabel(
                          title: 'premium'.tr.toUpperCase(),
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        Spacer(),
                        CustomLabel(
                          title: "BHD ${controller.detail.totalPremium}",
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),

                  // TO DO later we need to update this field
                  /* Container(
                        margin: EdgeInsets.fromLTRB(5,10,5,10),
                        child: Row(
                          children: [
                            CustomLabel(
                              title: MyString.claimAtFault,
                              color: MyColors.PrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            Spacer(),
                            CustomLabel(
                              title:  '0',
                              color: MyColors.PrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),*/
                ] /*List.from(controller.totalExisitingMotorPlan.map(
                        (item) => Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                    AppRoutes.MOTOR_RENEWAL_DETAILED_PLAN);
                              },
                              child: motorRenewelPlanItemDetails(),
                            ))))*/
                    ),
              )),
//TO DO later we need to add this latest activity

/*          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 5),
            child: CustomLabel(
              title: MyString.latestActivity,
              fontWeight: FontWeight.w600,
              color: MyColors.PrimaryColor,
              fontSize: 16,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 5, bottom: 15),
              padding: EdgeInsets.only(
                  top: 20.0, right: 20.0, left: 20.0, bottom: 10.0),
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
              child: Container(
                child: Column(
                  children: [
                    Column(
                        children: List.from(controller.detail.documents
                            .map((item) => Theme(
                                data: ThemeData()
                                    .copyWith(dividerColor: Colors.transparent),
                                child: InkWell(
                                  onTap: () {

                                  },
                                  child: latestActivity(),
                                ))))
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: CustomLabel(
                        title: MyString.viewMore,
                        fontWeight: FontWeight.w500,
                        color: MyColors.PrimaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),*/
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 5),
            child: CustomLabel(
              title: 'relatedDocuments'.tr,
              fontWeight: FontWeight.w600,
              color: MyColors.PrimaryColor,
              fontSize: 16,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
                children: List.from(controller.detail.documents.map((item) =>
                    Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: InkWell(
                          onTap: () {},
                          child: downloadDocument(item),
                        ))))),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: 'downloadall'.tr,
                  width: 122,
                  height: 26,
                  fontSize: 12,
                  buttonAction: () {
                    controller.downloadAllDocuments(controller.detail, 0);
                  },
                ),
              ],
            ),
          ),
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
              title: 'honda_insurance'.tr,
              color: MyColors.PrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }

  downloadDocument(Document item, {int index, BuildContext context}) {
    return Row(
      children: [
        CustomLabel(
          title: item.documentType,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        Spacer(),
        InkWell(
          onTap: () {
            controller.downloadImage(controller.detail, item, true);
          },
          child: Container(
            margin: EdgeInsets.all(15),
            child: SvgPicture.asset(
              Images.view,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.downloadImage(controller.detail, item, false);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: SvgPicture.asset(
              Images.downlaod,
            ),
          ),
        ),
      ],
    );
  }

  latestActivity() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabel(
                title: "April 12, 2021",
                color: MyColors.Border,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              SizedBox(
                height: 5,
              ),
              CustomLabel(
                title: 'claim_at_fault'.tr,
                color: MyColors.PrimaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ],
          ),
          Spacer(),
          CustomLabel(
            title: 'BHD 294',
            color: MyColors.PrimaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
