import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_international_phone_validate.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/base/custom_toogle.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/add_dependent_form_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/dependent_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'custom_drop_down_view.dart';

class AddDependentForm extends StatelessWidget {
  final AddDependentFormXController _dependentController = Get.find();
  final DependentXController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _dependentController,
        builder: (_) {
          return Form(
            key: _dependentController.scaffoldKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 2,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          Visibility(
                            visible: false,
                            child: Center(
                              child: Container(
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: new Border.all(
                                    color: MyColors.disableGreyColor,
                                    width: 4.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: SvgPicture.asset(
                                    Images.account,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          CustomSpacer(
                              value: Dimensions.PADDING_SIZE_DEFAULT / 2),
                          Visibility(
                            visible: controller.isEditing.value,
                            child: Center(
                              child: CustomLabel(
                                textAlign: TextAlign.center,
                                title: _dependentController.customerName,
                                color: MyColors.PrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              ),
                            ),
                          ),
                          CustomSpacer(
                              value: Dimensions.PADDING_SIZE_DEFAULT / 2),
                          Visibility(
                            visible: controller.isEditing.value,
                            child: Center(
                              child: CustomLabel(
                                textAlign: TextAlign.center,
                                title: _dependentController.relation,
                                color: MyColors.PrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              ),
                            ),
                          ),
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'firstName'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            textController: _dependentController.nameController,
                            labelText: '',
                            hintText: 'enterFirstName'.tr,
                            validate: true,
                            isEnabled: true,
                            validator: AppFormFieldValidator.firstNameValidator,
                            onSaved: (value) {
                              // _dependentController.setName(value);
                            },
                            onChanged: (value) {
                              print(value);
                              AppFormFieldValidator.firstNameValidator(value,
                                  errorText: "Please enter first name");
                              _dependentController.setFullName();
                            },
                          ),
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'middleName'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            textController:
                                _dependentController.middleNameController,
                            labelText: '',
                            hintText: 'enterMiddleName'.tr,
                            validate: true,
                            isEnabled: true,
                            // validator:
                            // AppFormFieldValidator.generalEmptyValidator,
                            onSaved: (value) {
                              // _dependentController.setName(value);
                            },
                            onChanged: (value) {
                              // AppFormFieldValidator.generalEmptyValidator(
                              // value);
                              _dependentController.setFullName();
                            },
                          ),
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'lastName'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            textController:
                                _dependentController.lastNameController,
                            labelText: '',
                            hintText: 'enterLastName'.tr,
                            isEnabled: true,
                            errorText: "Please enter last name",
                            validator: AppFormFieldValidator.lastNameValidator,
                            onSaved: (value) {
                              // _dependentController.setName(value);
                            },
                            onChanged: (value) {
                              AppFormFieldValidator.lastNameValidator(
                                value,
                              );
                              _dependentController.setFullName();
                            },
                          ),
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'relationship'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          // RELATIONSHIP TYPES
                          CustomToggle(
                            totalItems: ['Spouse', 'Son', 'Daughter'],
                            onTap: (val) {
                              _dependentController.switchRelationStatus(val);
                            },
                            isStatusSelected:
                                _dependentController.relationStatusSelected,
                            isSelected:
                                _dependentController.selectedRelation == 0 &&
                                        _dependentController.isSavedClicked
                                    ? true
                                    : false,
                          ),

                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'nationality'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          CustomDropDownView(
                            label: _dependentController.nationality,
                            options: _dependentController.countries,
                            onChanged: (val) {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _dependentController.setNationality(val);
                            },
                          ),
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),

                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'idNumber'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            textController:
                                _dependentController.idNumberController,
                            textInputType: TextInputType.number,
                            labelText: '',
                            hintText: 'enterIdNumber'.tr,
                            validate: true,
                            isEnabled: true,
                            validator: (value) {
                              if (value.length >= 9 && value.length <= 15) {
                                return null;
                              } else {
                                return AppFormFieldValidator.validateCPR(value);
                              }
                            },
                            onSaved: (value) {
                              // _dependentController.setName(value);
                            },
                            onChanged: (value) {
                              if (value.length >= 9 && value.length <= 15) {
                                debugPrint("Greater than 9");
                              } else {
                                AppFormFieldValidator.validateCPR(value);
                              }
                            },
                          ),
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'passport_id'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            textController:
                                _dependentController.passportIDController,
                            textInputType: TextInputType.number,
                            labelText: '',
                            hintText: 'enterPassportId'.tr,
                            validate: true,
                            isEnabled: true,
                            onSaved: (value) {
                              // _dependentController.setName(value);
                            },
                            onChanged: (value) {},
                          ),
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'dateOfBirth'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus.unfocus();
                              Utils.initialSelectDate(context, DateTime.now(),
                                      DateTime(1950, 8), DateTime.now())
                                  .then((value) {
                                _dependentController.dateController.text =
                                    Utils.formattedDate(value);
                              });
                            },
                            child: AbsorbPointer(
                              child: CustomTextField(
                                isReadOnly: false,
                                onTapAction: () {},
                                textController:
                                    _dependentController.dateController,
                                image: Images.date_picker,
                                isSuffix: true,
                                labelText: '',
                                hintText: 'selectDob'.tr,
                                isEnabled: true,
                                validate: true,
                                validator: (value) =>
                                    AppFormFieldValidator.generalEmptyValidator(
                                        value,
                                        errorText:
                                            "Please enter Date of Birth"),
                                onSaved: (value) {
                                  _dependentController.setDOB(value);
                                },
                                onChanged: (value) {},
                              ),
                            ),
                          ),

                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'emailAddress'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            textController:
                                _dependentController.emailController,
                            labelText: '',
                            hintText: 'enterEmailAddress'.tr,
                            textInputType: TextInputType.emailAddress,
                            validate: true,
                            isEnabled: true,
                            validator: AppFormFieldValidator.emailValidator,
                            onSaved: (value) {},
                            onChanged: (value) {},
                          ),
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),

                          //Contact number
                          CustomLabel(
                            title: 'contactNumber'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          // INTERNATIONAL PHONE NUMBER VALIDATION
                          CustomInternationalPhoneValidate(
                            initialPhoneNumber: _dependentController.number,
                            phoneController:
                                _dependentController.contactNumController,
                            dailCode: (val) {
                              _dependentController.selectedCountryCode =
                                  val ?? "+973";
                              _dependentController
                                  .hasDependentMobibleNumberAdded.value = true;
                            },
                          ),
                          Obx(() {
                            return !_dependentController
                                    .hasDependentMobibleNumberAdded.value
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 95.0, top: 2.5),
                                    child: CustomLabel(
                                      title: "fieldCannotBeEmpty".tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                      color: MyColors.red,
                                    ),
                                  )
                                : Container();
                          }),

                          // //ID Expiration Date Picker
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'idExpirationDate'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus.unfocus();
                              Utils.initialSelectDate(context, DateTime.now(),
                                      DateTime.now(), DateTime(2031, 12))
                                  .then((value) {
                                _dependentController.idExpireDateController
                                    .text = Utils.formattedDate(value);
                              });
                            },
                            child: CustomTextField(
                              isReadOnly: true,
                              textController:
                                  _dependentController.idExpireDateController,
                              image: Images.date_picker,
                              isSuffix: true,
                              labelText: '',
                              hintText: 'enterIdExpirationdate'.tr,
                              validate: true,
                              isEnabled: false,
                              validator:
                                  AppFormFieldValidator.generalEmptyValidator,
                              onChanged: (value) {},
                            ),
                          ),

                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'passport'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                  title: 'view'.tr,
                                  width: 130,
                                  fontSize: 12,
                                  isActive: false,
                                  bgColor: MyColors.GrayColor,
                                  height: 30,
                                  buttonAction: () async {
                                    if (_dependentController.passport != null &&
                                        _dependentController.passport != "") {
                                      Get.toNamed(AppRoutes.VIEW_DOCUMENT_SHARE,
                                          arguments: {
                                            "fullPathUrl":
                                                "http://20.203.8.34/Files/Documents/" +
                                                    _dependentController
                                                        .passport,
                                            "viewTitle": "Passport"
                                          });
                                    } else {
                                      errorMessage("No data found");
                                    }
                                  }

                                  // Get.toNamed(AppRoutes.MOBILE_EMAIL_VERIFICATION);
                                  ),
                              // Spacer(),
                              CustomButton(
                                title: 'upload'.tr,
                                width: 130,
                                fontSize: 12,
                                isActive: false,
                                bgColor: MyColors.VerticalDividerColor,
                                height: 30,
                                buttonAction: () {
                                  FocusManager.instance.primaryFocus.unfocus();
                                  _showPicker(isCPR: false);
                                },
                              ),
                            ],
                          ),
                          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomLabel(
                            title: 'idCard'.tr,
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                title: 'view'.tr,
                                width: 130,
                                fontSize: 12,
                                bgColor: MyColors.GrayColor,
                                height: 30,
                                isActive: false,
                                buttonAction: () {
                                  FocusManager.instance.primaryFocus.unfocus();

                                  if (_dependentController.cpr != null &&
                                      _dependentController.cpr != "") {
                                    Get.toNamed(AppRoutes.VIEW_DOCUMENT_SHARE,
                                        arguments: {
                                          "fullPathUrl":
                                              "http://20.203.8.34/Files/Documents/" +
                                                  _dependentController.cpr,
                                          "viewTitle": "CPR"
                                        });
                                  } else {
                                    errorMessage("No data found");
                                  }
                                },
                              ),
                              // Spacer(),
                              CustomButton(
                                title: 'upload'.tr,
                                width: 130,
                                fontSize: 12,
                                isActive: false,
                                bgColor: MyColors.VerticalDividerColor,
                                height: 30,
                                buttonAction: () {
                                  FocusManager.instance.primaryFocus.unfocus();
                                  _showPicker(isCPR: true);
                                },
                              ),
                            ],
                          ),
                          CustomSpacer(
                              value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                          // _buildSaveButton(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (controller.isEditing.value)
                                CustomButton(
                                  title: 'delete'.tr,
                                  width: 130,
                                  fontSize: 12,
                                  bgColor: MyColors.RedColor,
                                  height: 30,
                                  isActive: false,
                                  buttonAction: () {
                                    _dependentController.deleteDependent();
                                  },
                                ),
                              if (!controller.isEditing.value)
                                CustomButton(
                                  title: 'cancel'.tr,
                                  width: 130,
                                  fontSize: 12,
                                  bgColor: Colors.grey,
                                  height: 30,
                                  buttonAction: () {
                                    Get.find<DependentXController>()
                                        .addDependentClicked();
                                    Get.find<DependentXController>()
                                        .isEditingChanging();
                                  },
                                ),
                              CustomButton(
                                title: 'save'.tr,
                                width: 130,
                                fontSize: 12,
                                height: 30,
                                buttonAction: () {
                                  FocusScope.of(context).unfocus();
                                  _dependentController.dependentSaveClicked();
                                  if (_dependentController
                                      .scaffoldKey.currentState
                                      .validate()) {
                                    if (_dependentController
                                            .contactNumController.text !=
                                        "") {
                                      _dependentController
                                          .hasDependentMobibleNumberAdded
                                          .value = true;
                                      if (_dependentController
                                          .idExpireDateController
                                          .text
                                          .isNotEmpty) {
                                        _dependentController.saveDependent(
                                            controller.isEditing.value);
                                      }
                                    } else {
                                      _dependentController
                                          .hasDependentMobibleNumberAdded
                                          .value = false;
                                    }
                                  } else {
                                    if (_dependentController
                                            .contactNumController.text ==
                                        "") {
                                      _dependentController
                                          .hasDependentMobibleNumberAdded
                                          .value = false;
                                    } else {
                                      _dependentController
                                          .hasDependentMobibleNumberAdded
                                          .value = true;
                                    }
                                  }
                                  // controller.addDependentClicked();
                                },
                              ),
                            ],
                          ),
                          CustomSpacer(
                              value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showPicker({bool isCPR = false}) {
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
                    FocusManager.instance.primaryFocus.unfocus();
                    _dependentController.getImageGallery(isCPR: isCPR);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_album),
                  title: label("gallery".tr, fontSize: MediumFontSize),
                  onTap: () {
                    FocusManager.instance.primaryFocus.unfocus();
                    _dependentController.getImageFromGallery(isCPR: isCPR);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: label("camera".tr, fontSize: MediumFontSize),
                  onTap: () {
                    FocusManager.instance.primaryFocus.unfocus();
                    _dependentController.getImageCamera(isCPR: isCPR);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /* SAVE BUTTON */
  Widget _buildSaveButton() {
    return Center(
      child: CustomButton(
        title: 'next'.tr,
        width: 114,
        fontSize: 12,
        height: 26,
        buttonAction: () {
          controller.addDependentClicked();
        },
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
