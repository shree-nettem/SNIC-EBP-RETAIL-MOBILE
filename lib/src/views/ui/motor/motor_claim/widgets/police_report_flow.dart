import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';

import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/widgets/policy_covers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utilities/ui_constants.dart';

class PoliceReportContentView extends StatelessWidget {
  MotorClaimDetailsXController _controller = Get.find();
  MotorClaimXController claimController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
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
                isFromWindScreen: false,
              )),
          /* Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
            child: CustomLabel(
              title: MyString.accidentType,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              maxLines: 2,
            ),
          ),
          CustomDropDown(
            label: _controller.accidentType[0],
            options: _controller.accidentType,
            validator: AppFormFieldValidator.generalDropDownValidator,
            onChanged: (val) {
              AppFormFieldValidator.generalDropDownValidator(val);
            },
          ),*/
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: CustomLabel(
              title: 'accidentLocation'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              maxLines: 2,
            ),
          ),
          CustomDropDown(
            label: _controller.claimCountries[0],
            options: _controller.claimCountries,
            validator: (val) {
              return AppFormFieldValidator.generalDropDownValidator(val);
            },
            onChanged: (val) {
              _controller.selectedClaimCountry = val;
              _controller.getClaimCities();
            },
          ),
          Obx(() => Container(
                margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: CustomDropDown(
                  label: _controller.selectedAccidentTown.value,
                  options: _controller.accidentTown,
                  validator: (val) {
                    return AppFormFieldValidator.generalDropDownValidator(val);
                  },
                  onChanged: (val) {
                    _controller.selectedAccidentTown.value = val;
                  },
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: CustomLabel(
              title: 'policeReportNumber'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              maxLines: 2,
            ),
          ),
          CustomTextField(
            textController: _controller.policyReportNumber,
            labelText: '',
            hintText: 'policeReportNumber'.tr,
            validate: true,
            validator: (val) {
              return AppFormFieldValidator.generalEmptyValidator(val);
            },
            isEnabled: true,
            onChanged: (value) {},
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: CustomLabel(
              title: 'claimAgainst'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              maxLines: 2,
            ),
          ),
          CustomDropDown(
            label: _controller.selectedClainAgainst,
            options: _controller.clainAgainst,
            validator: (val) {
              return AppFormFieldValidator.generalDropDownValidator(val);
            },
            onChanged: (val) {
              _controller.setCalimAgainst(val);
            },
          ),
          Visibility(
              visible: _controller.selectedClainAgainst == "Not At Fault"
                  ? true
                  : false,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 20),
                      child: CustomLabel(
                        title: 'isOtherPartyInvolved'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      ),
                    ),
                    CustomRadioButton(
                      text: 'yes'.tr,
                      value: _controller.otherPartInvolved[0],
                      onTap: () {
                        _controller.switchPartyInvolved(0);
                      },
                    ),
                    CustomRadioButton(
                      text: 'no'.tr,
                      value: _controller.otherPartInvolved[1],
                      onTap: () {
                        _controller.switchPartyInvolved(1);
                      },
                    ),
                  ])),
          Visibility(
              visible: _controller.otherPartInvolved[1] ? true : false,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'cpr_number'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.tpCprNumber,
                      labelText: '',
                      hintText: 'cpr_number'.tr,
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'firstName'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.tpFirstName,
                      labelText: '',
                      hintText: 'firstName'.tr.replaceAll("*", ''),
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'middleName'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.tpMiddleName,
                      labelText: '',
                      hintText: 'middleName'.tr,
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'lastName'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.tpLastName,
                      labelText: '',
                      hintText: 'lastName'.tr.replaceAll("*", ''),
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'dob'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus.unfocus();
                        Utils.initialSelectDate(context, DateTime.now(),
                                DateTime(1950, 8), DateTime.now())
                            .then((value) {
                          _controller.tpDob.text = Utils.formattedDate(value);
                        });
                      },
                      child: CustomTextField(
                        isReadOnly: true,
                        textController: _controller.tpDob,
                        image: Images.date_picker,
                        validator: (val) {
                          return AppFormFieldValidator.generalEmptyValidator(
                              val);
                        },
                        isSuffix: true,
                        labelText: '',
                        hintText: 'date'.tr,
                        validate: true,
                        isEnabled: false,
                        onChanged: (value) {},
                      ),
                    ),
                    // CustomTextField(
                    //   textController: _controller.tpDob,
                    //   labelText: '',
                    //   hintText: 'dob'.tr,
                    //   validate: true,
                    //   validator: (val) {
                    //     return AppFormFieldValidator.generalEmptyValidator(val);
                    //   },
                    //   isEnabled: true,
                    //   onChanged: (value) {},
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'mobile_Number'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.tpMobileNumber,
                      textInputType: TextInputType.number,
                      keyboardInputType: InputTypeEnum.numeric,
                      labelText: '',
                      hintText: 'mobile_Number'.tr,
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'vehicleMake'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.plateNumber,
                      labelText: '',
                      hintText: 'vehicleMake'.tr,
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'vehicle_reg_num'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.tpRegistrationNumber,
                      labelText: '',
                      hintText: 'vehicle_reg_num'.tr,
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'address'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.tpAddress,
                      labelText: '',
                      hintText: 'address'.tr.replaceAll("*", ''),
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'contact_No'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.tpContactNumber,
                      textInputType: TextInputType.number,
                      keyboardInputType: InputTypeEnum.numeric,
                      labelText: '',
                      hintText: 'contact_No'.tr,
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                  ])),
          Visibility(
              visible: _controller.otherPartInvolved[0] ? true : false,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomLabel(
                      title: 'insurance_company'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomDropDown(
                      label: _controller.insuranceCompanyName,
                      options: _controller.insuranceCompanyList,
                      validator: (val) {
                        return AppFormFieldValidator.generalDropDownValidator(
                            val);
                      },
                      onChanged: (val) {
                        _controller.vehicleModel.value = "SELECT";
                        _controller.setInsuranceCompany(val);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomLabel(
                      title: 'make'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomDropDown(
                      label: _controller.vehicleMake,
                      options: _controller.vehicleMakeList,
                      validator: (val) {
                        return AppFormFieldValidator.generalDropDownValidator(
                            val);
                      },
                      onChanged: (val) {
                        _controller.vehicleMake = "SELECT";
                        _controller.setMake(val);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomLabel(
                      title: 'model'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return _controller.vehicleModel.value == "SELECT"
                          ? CustomDropDown(
                              label: _controller.vehicleModel.value,
                              options: _controller.vehicleModelList,
                              validator: (val) {
                                return AppFormFieldValidator
                                    .generalDropDownValidator(val);
                              },
                              onChanged: (val) {
                                _controller.vehicleModel.value = val;

                                _controller.setModel(val);

                                //controller.setClaim(val);
                              },
                            )
                          : CustomDropDown(
                              label: _controller.vehicleModel.value,
                              options: _controller.vehicleModelList,
                              validator: (val) {
                                return AppFormFieldValidator
                                    .generalDropDownValidator(val);
                              },
                              onChanged: (val) {
                                _controller.vehicleModel.value = val;

                                _controller.setModel(val);
                              },
                            );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    CustomLabel(
                      title: 'makeYear'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return _controller.makeYear.value == "SELECT"
                          ? CustomDropDown(
                              label: _controller.makeYear.value,
                              options: _controller.makeYearList,
                              validator: (val) {
                                return AppFormFieldValidator
                                    .generalDropDownValidator(val);
                              },
                              onChanged: (val) {
                                _controller.makeYear.value = val;
                                //controller.setClaim(val);
                              },
                            )
                          : CustomDropDown(
                              label: _controller.makeYear.value,
                              options: _controller.makeYearList,
                              validator: (val) {
                                return AppFormFieldValidator
                                    .generalDropDownValidator(val);
                              },
                              onChanged: (val) {
                                _controller.makeYear.value = val;

                                //controller.setClaim(val);
                              },
                            );
                    }),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'plateNumber'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.plateNumber,
                      labelText: '',
                      hintText: 'plateNumber'.tr,
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: CustomLabel(
                        title: 'policyNumber'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        maxLines: 2,
                      ),
                    ),
                    CustomTextField(
                      textController: _controller.policyNumber,
                      labelText: '',
                      hintText: 'policyNumber'.tr,
                      validate: true,
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
                      onChanged: (value) {},
                    ),
                  ])),
          Visibility(
              visible: _controller.otherPartInvolved[1] ? true : false,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, children: [])),
          Visibility(
              visible:
                  _controller.selectedClainAgainst == "At Fault" ? true : false,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        validator: (val) {
                          return AppFormFieldValidator.generalEmptyValidator(
                              val);
                        },
                        isSuffix: true,
                        labelText: '',
                        hintText: 'date'.tr,
                        validate: true,
                        isEnabled: false,
                        onChanged: (value) {},
                      ),
                    ),
                    Container(
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
                  ])),
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
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
                      },
                      isEnabled: true,
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
                            .then(
                                (value) => _controller.driverDob.text = value);
                      },
                      child: CustomTextField(
                        isReadOnly: true,
                        textController: _controller.driverDob,
                        image: Images.date_picker,
                        isSuffix: true,
                        labelText: '',
                        validator: (val) {
                          return AppFormFieldValidator.generalEmptyValidator(
                              val);
                        },
                        hintText: 'date'.tr,
                        validate: true,
                        isEnabled: false,
                        onChanged: (value) {},
                      ),
                    ),
                  ])),
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: CustomLabel(
              title: 'dealershipORGarage'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              maxLines: 2,
            ),
          ),
          CustomDropDown(
            label: _controller.selectedDealership,
            options: _controller.dealership,
            validator: (val) {
              return AppFormFieldValidator.generalDropDownValidator(val);
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
                firstDate: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day + days),
                lastDate: DateTime(2030),
              ).then((value) {
                DateTime selectedDate = Utils.convertStringDateToDate(value);
                debugPrint("DATE SELECTED ${selectedDate.weekday}");
                if (selectedDate.weekday == 5 || selectedDate.weekday == 6) {
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
                return AppFormFieldValidator.generalDropDownValidator(val);
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
        ],
      ),
    );
  }
}
