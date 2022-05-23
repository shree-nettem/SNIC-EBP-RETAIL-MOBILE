import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/motor/model/policy_details.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/select_vehicle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PolicyCovers extends StatelessWidget {
  PolicyDetails policyDetails;
  bool isFromWindScreen;
  PolicyCovers({@required this.policyDetails, @required this.isFromWindScreen});
  SelectVehicleXController _controller = Get.find();
  MotorClaimXController claimController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: policyDetails == null
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: CustomLabel(
                    title: 'policy_covers'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 18,
                    maxLines: 1,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'loss_Date'.tr,
                        fontFamily: Constants.FONT_SF_UI_DISPLAY,
                        fontSize: 12,
                        maxLines: 2,
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: CustomLabel(
                        title: _controller.selectedAccidentDate,
                        fontFamily: Constants.FONT_SF_UI_DISPLAY,
                        fontSize: 12,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'loss_time'.tr,
                        fontFamily: Constants.FONT_SF_UI_DISPLAY,
                        fontSize: 12,
                        maxLines: 2,
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: CustomLabel(
                        title: _controller.selectedAccidentTime,
                        fontFamily: Constants.FONT_SF_UI_DISPLAY,
                        fontSize: 12,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'make_model'.tr,
                        fontFamily: Constants.FONT_SF_UI_DISPLAY,
                        fontSize: 12,
                        maxLines: 2,
                      ),
                    ),
                    // Spacer(),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: CustomLabel(
                          textAlign: TextAlign.end,
                          title: policyDetails == null
                              ? ""
                              : '${policyDetails.vehicleMakeName}, ${policyDetails.vehicleModelName}, ${policyDetails.vehicleYear}',
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 12,
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'repair_condition'.tr,
                        fontFamily: Constants.FONT_SF_UI_DISPLAY,
                        fontSize: 12,
                        maxLines: 2,
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: CustomLabel(
                        title: policyDetails.repairCondition,
                        fontFamily: Constants.FONT_SF_UI_DISPLAY,
                        fontSize: 12,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                if (!isFromWindScreen)
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: CustomLabel(
                          title: 'depreciation_percentage'.tr.toUpperCase(),
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 12,
                          maxLines: 2,
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: CustomLabel(
                          title: '${policyDetails.additionalExcess}%',
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 12,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'deductible'.tr.toUpperCase(),
                        fontFamily: Constants.FONT_SF_UI_DISPLAY,
                        fontSize: 12,
                        maxLines: 2,
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: CustomLabel(
                        title: isFromWindScreen
                            ? 'BD ${policyDetails.windscreenExcess ?? "0"}'
                            : 'BD ${policyDetails.calculatedExcess ?? "0"}',
                        fontFamily: Constants.FONT_SF_UI_DISPLAY,
                        fontSize: 12,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                if (!claimController.isCarWindScreenSelected)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 0.0),
                        child: CustomLabel(
                          title: 'additional_deductibles'.tr.toUpperCase(),
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 12,
                          maxLines: 2,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                if (!claimController.isCarWindScreenSelected)
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
                        child: CustomLabel(
                          title: 'unknown_damage_excess'.tr,
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 10,
                          maxLines: 2,
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: CustomLabel(
                          title: 'BD ${policyDetails.unknownDamageExcess}',
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 10,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                if (!claimController.isCarWindScreenSelected)
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
                        child: CustomLabel(
                          title: 'underage_for_non_insured'.tr,
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 10,
                          maxLines: 2,
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: CustomLabel(
                          title: 'BD ${policyDetails.underageExcess}',
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 10,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                if (!claimController.isCarWindScreenSelected)
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
                        child: CustomLabel(
                          title: 'malicious_excess'.tr,
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 10,
                          maxLines: 2,
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: CustomLabel(
                          title: 'BD ${policyDetails.rsmdExcess ?? "0"}',
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 10,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                Visibility(
                  visible: policyDetails.carReplaceDays != null
                      ? (policyDetails.carReplaceDays.isNotEmpty)
                          ? true
                          : false
                      : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: CustomLabel(
                          title: 'car_replacement_days'.tr.toUpperCase(),
                          fontFamily: Constants.FONT_SF_UI_DISPLAY,
                          fontSize: 12,
                          maxLines: 2,
                        ),
                      ),
                      // Spacer(),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                          child: CustomLabel(
                            textAlign: TextAlign.end,
                            title:
                                '${policyDetails.carReplace} - ${policyDetails.carReplaceDays} Days',
                            fontFamily: Constants.FONT_SF_UI_DISPLAY,
                            fontSize: 12,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
