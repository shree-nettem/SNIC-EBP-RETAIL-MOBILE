import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/medical_claim/my_claims/my_claim_detail_controller.dart';
import 'package:ebpv2/src/views/ui/motor/model/minor_claim.dart';
import 'package:ebpv2/src/views/ui/motor/model/police_report_claim.dart';
import 'package:ebpv2/src/views/ui/motor/model/windscreen_claim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MotorClaimDetailsView extends StatelessWidget {
  MinorClaim minorClaim;
  WindScreenClaim windScreenClaim;
  PoliceReportClaim policeReportClaim;
  final MyClaimDetailXController _controller =
      Get.put(MyClaimDetailXController());
  MotorClaimDetailsView(
      {this.minorClaim, this.policeReportClaim, this.windScreenClaim});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: minorClaim != null ||
              policeReportClaim != null ||
              windScreenClaim != null
          ? true
          : false,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CustomLabel(
                      title: 'claimNumber'.tr.toUpperCase(),
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                CustomLabel(
                  multiLine: true,
                  title: minorClaim != null
                      ? minorClaim.claimNumber
                      : policeReportClaim != null
                          ? policeReportClaim.claimNumber
                          : windScreenClaim != null
                              ? windScreenClaim.claimNumber
                              : '',
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CustomLabel(
                      title: 'policyNumber'.tr.toUpperCase(),
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                CustomLabel(
                  multiLine: true,
                  title: minorClaim != null
                      ? minorClaim.policyNumber
                      : policeReportClaim != null
                          ? policeReportClaim.policyNumber
                          : windScreenClaim != null
                              ? windScreenClaim.policyNumber
                              : '',
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLabel(
                      title: 'make_model'.tr.toUpperCase(),
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                CustomLabel(
                  multiLine: true,
                  textAlign: TextAlign.end,
                  title: minorClaim != null
                      ? minorClaim.vehicleMakeModelYear
                      : policeReportClaim != null
                          ? policeReportClaim.vehicleMakeModelYear
                          : windScreenClaim != null
                              ? windScreenClaim.vehicleMakeModelYear
                              : '',
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLabel(
                      title: 'registrationNo'.tr.toUpperCase(),
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                CustomLabel(
                  multiLine: true,
                  textAlign: TextAlign.end,
                  title: minorClaim != null
                      ? minorClaim.registrationNumber
                      : policeReportClaim != null
                          ? policeReportClaim.registrationNumber
                          : windScreenClaim != null
                              ? windScreenClaim.registrationNumber
                              : '',
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CustomLabel(
                      title: 'accidentDate'.tr.toUpperCase(),
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                CustomLabel(
                  multiLine: true,
                  title: minorClaim != null
                      ? Utils.convertDateTimeDisplay(
                          minorClaim.dateOfLoss.toString())
                      : policeReportClaim != null
                          ? Utils.convertDateTimeDisplay(
                              policeReportClaim.dateOfLoss.toString())
                          : windScreenClaim != null
                              ? Utils.convertDateTimeDisplay(
                                  windScreenClaim.dateOfLoss.toString())
                              : '',
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CustomLabel(
                      title: 'status'.tr.toUpperCase(),
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                CustomLabel(
                  multiLine: true,
                  title: minorClaim != null
                      ? minorClaim.claimStatus
                      : policeReportClaim != null
                          ? policeReportClaim.claimStatus
                          : windScreenClaim != null
                              ? windScreenClaim.claimStatus
                              : '',
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          Visibility(
            visible: policeReportClaim != null || windScreenClaim != null
                ? true
                : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'claimAgainst'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.responsibility
                        : windScreenClaim != null
                            ? windScreenClaim.responsibility
                            : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CustomLabel(
                      title: 'claimType'.tr.toUpperCase(),
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                CustomLabel(
                  multiLine: true,
                  title: minorClaim != null
                      ? minorClaim.claimType
                      : policeReportClaim != null
                          ? policeReportClaim.claimType
                          : windScreenClaim != null
                              ? windScreenClaim.claimType
                              : '',
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          Visibility(
            visible: minorClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'intimationNumber'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title:
                        minorClaim != null ? minorClaim.intimationNumber : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: policeReportClaim != null || windScreenClaim != null
                ? true
                : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'Garage_Dealership'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.fixingCarLocation
                        : windScreenClaim != null
                            ? windScreenClaim.fixingCarLocation
                            : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: policeReportClaim != null || windScreenClaim != null
                ? true
                : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'surveyDate'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? Utils.convertDateTimeDisplay(
                            policeReportClaim.surveyDate.toString())
                        : windScreenClaim != null
                            ? Utils.convertDateTimeDisplay(
                                windScreenClaim.surveyDate.toString())
                            : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: windScreenClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'Description'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: windScreenClaim != null
                        ? windScreenClaim.lossDescription
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          //only police report

          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyInvolved'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.otherPartyInvolved
                            ? 'YES'
                            : 'NO'
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyName'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                      CustomLabel(
                        title: policeReportClaim != null
                            ? policeReportClaim.thirdPartyName
                            : '',
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyName
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyVehicleMake'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyVehicleMake
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyVehicleYear'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyVehicleYear
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyPlateNumber'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyPlateNumber
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyPolicyNumber'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyPolicyNumber
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyCprNumber'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyCprNumber
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyFirstName'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyFirstName
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyMiddleName'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyMiddleName
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyLastName'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyLastName
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyDateOfBirth'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyDateOfBirth
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyMobileNumber'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyMobileNumber
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyRegistrationNumber'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.registrationNumber
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyAddress'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyAddress
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: policeReportClaim != null ? true : false,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title: 'ThirdPartyContactNumber'.tr.toUpperCase(),
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomLabel(
                    multiLine: true,
                    title: policeReportClaim != null
                        ? policeReportClaim.thirdPartyContactNumber
                        : '',
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
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
            child: _controller.claimType == 'Car Windscreen claim' &&
                    _controller.windScreenClaim.claimAttachments != null
                ? Column(
                    children: List.from(_controller
                        .windScreenClaim.claimAttachments
                        .map((item) => Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: InkWell(
                              onTap: () {},
                              child: item != null
                                  ? downloadDocument(
                                      _controller.windScreenClaim.id, item)
                                  : Container(),
                            )))))
                : _controller.claimType == 'Motor claim with police report' &&
                        _controller.policeReportClaim.claimAttachments != null
                    ? Column(
                        children: List.from(_controller
                            .policeReportClaim.claimAttachments
                            .map((item) => Theme(
                                data: ThemeData()
                                    .copyWith(dividerColor: Colors.transparent),
                                child: InkWell(
                                  onTap: () {},
                                  child: item != null
                                      ? downloadDocument(
                                          _controller.policeReportClaim.id,
                                          item)
                                      : Container(),
                                )))))
                    : _controller.claimType == 'Minor Motor Claims' &&
                            _controller.minorClaim.claimAttachments != null
                        ? Column(
                            children: List.from(_controller.minorClaim.claimAttachments.map((item) => Theme(
                                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                                child: InkWell(
                                  onTap: () {},
                                  child: item != null
                                      ? downloadDocument(
                                          _controller.minorClaim.id, item)
                                      : Container(),
                                )))))
                        : Container(),
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
                    _controller.claimType == 'Car Windscreen claim'
                        ? _controller.downloadAllDocuments(
                            _controller.windScreenClaim.id,
                            _controller.windScreenClaim.claimAttachments,
                            0)
                        : _controller.claimType ==
                                'Motor claim with police report'
                            ? _controller.downloadAllDocuments(
                                _controller.policeReportClaim.id,
                                _controller.policeReportClaim.claimAttachments,
                                0)
                            : _controller.claimType == 'Minor Motor Claims'
                                ? _controller.downloadAllDocuments(
                                    _controller.minorClaim.id,
                                    _controller.minorClaim.claimAttachments,
                                    0)
                                : null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  downloadDocument(int id, ClaimAttachment item) {
    return Row(
      children: [
        CustomLabel(
          title: item.label,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        Spacer(),
        InkWell(
          onTap: () {
            _controller.downloadImage(id, item.value, true);
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
            _controller.downloadImage(id, item.value, false);
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
}
