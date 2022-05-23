import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/Identification_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'custom_drop_down_view.dart';

class IdentificationDetailsFormView extends StatelessWidget {
  final IdentificationDetailsXController controller =
      Get.put(IdentificationDetailsXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return VisibilityDetector(
          key: Key('identification-widget-key'),
          onVisibilityChanged: (VisibilityInfo info) {
            if (info.visibleFraction > 0.2) {
              debugPrint("${info.visibleFraction} of my widget is visible");
              controller.setData(!controller.isIdentificationVisible);
            } else {
              debugPrint("${info.visibleFraction} of my widget is invisible");
            }
          },
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Nationality
                CustomLabel(
                  title: "Nationality*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),

                IgnorePointer(
                  child: CustomDropDownView(
                    label: controller.chosenValue,
                    options: controller.countries,
                    isDisableColored: true,
                    onChanged: null,
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                //Id Type
                CustomLabel(
                  title: "ID Type*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),

                CustomDropDown(
                  label: controller.IdType,
                  options: controller.IdTypeList,
                  isDisableColored: true,
                  validator: AppFormFieldValidator.generalDropDownValidator,
                  onChanged: (val) {
                    AppFormFieldValidator.generalDropDownValidator(val);
                    controller.setIdType(val);
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                //Id Number
                CustomLabel(
                  title: "ID Number*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  textController: controller.iDNumberController,
                  labelText: '',
                  isReadOnly: true,
                  isDisableColored: true,
                  hintText: 'Enter Id Number',
                  validate: true,
                  isEnabled: true,
                  validator: AppFormFieldValidator.generalEmptyValidator,
                  onChanged: (value) {
                    AppFormFieldValidator.generalEmptyValidator(value);
                  },
                ),

                SizedBox(
                  height: 20,
                ),

                //ID Expiration
                CustomLabel(
                  title: "ID Expiration Date*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    // controller.selectDate(context, DateTime.now()).then(
                    //     (value) =>
                    //         controller.iDExpirationDateController.text = value);
                  },
                  child: CustomTextField(
                    textController: controller.iDExpirationDateController,
                    image: Images.date_picker,
                    isSuffix: true,
                    labelText: '',
                    isReadOnly: true,
                    isDisableColored: true,
                    hintText: 'ID Expiration Date',
                    validate: true,
                    isEnabled: false,
                    validator: AppFormFieldValidator.generalEmptyValidator,
                    onChanged: (value) {
                      AppFormFieldValidator.generalEmptyValidator(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //Passport Number

                CustomLabel(
                  title: "Passport Number*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  textController: controller.passportNumberController,
                  labelText: '',
                  hintText: 'Enter Passport Number',
                  validate: true,
                  isEnabled: true,
                  isReadOnly: true,
                  isDisableColored: true,
                  validator: AppFormFieldValidator.generalEmptyValidator,
                  onChanged: (value) {
                    AppFormFieldValidator.generalEmptyValidator(value);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                //Driver’s License Expiration Datepicker
                CustomLabel(
                  title: "Driver’s License Expiration Date*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    // controller.selectDate(context, DateTime.now()).then(
                    //     (value) => controller
                    //         .licenseExpirationDateController.text = value);
                  },
                  child: CustomTextField(
                    textController: controller.licenseExpirationDateController,
                    image: Images.date_picker,
                    isSuffix: true,
                    labelText: '',
                    hintText: 'ID Expiration Date',
                    validate: true,
                    isEnabled: false,
                    isReadOnly: true,
                    isDisableColored: true,
                    validator: AppFormFieldValidator.generalEmptyValidator,
                    onChanged: (value) {
                      AppFormFieldValidator.generalEmptyValidator(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomLabel(
                  title: "Passport",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    CustomButton(
                      title: 'View',
                      width: 130,
                      fontSize: 12,
                      isActive: false,
                      bgColor: MyColors.GrayColor,
                      height: 30,
                      buttonAction: () {
                        Get.toNamed(AppRoutes.VIEW_DOCUMENT_SHARE, arguments: {
                          "fullPathUrl": "http://20.203.8.34/Files/Documents/" +
                                  controller.customerDetails.details.documents
                                      .firstWhere(
                                          (element) => element.type == 1)
                                      .file ??
                              "",
                          "viewTitle": "Passport"
                        });
                      },
                    ),
                    Spacer(),
                    CustomButton(
                      title: 'Upload',
                      width: 130,
                      fontSize: 12,
                      isActive: false,
                      bgColor: MyColors.VerticalDividerColor,
                      height: 30,
                      buttonAction: () {
                        _showPicker();
                        // controller.getImageGallery();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomLabel(
                  title: "CPR",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    CustomButton(
                      title: 'View',
                      width: 130,
                      fontSize: 12,
                      bgColor: MyColors.GrayColor,
                      height: 30,
                      isActive: false,
                      buttonAction: () {
                        Get.toNamed(AppRoutes.VIEW_DOCUMENT_SHARE, arguments: {
                          "fullPathUrl": "http://20.203.8.34/Files/Documents/" +
                                  controller.customerDetails.details.documents
                                      .firstWhere(
                                          (element) => element.type == 2)
                                      .file ??
                              "",
                          "viewTitle": "CPR"
                        });
                        // Get.toNamed(AppRoutes.VIEW_DOCUMENTS, arguments: {
                        //   'filePath1': controller
                        //           .customerDetails.details.documents
                        //           .firstWhere((element) => element.type == 2)
                        //           .file ??
                        //       "",
                        //   'filePath2': controller
                        //           .customerDetails.details.documents
                        //           .firstWhere((element) => element.type == 13)
                        //           .file ??
                        //       ""
                        // });
                        // Get.toNamed(AppRoutes.MOBILE_EMAIL_VERIFICATION);
                      },
                    ),
                    Spacer(),
                    CustomButton(
                      title: 'Upload',
                      width: 130,
                      fontSize: 12,
                      isActive: false,
                      bgColor: MyColors.VerticalDividerColor,
                      height: 30,
                      buttonAction: () {
                        _showPicker(isCPR: true);
                        // Get.toNamed(AppRoutes.MOBILE_EMAIL_VERIFICATION);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPicker({bool isCPR: false}) {
    showModalBottomSheet(
      context: Get.context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: label("documents".tr, fontSize: MediumFontSize),
                  onTap: () {
                    Get.back();
                    FocusManager.instance.primaryFocus.unfocus();
                    controller.getImageGallery(isCPR: isCPR);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_album),
                  title: label("gallery".tr, fontSize: MediumFontSize),
                  onTap: () {
                    Get.back();
                    FocusManager.instance.primaryFocus.unfocus();
                    controller.getImageFromGallery(isCPR: isCPR);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: label("camera".tr, fontSize: MediumFontSize),
                  onTap: () {
                    Get.back();
                    FocusManager.instance.primaryFocus.unfocus();
                    controller.getImageCamera(isCPR: isCPR);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
