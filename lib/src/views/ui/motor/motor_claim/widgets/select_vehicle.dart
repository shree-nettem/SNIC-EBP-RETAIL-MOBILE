import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/select_vehicle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SelectVehicle extends StatelessWidget {
  bool isFromWindScreen;
  SelectVehicle({@required this.isFromWindScreen});
  MotorClaimXController motorClainControlller = Get.find();

  SelectVehicleXController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return !_controller.isNextButtonClicked
              ? VisibilityDetector(
                  key: Key('Select_vehicle_time'),
                  onVisibilityChanged: (visibilityInfo) {
                    _controller.accidentDateController.clear();
                    _controller.selectedTime.clear();
                  },
                  child: Form(
                      key: _controller.formFieldKey,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 210,
                                    width: 2,
                                    color: MyColors.themeColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: Container(
                                      // margin: EdgeInsets.only(left: 15),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 10, top: 10),
                                              child: CustomLabel(
                                                title:
                                                    'enterAccidentDatetime'.tr,
                                                fontFamily: Constants
                                                    .FONT_SF_UI_TEXT_REGULAR,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 10, top: 5),
                                              child: CustomLabel(
                                                title: 'accidentDate'.tr,
                                                fontFamily: Constants
                                                    .FONT_SF_UI_TEXT_REGULAR,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Utils.selectDate(
                                                        context, DateTime.now(),
                                                        lastDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime(
                                                            DateTime.now()
                                                                    .year -
                                                                1))
                                                    .then((value) {
                                                  _controller
                                                      .accidentDateController
                                                      .text = value;
                                                  _controller
                                                          .selectedAccidentDate =
                                                      value;
                                                });
                                              },
                                              child: CustomTextField(
                                                isReadOnly: true,
                                                textController: _controller
                                                    .accidentDateController,
                                                image: Images.date_picker,
                                                validator: (val) {
                                                  return AppFormFieldValidator
                                                      .generalEmptyValidator(
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
                                              margin: EdgeInsets.only(
                                                  top: 20.0, bottom: 5.0),
                                              child: CustomLabel(
                                                title: 'accidentTime'.tr,
                                                fontFamily: Constants
                                                    .FONT_SF_UI_TEXT_REGULAR,
                                                maxLines: 2,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Utils.timePicker(context)
                                                    .then((value) {
                                                  _controller
                                                          .selectedTime.text =
                                                      value
                                                          .toString()
                                                          .replaceAll(
                                                              RegExp(
                                                                  r'[a-zA-Z]'),
                                                              '')
                                                          .replaceAll("(", '')
                                                          .replaceAll(")", '');
                                                  _controller
                                                          .selectedAccidentTime =
                                                      _controller
                                                          .selectedTime.text;
                                                });
                                              },
                                              child: CustomTextField(
                                                isReadOnly: true,
                                                image: Images.clock,
                                                textController:
                                                    _controller.selectedTime,
                                                isSuffix: true,
                                                labelText: '',
                                                validator: (val) {
                                                  return AppFormFieldValidator
                                                      .generalEmptyValidator(
                                                          val);
                                                },
                                                hintText: 'accidentTime'.tr,
                                                validate: true,
                                                isEnabled: false,
                                                onChanged: (value) {},
                                              ),
                                            ),
                                            /* CustomDropDown(
                                            label: _controller
                                                .sourceOfIncomeOptions[0],
                                            options:
                                                _controller.sourceOfIncomeOptions,
                                            validator: AppFormFieldValidator
                                                .generalDropDownValidator,
                                            onChanged: (val) {
                                              AppFormFieldValidator
                                                  .generalDropDownValidator(val);
                                            },
                                          ),*/
                                          ]),
                                    ),
                                  ),
                                ]),
                            Container(
                              margin: EdgeInsets.fromLTRB(10.0, 20.0, 0, 20.0),
                              child: Row(
                                children: [
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (_controller.formFieldKey.currentState
                                          .validate()) {
                                        _controller.onNextButtonClicked();
                                      }
                                    },
                                    child: CustomBackNextutton(
                                      isBackButton: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              : _controller.policyList != null
                  ? Column(
                      children: List.from(_controller.policyList.policySearch
                          .map((item) => Theme(
                              data: ThemeData()
                                  .copyWith(dividerColor: Colors.transparent),
                              child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 20),
                                padding: EdgeInsets.only(
                                    top: 20.0,
                                    right: 20.0,
                                    left: 20.0,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 0.0, top: 0, bottom: 20),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomLabel(
                                                title: 'motorInsurance'.tr,
                                                color: MyColors.PrimaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    bottom: 5.0,
                                                    top: 5.0),
                                                decoration: new BoxDecoration(
                                                    color: _controller
                                                        .colorByStatus(
                                                            item.statusCaption),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11)),
                                                child: CustomLabel(
                                                  title: item.statusCaption,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          )),
                                      InkWell(
                                        onTap: () {
                                          _controller.activePlanSelected(item);
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomLabel(
                                                    title: 'make_model'.tr,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  Spacer(),
                                                  Flexible(
                                                    child: CustomLabel(
                                                      textAlign: TextAlign.end,
                                                      title:
                                                          '${item.vehicleMake} ${item.modelGroup}',
                                                      color:
                                                          MyColors.PrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomLabel(
                                                    title: 'registrationNo'.tr,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  Spacer(),
                                                  Flexible(
                                                    child: CustomLabel(
                                                      title: item
                                                          .registrationNumber,
                                                      color:
                                                          MyColors.PrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Row(
                                                children: [
                                                  CustomLabel(
                                                    title: 'startDate'.tr,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  Spacer(),
                                                  CustomLabel(
                                                    title: item.policyIDate,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Row(
                                                children: [
                                                  CustomLabel(
                                                    title: ('expiryDate'.tr)
                                                        .toUpperCase(),
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  Spacer(),
                                                  CustomLabel(
                                                    title:
                                                        item.policyExpiryDate,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (!isFromWindScreen)
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    CustomLabel(
                                                      title:
                                                          ('depreciation_percentage'
                                                                  .tr)
                                                              .toUpperCase(),
                                                      color:
                                                          MyColors.PrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                    Spacer(),
                                                    CustomLabel(
                                                      title:
                                                          item.depreciationPercentage +
                                                              '%',
                                                      color:
                                                          MyColors.PrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Row(
                                                children: [
                                                  CustomLabel(
                                                    title: 'plan_name'.tr,
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  Spacer(),
                                                  CustomLabel(
                                                    title: item.planName ?? "-",
                                                    color:
                                                        MyColors.PrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                              )))))
                  : Container(
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ),
                    );
        });
  }

  motorRenewelPlanItemDetails() {
    return Container(
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
    );
  }
}
