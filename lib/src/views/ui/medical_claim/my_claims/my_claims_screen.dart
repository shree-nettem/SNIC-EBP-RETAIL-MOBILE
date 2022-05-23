import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/ui/medical_claim/my_claims/my_claims_screen_controller.dart';
import 'package:ebpv2/src/views/ui/medical_group/widgets/medical_group_custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MyClaimsScreen extends StatelessWidget {
  //motor/medical/both
  String decider;

  MyClaimsScreen(this.decider, {Key key}) : super(key: key);

  final MyClaimsScreenXController _controller =
      Get.put(MyClaimsScreenXController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _controller.getMedicalClaims,
      child: VisibilityDetector(
        key: Key('myclaims-widget-key'),
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction > 0.1) _controller.getMedicalClaims();
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 10),
              child: Obx(() {
                return MedicalGroupCustomDropDown(
                  lang: _controller.lang.value,
                  isRoundedCorner: true,
                  options: decider == "Both"
                      ? _controller.bothListFilters
                      : decider == "Medical"
                          ? _controller.medicalListFilters
                          : _controller.motorListFilters,
                  label: _controller.selectedFilter.value,
                  onChanged: (val) {
                    _controller.filterChanged(val, decider);
                  },
                );
              }),
            ),
            _motoInsuranceUI(context)
          ],
        ),
      ),
    );
  }

  Widget _motoInsuranceUI(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(35.0),
      color: Colors.white,
      child: Column(
        children: [
          (_controller.totalExistingMedicalClaims != null &&
                  (decider == 'Medical' || decider == 'Both'))
              ? Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _controller.totalExistingMedicalClaims.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _titleCardItem(
                                    Images.medical_cross_icon,
                                    "medicalClaim".tr,
                                    _controller
                                        .totalExistingMedicalClaims[index]
                                        .status),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      myClaimField(
                                          "refNum".tr,
                                          _controller
                                                  .totalExistingMedicalClaims[
                                                      index]
                                                  .referenceId ??
                                              ""),
                                      myClaimField(
                                          "dateCap".tr,
                                          _controller
                                                      .totalExistingMedicalClaims[
                                                          index]
                                                      .updateDate !=
                                                  null
                                              ? DateFormat('dd-MM-yyyy').format(
                                                  _controller
                                                      .totalExistingMedicalClaims[
                                                          index]
                                                      .updateDate)
                                              : ""),
                                      myClaimField(
                                          "claimedAmount".tr,
                                          _controller
                                                      .totalExistingMedicalClaims[
                                                          index]
                                                      .currency +
                                                  " " +
                                                  _controller
                                                      .totalExistingMedicalClaims[
                                                          index]
                                                      .amount
                                                      .toString() ??
                                              ""),
                                      myClaimField(
                                          "provider".tr,
                                          _controller
                                                  .totalExistingMedicalClaims[
                                                      index]
                                                  .product
                                                  .medicalProvider ??
                                              ""),
                                      myClaimField(
                                          "iban".tr,
                                          _controller
                                                  .totalExistingMedicalClaims[
                                                      index]
                                                  .product
                                                  .iban ??
                                              "")
                                    ],
                                    // children: List.from(_controller
                                    //     .totalExistingMedicalClaims
                                    //     .map((item) => Theme(
                                    //         data: ThemeData().copyWith(
                                    //             dividerColor:
                                    //                 Colors.transparent),
                                    //         child: InkWell(
                                    //           onTap: () {
                                    //             // Get.toNamed(AppRoutes
                                    //             //     .MOTOR_RENEWAL_DETAILED_PLAN);
                                    //           },
                                    //           child:
                                    //               motorRenewelPlanItemDetails(),
                                    //         ))))),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.MY_CLAIMS_DETAILS,
                                            arguments: {
                                              'requestID': _controller
                                                  .totalExistingMedicalClaims[
                                                      index]
                                                  .requestId,
                                              'flow': 'Medical',
                                              'claimType': _controller
                                                  .claimHistoryList[index]
                                                  .claimType
                                            });
                                      },
                                      child: Obx(() => CustomTextButton(
                                            trailingIcon:
                                                !_controller.lang.value
                                                    ? Icons.keyboard_arrow_right
                                                    : Icons.keyboard_arrow_left,
                                            title: "viewDetails".tr,
                                            fontFamily: Constants
                                                .FONT_SF_UI_TEXT_REGULAR,
                                            fontSize: 12,
                                            maxLines: 2,
                                            color: MyColors.mainBackgroundColor,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                  );
                })
              : Container(),
          (_controller.claimHistoryList != null &&
                  (decider == 'Motor' || decider == 'Both'))
              ? Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _controller.claimHistoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _motorTitleCardItem(
                                    Images.car_collision,
                                    "motor_Claim".tr,
                                    _controller
                                        .claimHistoryList[index].statusCaption),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      myClaimField(
                                          "refNum".tr,
                                          _controller.claimHistoryList[index]
                                                  .claimNumber ??
                                              ""),
                                      myClaimField(
                                          "Garage_Dealership".tr.toUpperCase(),
                                          _controller.claimHistoryList[index]
                                                  .policyNumber ??
                                              ""),
                                      myClaimField(
                                          "make_model".tr,
                                          _controller.claimHistoryList[index]
                                                  .thirdPartyVehicleMake ??
                                              ""),
                                      myClaimField(
                                          "rsaProvider".tr.toUpperCase(),
                                          _controller.claimHistoryList[index]
                                                  .thirdPartyContactNumber ??
                                              "")
                                    ],
                                    // children: List.from(_controller
                                    //     .totalExistingMedicalClaims
                                    //     .map((item) => Theme(
                                    //         data: ThemeData().copyWith(
                                    //             dividerColor:
                                    //                 Colors.transparent),
                                    //         child: InkWell(
                                    //           onTap: () {
                                    //             // Get.toNamed(AppRoutes
                                    //             //     .MOTOR_RENEWAL_DETAILED_PLAN);
                                    //           },
                                    //           child:
                                    //               motorRenewelPlanItemDetails(),
                                    //         ))))),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.MY_CLAIMS_DETAILS,
                                            arguments: {
                                              'requestID': _controller
                                                  .claimHistoryList[index].id,
                                              'flow': 'Motor',
                                              'claimType': _controller
                                                  .claimHistoryList[index]
                                                  .claimType
                                            });
                                      },
                                      child: Obx(() => CustomTextButton(
                                            trailingIcon:
                                                !_controller.lang.value
                                                    ? Icons.keyboard_arrow_right
                                                    : Icons.keyboard_arrow_left,
                                            title: "viewDetails".tr,
                                            fontFamily: Constants
                                                .FONT_SF_UI_TEXT_REGULAR,
                                            fontSize: 12,
                                            maxLines: 2,
                                            color: MyColors.mainBackgroundColor,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                  );
                })
              : Container(),
          Obx(() {
            return (_controller.claimHistoryList.isEmpty &&
                    _controller.totalExistingMedicalClaims.isEmpty)
                ? Center(
                    child: CustomLabel(
                      title: 'currentlyNoClaimsAvailable'.tr,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  )
                : Container();
          })
        ],
      ),
    );
  }

  _titleCardItem(String icon, String title, int status) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.MEDICAL_CLAIM);
        },
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  children: [
                    SvgPicture.asset(icon),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: CustomLabel(
                        title: title,
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStartButton(_controller.getStatusOfClaim(status), status),
            ],
          ),
        ),
      ),
    );
  }

  myClaimField(String planName, String planDetail) {
    return Visibility(
      visible: true,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLabel(
                  title: planName,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                Flexible(
                  child: CustomLabel(
                    textAlign: TextAlign.right,
                    title: planDetail,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            Divider(
              color: MyColors.PrimaryColor,
            )
          ],
        ),
      ),
    );
  }

  /* SAVE BUTTON */
  Widget _buildStartButton(String title, int status) {
    return Center(
      child: CustomButton(
        title: title,
        width: null,
        fontSize: 12,
        height: 26,
        bgColor: _controller.getStatusColor(status),
        buttonAction: () {},
      ),
    );
  }

  _motorTitleCardItem(
      String car_collision, String tittle, String claimStatusDesc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.MEDICAL_CLAIM);
        },
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  children: [
                    SvgPicture.asset(car_collision),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: CustomLabel(
                        title: tittle,
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: CustomButton(
                  title: claimStatusDesc,
                  width: null,
                  fontSize: 12,
                  height: 26,
                  bgColor: _controller.getColorByStatus(claimStatusDesc),
                  buttonAction: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
