import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/ui/dashboard/dashboard_controller.dart';
import 'package:ebpv2/src/views/ui/plan/model/plan_model.dart';
import 'package:ebpv2/src/views/ui/plan/plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utilities/dimensions.dart';
import '../../base/custom_spacer.dart';
import '../ghady/ghady_existing_plan/ghady_existing_plans_view.dart';
import '../ghady/ghady_existing_plan/ghady_existing_request_model.dart';
import '../ghady/ghady_existing_plan/widgets/ghady_retirement_item_view.dart';
import '../ghady/ghady_existing_plan/widgets/ghady_title_view.dart';
import '../ghady/ghady_saving_plan/ghady_saving_home_controller.dart';

class Plans extends StatelessWidget {
  final PlanXController controller = Get.put(PlanXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: "plans".tr,
            info: "plans_help_text".tr,
            isBackButtonExist: true,
            isActionButtonExist: true,
            onBackClick: () {
              Get.find<DashboardXController>().changeTabIndex(0);
            },
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
    return controller.isLoading
        ? Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          )
        : Container(
            color: Colors.white,
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: CustomButton(
                      svgImage: Images.filter,
                      height: 46,
                      title: 'filterPlans'.tr,
                      buttonAction: () {
                        controller.showFilterOptions();
                      },
                      width: MediaQuery.of(context).size.width),
                ),
                Visibility(
                    visible: controller.isFilterOptionVisible ? true : false,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(
                            title: 'product'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomDropDown(
                            label: controller.selectedProduct.value,
                            options: controller.productOptions,
                            validator:
                                AppFormFieldValidator.generalDropDownValidator,
                            onChanged: (val) {
                              print(val);
                              controller.selectedProduct.value = val;
                              controller.selectedStatus.value = 'All';
                              AppFormFieldValidator.generalDropDownValidator(
                                  val);
                              controller.setProductOnFilter(val);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomLabel(
                            title: 'status'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(() {
                            return controller.selectedStatus.value == 'All'
                                ? CustomDropDown(
                                    label: controller.selectedStatus.value,
                                    options: controller.statusOptions,
                                    validator: AppFormFieldValidator
                                        .generalDropDownValidator,
                                    onChanged: (val) {
                                      controller.selectedStatus.value = val;
                                      AppFormFieldValidator
                                          .generalDropDownValidator(val);
                                      controller.filterByStatus(val);
                                    },
                                  )
                                : CustomDropDown(
                                    label: controller.selectedStatus.value,
                                    options: controller.statusOptions,
                                    validator: AppFormFieldValidator
                                        .generalDropDownValidator,
                                    onChanged: (val) {
                                      controller.selectedStatus.value = val;
                                      AppFormFieldValidator
                                          .generalDropDownValidator(val);
                                      controller.filterByStatus(val);
                                    },
                                  );
                          }),
                          Container(
                            margin: EdgeInsets.only(
                                top: 20.0, bottom: 10.0, left: 5.0, right: 5.0),
                            height: 1,
                            color: MyColors.container_Bg,
                          ),
                        ],
                      ),
                    )),
                Visibility(
                  visible: controller.findIfAnyPlanIsRenewable(),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: MyColors.container_Bg,
                            offset: Offset(0, 6),
                            blurRadius: 12,
                            spreadRadius: 0)
                      ],
                    ),
                    child: Row(
                      children: [
                        CustomLabel(
                          title: 'expiringSoon'.tr,
                          color: MyColors.requiredFieldColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        Spacer(),
                        CustomButton(
                          height: 26,
                          title: 'renewtitle'.tr,
                          buttonAction: () {
                            Get.toNamed(AppRoutes.MOTOR_RENEWAL);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.findIfAnyPlanIsRenewable(),
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Visibility(
                  visible: controller.isFilterOptionVisible ? false : true,
                  child: Obx(() {
                    return controller.totalExisitingMotorPlan != null &&
                            controller.totalExisitingMotorPlan.value.length > 0
                        ? Column(
                            children: List.from(controller
                                .totalExisitingMotorPlan.value
                                .map((item) => Theme(
                                      data: ThemeData().copyWith(
                                          dividerColor: Colors.transparent),
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          padding: EdgeInsets.only(
                                              top: 20.0,
                                              right: 10.0,
                                              left: 10.0,
                                              bottom: 10.0),
                                          decoration: new BoxDecoration(
                                            color: Color(0xfffcfcfc),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0x336f8693),
                                                  offset: Offset(0, 6),
                                                  blurRadius: 9,
                                                  spreadRadius: 0)
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 0.0,
                                                      top: 0,
                                                      bottom: 10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SvgPicture.asset(
                                                        item.productName
                                                                .contains(
                                                                    'Motor')
                                                            ? Images
                                                                .motor_insurance
                                                            : Images
                                                                .ghady_insurance,
                                                        height: 14,
                                                        width: 12,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      CustomLabel(
                                                        title: item.productName,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      Spacer(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    bottom: 5.0,
                                                                    top: 5.0),
                                                            decoration: new BoxDecoration(
                                                                color: controller
                                                                    .colorByStatus(item
                                                                        .statusCaption),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            11)),
                                                            child: CustomLabel(
                                                              title: item
                                                                  .statusCaption,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          CustomLabel(
                                                            title:
                                                                '${controller.calculateRemainingDays(item)}',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily: Constants
                                                                .FONT_SF_UI_TEXT_REGULAR,
                                                            color:
                                                                MyColors.Border,
                                                            fontSize: 12,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                              Container(
                                                  child: Column(children: [
                                                Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomLabel(
                                                        title: 'make_model'.tr,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      // Spacer(),
                                                      Flexible(
                                                        child: CustomLabel(
                                                          textAlign:
                                                              TextAlign.end,
                                                          title:
                                                              '${item.vehicleMake}, ${item.modelGroup}, ${item.VehicleYear}',
                                                          color: MyColors
                                                              .PrimaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1,
                                                  color: MyColors.PrimaryColor,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomLabel(
                                                        title: 'regNo'.tr,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      // Spacer(),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: CustomLabel(
                                                            textAlign:
                                                                TextAlign.end,
                                                            title: item
                                                                .registrationNumber,
                                                            color: MyColors
                                                                .PrimaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1,
                                                  color: MyColors.PrimaryColor,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: [
                                                      CustomLabel(
                                                        title: 'exp'.tr,
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
                                                Divider(
                                                  height: 1,
                                                  color: MyColors.PrimaryColor,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: [
                                                      CustomLabel(
                                                        title: 'startDate'.tr,
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      Spacer(),
                                                      CustomLabel(
                                                        title: item.policyIDate,
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
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    child: InkWell(onTap: () {
                                                      controller.getPlanDetails(
                                                          item.policyNumber);
                                                    }, child: GetBuilder<
                                                            LocalizationController>(
                                                        builder:
                                                            (localizationController) {
                                                      return CustomTextButton(
                                                        trailingIcon: localizationController
                                                                    .locale
                                                                    .languageCode ==
                                                                'en'
                                                            ? Icons
                                                                .keyboard_arrow_right
                                                            : Icons
                                                                .keyboard_arrow_left,
                                                        title: 'viewDetails'.tr,
                                                        fontFamily: Constants
                                                            .FONT_SF_UI_TEXT_REGULAR,
                                                        fontSize: 14,
                                                        color: MyColors
                                                            .mainBackgroundColor,
                                                      );
                                                    })),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ))))
                        : controller.ghadyRequestList.length == 0
                            ? Container(
                                child: CustomLabel(
                                  title: 'noRecordFound'.tr,
                                  color: MyColors.PrimaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              )
                            : const SizedBox.shrink();
                  }),
                ),
                Visibility(
                  visible: controller.isFilterOptionVisible ? true : false,
                  child: Obx(() {
                    return controller.filteredList != null &&
                            controller.filteredList.value.length > 0
                        ? Column(
                            children: List.from(
                              controller.filteredList.value.map(
                                (item) => Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 10),
                                      padding: EdgeInsets.only(
                                          top: 20.0,
                                          right: 10.0,
                                          left: 10.0,
                                          bottom: 10.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 0.0,
                                                  top: 0,
                                                  bottom: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                    item.productName
                                                            .contains('Motor')
                                                        ? Images.motor_insurance
                                                        : Images
                                                            .ghady_insurance,
                                                    height: 14,
                                                    width: 12,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  CustomLabel(
                                                    title: item.productName,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                bottom: 5.0,
                                                                top: 5.0),
                                                        decoration: new BoxDecoration(
                                                            color: controller
                                                                .colorByStatus(item
                                                                    .statusCaption),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11)),
                                                        child: CustomLabel(
                                                          title: item
                                                              .statusCaption,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      CustomLabel(
                                                        title:
                                                            '${controller.calculateRemainingDays(item)}',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: Constants
                                                            .FONT_SF_UI_TEXT_REGULAR,
                                                        color: MyColors.Border,
                                                        fontSize: 12,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )),
                                          Container(
                                              child: Column(children: [
                                            Container(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  CustomLabel(
                                                    title: 'make_model'.tr,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                  Spacer(),
                                                  CustomLabel(
                                                    title:
                                                        '${item.vehicleMake}, ${item.modelGroup},  ${item.VehicleYear}',
                                                    color:
                                                        MyColors.PrimaryColor,
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
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  CustomLabel(
                                                    title: 'regNo'.tr,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                  Spacer(),
                                                  CustomLabel(
                                                    title:
                                                        item.registrationNumber,
                                                    color:
                                                        MyColors.PrimaryColor,
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
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  CustomLabel(
                                                    title: 'exp'.tr,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                  Spacer(),
                                                  CustomLabel(
                                                    title:
                                                        item.policyExpiryDate,
                                                    color:
                                                        MyColors.PrimaryColor,
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
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  CustomLabel(
                                                    title: 'startDate'.tr,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                  Spacer(),
                                                  CustomLabel(
                                                    title: item.policyIDate,
                                                    color:
                                                        MyColors.PrimaryColor,
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
                                          Row(
                                            children: [
                                              Spacer(),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.getPlanDetails(
                                                        item.policyNumber);
                                                  },
                                                  child: CustomTextButton(
                                                    trailingIcon:
                                                        Icons.arrow_forward_ios,
                                                    iconSize: 14,
                                                    title: 'viewDetails'.tr,
                                                    fontFamily: Constants
                                                        .FONT_SF_UI_TEXT_REGULAR,
                                                    fontSize: 14,
                                                    color: MyColors
                                                        .mainBackgroundColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                          )
                        : (controller.ghadyRequestList.length == 0)
                            ? Container(
                                child: CustomLabel(
                                title: 'noRecordFound'.tr,
                                color: MyColors.PrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ))
                            : Container();
                  }),
                ),
                Visibility(
                  visible: controller.isFilterOptionVisible ? true : false,
                  child: Obx(() {
                    return controller.selectedProduct.value == "Motor Insurance"
                        ? const Offstage()
                        : controller.filteredghadyRequestList.length > 0
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: Get.width,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      addAutomaticKeepAlives: false,
                                      addRepaintBoundaries: false,
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller
                                          .filteredghadyRequestList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        GhadyExistingRequestModel item =
                                            controller.filteredghadyRequestList
                                                .value[index];
                                        return Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(8),
                                              decoration: new BoxDecoration(
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: MyColors.GrayColor,
                                                    blurRadius: 12.0,
                                                    offset: Offset(
                                                      0.0,
                                                      6.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppRoutes
                                                          .GHADY_RETIREMENT_DETAILS,
                                                      arguments: {
                                                        "ghady_existing_plan":
                                                            item
                                                      });
                                                },
                                                child: Card(
                                                  shadowColor:
                                                      MyColors.GrayColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            26),
                                                    child: Column(
                                                      children: [
                                                        GhadyTitleView(
                                                            Images
                                                                .ghady_insurance,
                                                            'ghady_retirement'
                                                                .tr,
                                                            item.status),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        GhadyRetirementItemView(
                                                            'goal'.tr,
                                                            "${item.goal} BHD"),
                                                        GhadyRetirementItemView(
                                                            'term'.tr,
                                                            "${item.term} Years"),
                                                        GhadyRetirementItemView(
                                                            'strategy'.tr,
                                                            "${item.strategy.toInt()}"),
                                                        GhadyRetirementItemView(
                                                            'monthly'.tr,
                                                            "${item.frequencyAmount.toInt()} BHD"),
                                                        GhadyRetirementItemView(
                                                            'lumpsum'.tr,
                                                            "${item.lumpsum.toInt()} BHD"),
                                                        CustomSpacer(
                                                            value: Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'viewDetails'
                                                                        .tr,
                                                                style:
                                                                    TextStyle(
                                                                  color: MyColors
                                                                      .mainBackgroundColor,
                                                                  fontSize: 14,
                                                                ),
                                                                children: [
                                                                  WidgetSpan(
                                                                    child: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      size: 14,
                                                                      color: MyColors
                                                                          .mainBackgroundColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // index + 1 ==
                                            //         controller
                                            //             .filteredghadyRequestList
                                            //             .length
                                            //     ? Column(
                                            //         children: [
                                            //           const SizedBox(
                                            //             height: 18,
                                            //           ),
                                            //           CustomButton(
                                            //             title: 'startNewPlan'.tr,
                                            //             height: 40,
                                            //             paddingWidth: 10,
                                            //             fontSize: 12,
                                            //             width: Get.width * 0.65,
                                            //             buttonAction: () {
                                            //               GhadySavingHomeController
                                            //                   tabController =
                                            //                   Get.find();
                                            //               tabController
                                            //                   .tabController
                                            //                   .animateTo(0);
                                            //             },
                                            //           ),
                                            //         ],
                                            //       )
                                            //     : SizedBox.shrink(),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : (controller.filteredList.length > 0 &&
                                    controller.selectedStatus.value != 'All')
                                ? Container(
                                    child: CustomLabel(
                                    title: 'noRecordFound'.tr,
                                    color: MyColors.PrimaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ))
                                : Container();
                  }),
                ),
              ],
            ),
          );
  }

  motorRenewelPlanItemDetails(PolicySearch item) {
    return Visibility(
      visible: true,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: [
            CustomLabel(
              title: item.productName,
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
