import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/widgets/motor_claim_details_view.dart';
import 'package:ebpv2/src/views/ui/medical_claim/my_claims/my_claim_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyClaimsDetailView extends StatelessWidget {
  MyClaimsDetailView({Key key}) : super(key: key);
  final MyClaimDetailXController _controller =
      Get.put(MyClaimDetailXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: _controller.flow == 'Medical'
                ? "medicalClaim".tr
                : 'motor_claim'.tr,
            isBackButtonExist: true,
            isActionButtonExist: false,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
                color: Colors.white, child: _myClaimDetailBody(context)),
          )
        ],
      ),
    );
  }

  _myClaimDetailBody(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (cntrlr) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabel(
                        fontSize: 18,
                        title: _controller.flow == 'Medical'
                            ? "medicalClaim".tr
                            : 'motor_claim'.tr,
                        fontFamily: Constants.FONT_PROXIMA_NOVA,
                      ),
                      _controller.medicalClaims != null &&
                              _controller.flow == 'Medical'
                          ? _buildCancelButton(
                              _controller.getStatusOfClaim(
                                  _controller.medicalClaims.status ?? 0),
                              status: _controller.medicalClaims.status)
                          : _controller.flow == 'Motor'
                              ? _buildCancelButton(
                                  _controller.policeReportClaim != null
                                      ? _controller
                                          .policeReportClaim.statusCaption
                                      : _controller.minorClaim != null
                                          ? _controller.minorClaim.statusCaption
                                          : _controller.windScreenClaim != null
                                              ? _controller
                                                  .windScreenClaim.statusCaption
                                              : "")
                              : Container()
                    ],
                  ),
                ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 2,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: _controller.medicalClaims != null &&
                                _controller.flow == 'Medical'
                            ? Column(
                                children: [
                                  _marketDetailView(
                                      "refNum".tr,
                                      _controller.medicalClaims.referenceId ??
                                          ""),
                                  _marketDetailView(
                                      "dateCap".tr,
                                      _controller.medicalClaims.updateDate !=
                                              null
                                          ? DateFormat('dd-MM-yyyy').format(
                                              _controller
                                                  .medicalClaims.updateDate)
                                          : ""),
                                  _marketDetailView(
                                      "claimedAmount".tr,
                                      _controller.medicalClaims.currency +
                                              " " +
                                              _controller.medicalClaims.amount
                                                  .toString() ??
                                          ""),
                                  _marketDetailView(
                                      "provider".tr,
                                      _controller.medicalClaims.product
                                              .medicalProvider ??
                                          ""),
                                  _marketDetailView(
                                      "iban".tr,
                                      _controller.medicalClaims.product.iban ??
                                          "",
                                      isLast: true)
                                ],
                              )
                            : _controller.flow == 'Motor' &&
                                    (_controller.policeReportClaim != null ||
                                        _controller.minorClaim != null ||
                                        _controller.windScreenClaim != null)
                                ? Column(
                                    children: [
                                      _controller.claimType ==
                                              'Car Windscreen claim'
                                          ? MotorClaimDetailsView(
                                              windScreenClaim:
                                                  _controller.windScreenClaim)
                                          : _controller.claimType ==
                                                  'Motor claim with police report'
                                              ? MotorClaimDetailsView(
                                                  policeReportClaim: _controller
                                                      .policeReportClaim)
                                              : _controller.claimType ==
                                                      'Minor Motor Claims'
                                                  ? MotorClaimDetailsView(
                                                      minorClaim: _controller
                                                          .minorClaim)
                                                  : Container(),
                                    ],
                                  )
                                : Container()),
                  ),
                ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
              ],
            ),
          );
        });
  }

  _marketDetailView(String planName, String planDetail, {bool isLast = false}) {
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
            if (!isLast)
              Divider(
                color: MyColors.PrimaryColor,
              )
          ],
        ),
      ),
    );
  }

  _lastActivityItem() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: CustomLabel(
              title: "June 28, 2021",
              color: MyColors.GrayColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: CustomLabel(
              title: 'Claim cancellation',
              color: MyColors.PrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Divider(
            color: MyColors.PrimaryColor,
          )
        ],
      ),
    );
  }

  // /* ADD NEW DEPENDET BUTTON */
  // Widget _viewClaimsButton(
  //   BuildContext context,
  //   String title,
  // ) {
  //   return Center(
  //     child: CustomButton(
  //       title: title,
  //       width: 100,
  //       fontSize: 12,
  //       paddingWidth: 10,
  //       height: 40,
  //       buttonAction: () {
  //         // Get.toNamed(AppRoutes.EDIT_CLAIMS_DETAILS);
  //       },
  //     ),
  //   );
  // }

  Widget _buildCancelButton(String title, {int status = 0}) {
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
}
