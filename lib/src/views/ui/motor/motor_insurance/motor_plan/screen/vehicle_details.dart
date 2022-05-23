import 'dart:io';

import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/home/home_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/contact_deatils_controller.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class VehicleDetailsFormView extends StatelessWidget {
  final VehicleDetailsXController controller = Get.find();
  final MotorXController motorXController = Get.find();
  final MotorPalnXController planXController = Get.find();
  final HomeXController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Form(
              key: controller.formKey,
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                child: Column(
                  children: [
                    Visibility(
                      visible: motorXController.draftProgressStatus[0].status ==
                                  0 ||
                              motorXController.draftProgressStatus[0].status ==
                                  1
                          ? false
                          : true,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CustomButton(
                          title: 'edit'.tr,
                          width: 60,
                          fontSize: 12,
                          height: 26,
                          buttonAction: () {
                            controller.resetPlanDetails();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    IgnorePointer(
                      ignoring:
                          motorXController.draftProgressStatus[0].status == 2
                              ? true
                              : false,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: controller.isBrandNew[0] ? 635 : 730,
                              width: 2,
                              color: MyColors.themeColor,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            //Monthly Income
                            Flexible(
                              child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomLabel(
                                        title: 'vehicleDetailsHeadline'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      CustomLabel(
                                        title: 'isVehicleBrandNew'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomRadioButton(
                                        text: 'yes'.tr,
                                        value: controller.isBrandNew[0],
                                        onTap: () {
                                          controller.updateRadioButton(0);
                                        },
                                      ),
                                      CustomRadioButton(
                                        text: 'no'.tr,
                                        value: controller.isBrandNew[1],
                                        onTap: () {
                                          controller.updateRadioButton(1);
                                        },
                                      ),

                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomLabel(
                                        title: 'make'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomDropDown(
                                        label: controller.vehicleMake,
                                        options: controller.vehicleMakeList,
                                        validator: (val) {
                                          return AppFormFieldValidator
                                              .generalDropDownValidator(val);
                                        },
                                        onChanged: (val) {
                                          controller.vehicleModel.value =
                                              "SELECT";
                                          controller.setMake(val);
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomLabel(
                                        title: 'model'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Obx(() {
                                        return controller.vehicleModel.value ==
                                                "SELECT"
                                            ? CustomDropDown(
                                                label: controller
                                                    .vehicleModel.value,
                                                options:
                                                    controller.vehicleModelList,
                                                validator: (val) {
                                                  return AppFormFieldValidator
                                                      .generalDropDownValidator(
                                                          val);
                                                },
                                                onChanged: (val) {
                                                  controller
                                                      .vehicleModel.value = val;

                                                  controller.setModel(val);

                                                  //controller.setClaim(val);
                                                },
                                              )
                                            : CustomDropDown(
                                                label: controller
                                                    .vehicleModel.value,
                                                options:
                                                    controller.vehicleModelList,
                                                validator: (val) {
                                                  return AppFormFieldValidator
                                                      .generalDropDownValidator(
                                                          val);
                                                },
                                                onChanged: (val) {
                                                  controller
                                                      .vehicleModel.value = val;

                                                  controller.setModel(val);
                                                },
                                              );
                                      }),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomLabel(
                                        title: 'makeYear'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Obx(() {
                                        return controller.makeYear.value ==
                                                "SELECT"
                                            ? CustomDropDown(
                                                label:
                                                    controller.makeYear.value,
                                                options:
                                                    controller.makeYearList,
                                                validator: (val) {
                                                  return AppFormFieldValidator
                                                      .generalDropDownValidator(
                                                          val);
                                                },
                                                onChanged: (val) {
                                                  controller.makeYear.value =
                                                      val;

                                                  //controller.setClaim(val);
                                                },
                                              )
                                            : CustomDropDown(
                                                label:
                                                    controller.makeYear.value,
                                                options:
                                                    controller.makeYearList,
                                                validator: (val) {
                                                  return AppFormFieldValidator
                                                      .generalDropDownValidator(
                                                          val);
                                                },
                                                onChanged: (val) {
                                                  controller.makeYear.value =
                                                      val;

                                                  //controller.setClaim(val);
                                                },
                                              );
                                      }),

                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomLabel(
                                        title: 'motorValue'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomTextField(
                                        textController: controller.motorValue,
                                        textInputType: TextInputType.number,
                                        labelText: '',
                                        hintText: 'value'.tr,
                                        validate: true,
                                        isEnabled: true,
                                        validator: (val) {
                                          return AppFormFieldValidator
                                              .motorValueSumValidator(val);
                                        },
                                        onSaved: (value) {
                                          AppFormFieldValidator
                                              .motorValueSumValidator(value);
                                        },
                                        onChanged: (value) {
                                          controller.motorSumValue.value =
                                              value;
                                        },
                                      ),
                                      // Obx(() {
                                      //   return controller.motorSumValue.value !=
                                      //           ''
                                      //       ? int.parse(controller.motorSumValue
                                      //                       .value ??
                                      //                   "0") >
                                      //               50000
                                      //           ? InkWell(
                                      //               onTap: () {
                                      //                 if (Platform.isAndroid) {
                                      //                   // add the [https]
                                      //                   launch(
                                      //                       "https://wa.me/${homeController.contactInfo.whatsAppNumber.toString()}"); // new line
                                      //                 } else {
                                      //                   // add the [https]
                                      //                   launch(
                                      //                       "https://api.whatsapp.com/send?phone=${homeController.contactInfo.whatsAppNumber.toString()}"); // new line
                                      //                 }
                                      //               },
                                      //               child: Text(
                                      //                 'Kindly contact us on Whatsapp',
                                      //                 style: TextStyle(
                                      //                   color: Colors.red,
                                      //                   decoration:
                                      //                       TextDecoration
                                      //                           .underline,
                                      //                 ),
                                      //               ),
                                      //             )
                                      //           : Container()
                                      //       : Container();
                                      // }),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      //Date Pickeer
                                      CustomLabel(
                                        title: 'policyStartDate'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          var now = DateTime.now();
                                          if (controller.isBrandNew[0]) {
                                            Utils.selectDate(
                                                    context,
                                                    now.add(
                                                        Duration(hours: 24)),
                                                    firstDate: now.add(
                                                        Duration(hours: 24)),
                                                    lastDate: DateTime(2101))
                                                .then((value) => {
                                                      controller.policyStartDate
                                                          .text = value,
                                                      controller
                                                          .setStartAndEndDate(
                                                              controller
                                                                  .policyStartDate
                                                                  .text)
                                                    });
                                          } else if (controller.isBrandNew[1]) {
                                            Utils.selectDate(context, now,
                                                    firstDate: now,
                                                    lastDate: Jiffy(now)
                                                        .add(months: 3)
                                                        .dateTime)
                                                .then((value) => {
                                                      controller.policyStartDate
                                                          .text = value
                                                    });
                                          }
                                        },
                                        child: CustomTextField(
                                          isReadOnly: true,
                                          textController:
                                              controller.policyStartDate,
                                          image: Images.date_picker,
                                          validator: (val) {
                                            return AppFormFieldValidator
                                                .generalEmptyValidator(val);
                                          },
                                          isSuffix: true,
                                          labelText: '',
                                          hintText: 'date'.tr,
                                          validate: true,
                                          isEnabled: false,
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),

                                      if (controller.isBrandNew[1])
                                        Opacity(
                                          opacity: controller.isBrandNew[1]
                                              ? 1
                                              : 0.5,
                                          child: Column(
                                            children: [
                                              CustomLabel(
                                                title: 'nilAtFaultClaims'.tr,
                                                fontFamily: Constants
                                                    .FONT_SF_UI_TEXT_REGULAR,
                                                maxLines: 2,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Obx(() {
                                                return controller.isBrandNew[1]
                                                    ? CustomDropDown(
                                                        label: controller
                                                            .selectedFaultClaim,
                                                        options: controller
                                                            .faultCalim,
                                                        validator: (val) {
                                                          return AppFormFieldValidator
                                                              .generalDropDownValidator(
                                                                  val);
                                                        },
                                                        onChanged: (val) {
                                                          controller
                                                              .setFaultClaim(
                                                                  val);
                                                        },
                                                      )
                                                    : IgnorePointer(
                                                        child: CustomDropDown(
                                                            label: "0",
                                                            options: ["0"],
                                                            validator: (val) {
                                                              return AppFormFieldValidator
                                                                  .generalDropDownValidator(
                                                                      val);
                                                            },
                                                            onChanged: null),
                                                      );
                                              })
                                            ],
                                          ),
                                        ),
                                    ]),
                              ),
                            ),

                            // _buildSaveButton()
                          ]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    IgnorePointer(
                      ignoring:
                          motorXController.draftProgressStatus[0].status == 2
                              ? true
                              : false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              motorXController.expansionCardKey[0].currentState
                                  .collapse();
                            },
                            child: CustomBackNextutton(
                              isBackButton: true,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.validateSumInsured(
                                  controller.motorValue.text);
                            },
                            child: CustomBackNextutton(
                              isBackButton: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ));
        });
  }

  /* SAVE BUTTON */
  Widget _buildSaveButton() {
    return Center(
      child: CustomButton(
        title: 'save'.tr,
        width: 114,
        fontSize: 12,
        height: 26,
        buttonAction: () {
          //  controller.formKey.currentState.validate();
          // Get.toNamed(AppRoutes.MOBILE_EMAIL_VERIFICATION);
        },
      ),
    );
  }
}
