import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/windshiled_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/widgets/policy_covers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utilities/ui_constants.dart';

class WindScreenCalimFlow extends StatelessWidget {
  MotorClaimXController claimController = Get.find();
  WindScreenClaimFlowXController _controller = Get.find();
  MotorClaimDetailsXController motorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
      child: Container(
        margin: EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.VerticalDividerColor,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Color(0xffcfd7db), Color(0xffffffff)],
                    stops: [0, 1],
                    begin: Alignment(0.42, 0.91),
                    end: Alignment(-0.42, -0.91),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x336f8693),
                        offset: Offset(0, 5),
                        blurRadius: 12,
                        spreadRadius: 0)
                  ],
                ),
                child: PolicyCovers(
                  policyDetails: _controller.controller.policyDetails,
                  isFromWindScreen: true,
                )),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
              child: CustomLabel(
                title: 'otherPartyInvolved'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                maxLines: 2,
              ),
            ),
            CustomRadioButton(
              text: 'yes'.tr,
              value: _controller.otherPartInvolved[0],
              onTap: () {
                _controller.switchPartyInvolved(0, claimController);
              },
            ),
            CustomRadioButton(
              text: 'no'.tr,
              value: _controller.otherPartInvolved[1],
              onTap: () {
                _controller.switchPartyInvolved(1, claimController);
              },
            ),
            /* Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: CustomLabel(
                title: 'driverType'.tr,
                fontWeight: FontWeight.w500,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                maxLines: 2,
              ),
            ),
            CustomRadioButton(
              text: 'policyHolder'.tr,
              value: _controller.driverType[0],
              onTap: () {
                _controller.switchDrivertype(0, claimController);
              },
            ),
            CustomRadioButton(
              text: 'notPolicyHolder'.tr,
              value: _controller.driverType[1],
              onTap: () {
                _controller.switchDrivertype(1, claimController);
              },
            ),
            Visibility(
              visible: _controller.driverType[1] ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: CustomLabel(
                      title: 'driverName'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      maxLines: 2,
                    ),
                  ),
                  CustomTextField(
                    textController: _controller.driverName,
                    labelText: '',
                    hintText: 'driverName'.tr,
                    validate: true,
                    isEnabled: false,
                    onChanged: (value) {},
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                    child: CustomLabel(
                      title: 'driverDob'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Utils.selectDate(context, DateTime.now(),
                              lastDate: DateTime.now(),
                              firstDate: DateTime(1800))
                          .then((value) => _controller.driverDob.text = value);
                    },
                    child: CustomTextField(
                      isReadOnly: true,
                      textController: _controller.driverDob,
                      image: Images.date_picker,
                      isSuffix: true,
                      labelText: '',
                      hintText: 'date'.tr,
                      validate: true,
                      isEnabled: false,
                      onChanged: (value) {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                    child: CustomLabel(
                      title: 'licenseIssueDate'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Utils.selectDate(context, DateTime.now(),
                              lastDate: DateTime.now(),
                              firstDate: DateTime(1800))
                          .then((value) =>
                              _controller.licenseIssueDate.text = value);
                    },
                    child: CustomTextField(
                      isReadOnly: true,
                      textController: _controller.licenseIssueDate,
                      image: Images.date_picker,
                      isSuffix: true,
                      labelText: '',
                      hintText: 'date'.tr,
                      validate: true,
                      isEnabled: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: CustomLabel(
                title: 'accidentDetails'.tr,
                fontWeight: FontWeight.w500,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                maxLines: 2,
              ),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: MyColors.container_Bg, width: 1),
                  color: Colors.white),
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                    controller: _controller.description,
                    decoration: new InputDecoration.collapsed(
                      hintText: "Describe the accident",
                      hintStyle: TextStyle(color: MyColors.Border),
                    ),
                    style: const TextStyle(
                        color: MyColors.GrayColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    cursorHeight: 20,
                    textAlign: TextAlign.left),
              ),
            )*/

            Visibility(
              visible: _controller.otherPartInvolved[0] ? true : false,
              child: Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Kindly report your claim via ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                color: MyColors.PrimaryColor)),
                        TextSpan(
                            text: "‘Minor claim section’",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                color: MyColors.turquoise)),
                        TextSpan(
                            text: " or with ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                color: MyColors.PrimaryColor)),
                        TextSpan(
                            text: "‘Police report’",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                color: MyColors.turquoise)),
                      ],
                    ),
                  )),
            ),
            Visibility(
              visible: _controller.otherPartInvolved[1] ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: CustomLabel(
                      title: 'dealershipORGarage'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      maxLines: 2,
                    ),
                  ),
                  CustomDropDown(
                    label: motorController.selectedDealership,
                    options: motorController.dealership,
                    validator: (val) {
                      return AppFormFieldValidator.generalDropDownValidator(
                          val);
                    },
                    onChanged: (val) {
                      _controller.selectedDealership = val;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                    child: CustomLabel(
                      title: 'surveyDate'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      int days = claimController.surveyDays + 1;
                      DateTime defaultDateTime = DateTime.now();
                      if (defaultDateTime.weekday == 5) {
                        days = days + 2;
                      } else if (defaultDateTime.weekday == 6) {
                        days = days + 1;
                      } else {
                        DateTime defaultDT = DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day + days);
                        if (defaultDT.weekday == 6) {
                          days = days + 1;
                        } else if (defaultDT.weekday == 5) {
                          days = days + 2;
                        }
                      }
                      Utils.selectDateAddDays(
                        context,
                        DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day + days),
                        firstDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day + days),
                        lastDate: DateTime(2030),
                      ).then((value) {
                        DateTime selectedDate =
                            Utils.convertStringDateToDate(value);
                        debugPrint("DATE SELECTED ${selectedDate.weekday}");
                        if (selectedDate.weekday == 5 ||
                            selectedDate.weekday == 6) {
                          errorMessage('please_select_weekdays'.tr);
                        } else {
                          _controller.surveyDate.text = value;
                        }
                      });
                    },
                    child: CustomTextField(
                      isReadOnly: true,
                      textController: _controller.surveyDate,
                      image: Images.date_picker,
                      isSuffix: true,
                      labelText: '',
                      validator: (val) {
                        return AppFormFieldValidator.generalDropDownValidator(
                            val);
                      },
                      hintText: 'date'.tr,
                      validate: true,
                      isEnabled: false,
                      onChanged: (value) {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: CustomLabel(
                      title: 'surveyNote'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: CustomLabel(
                      title: 'accidentDetails'.tr,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: MyColors.container_Bg, width: 1),
                          color: Colors.white),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: TextField(
                            controller: _controller.description,
                            decoration: new InputDecoration.collapsed(
                              hintText: "Describe the accident",
                              hintStyle: TextStyle(color: MyColors.Border),
                            ),
                            style: const TextStyle(
                                color: MyColors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            cursorHeight: 20,
                            textAlign: TextAlign.left),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
