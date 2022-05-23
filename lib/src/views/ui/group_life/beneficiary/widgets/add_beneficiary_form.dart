import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_international_phone_validate.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/base/custom_toogle.dart';
import 'package:ebpv2/src/views/ui/group_life/beneficiary/add_binificiary_controller.dart';
import 'package:ebpv2/src/views/ui/group_life/beneficiary/beneficiary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/base_controller/localization_controller.dart';

class AddBinificiaryForm extends StatelessWidget {
  final AddBinificiaryXController _binificiaryController = Get.find();
  final LocalizationController localizationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _binificiaryController,
        builder: (cntrlr) {
          return Form(
            key: _binificiaryController.formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 2,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                            CustomLabel(
                              title: "addBenificiary".tr,
                              color: MyColors.PrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              maxLines: 2,
                            ),
                            CustomSpacer(
                                value: Dimensions.PADDING_SIZE_DEFAULT),
                            CustomLabel(
                              title: "fullName".tr,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              textController:
                                  _binificiaryController.nameController,
                              labelText: '',
                              hintText: 'enterFullName'.tr,
                              validate: true,
                              isEnabled: true,
                              validator: AppFormFieldValidator
                                  .generalEmptyValidatorWithNoSpecialChar,
                              onSaved: (value) {
                                // _dependentController.setName(value);
                              },
                              onChanged: (value) {
                                AppFormFieldValidator
                                    .generalEmptyValidatorWithNoSpecialChar(
                                        value);
                              },
                            ),
                            CustomSpacer(
                                value: Dimensions.PADDING_SIZE_DEFAULT),
                            CustomLabel(
                              title: "dateOfBirth".tr,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                _binificiaryController
                                    .selectDate(context, DateTime(1990),
                                        isMinor: true)
                                    .then((value) => _binificiaryController
                                        .dateController.text = value);
                              },
                              child: CustomTextField(
                                isReadOnly: true,
                                textController:
                                    _binificiaryController.dateController,
                                image: Images.date_picker,
                                isSuffix: true,
                                labelText: '',
                                hintText: 'selectDob'.tr,
                                validate: true,
                                isEnabled: false,
                                validator:
                                    AppFormFieldValidator.generalEmptyValidator,
                                onSaved: (value) {},
                                onChanged: (value) {
                                  AppFormFieldValidator.generalEmptyValidator(
                                      value);
                                },
                              ),
                            ),
                            if (_binificiaryController.isBenificiaryMinor.value)
                              CustomLabel(
                                title: "minorBeneficiaryGuardianRequired".tr,
                                color: MyColors.RedColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            CustomSpacer(
                                value: Dimensions.PADDING_SIZE_DEFAULT),
                            //Contact number
                            CustomLabel(
                              title: "contactNumber".tr,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomInternationalPhoneValidate(
                              initialPhoneNumber:
                                  _binificiaryController.beneficiaryNumber,
                              phoneController:
                                  _binificiaryController.contactNumController,
                              dailCode: (val) {
                                _binificiaryController.selectedCountryCode =
                                    val ?? "+973";
                                _binificiaryController
                                    .hasBeneficiaryMobibleNumberAdded
                                    .value = true;
                              },
                            ),
                            Obx(() {
                              return !_binificiaryController
                                      .hasBeneficiaryMobibleNumberAdded.value
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
                            CustomSpacer(
                                value: Dimensions.PADDING_SIZE_DEFAULT),
                            CustomLabel(
                              title: "idNumber".tr,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              textController:
                                  _binificiaryController.idNumberController,
                              // textInputType: TextInputType.n,
                              labelText: '',
                              hintText: 'enterIdNumber'.tr,
                              validate: true,
                              isEnabled: true,
                              validator: AppFormFieldValidator
                                  .idNumberValidatorWithOneSpecialChar,
                              onSaved: (value) {
                                // _dependentController.setName(value);
                              },
                              onChanged: (value) {
                                AppFormFieldValidator
                                    .idNumberValidatorWithOneSpecialChar(value);
                              },
                            ),
                            CustomSpacer(
                                value: Dimensions.PADDING_SIZE_DEFAULT),
                            CustomLabel(
                              title: "address".tr,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              textController:
                                  _binificiaryController.addressController,
                              labelText: '',
                              hintText: 'fullAddress'.tr,
                              validate: true,
                              isEnabled: true,
                              validator:
                                  AppFormFieldValidator.generalEmptyValidator,
                              onSaved: (value) {
                                // _dependentController.setName(value);
                              },
                              onChanged: (value) {
                                AppFormFieldValidator.generalEmptyValidator(
                                    value);
                              },
                            ),
                            // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),

                            CustomSpacer(
                                value: Dimensions.PADDING_SIZE_DEFAULT),
                            CustomLabel(
                              title: "relation".tr,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomDropDown(
                              label: _binificiaryController.selectedRelation,
                              options: _binificiaryController.relationTypes,
                              validator: AppFormFieldValidator
                                  .generalDropDownValidator,
                              onChanged: (val) {
                                AppFormFieldValidator.generalDropDownValidator(
                                    val);
                                _binificiaryController.setRelation(val);
                              },
                            ),

                            CustomSpacer(
                                value: Dimensions.PADDING_SIZE_DEFAULT),
                            CustomLabel(
                              title: "percentage".tr,
                              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              textController:
                                  _binificiaryController.percentageController,
                              textInputType: TextInputType.number,
                              labelText: '',
                              hintText: 'enterPercentage'.tr,
                              validate: true,
                              isEnabled: true,
                              isPercentageField: true,
                              validator:
                                  AppFormFieldValidator.percetageValidator,
                              onSaved: (value) {
                                // _dependentController.setName(value);
                              },
                              onChanged: (value) {
                                AppFormFieldValidator.percetageValidator(value);
                              },
                            ),

                            if (_binificiaryController.isBenificiaryMinor.value)
                              _isGardianNeeded(context),
                            CustomSpacer(
                                value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (_binificiaryController.currentIndex != null)
                                  _buildDeleteButton(),
                                _buildNextButton(),
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
            ),
          );
        });
  }

  Widget _isGardianNeeded(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
        Divider(
          color: MyColors.GrayColor,
          height: 5,
          thickness: 1.5,
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        CustomLabel(
          title: "addGaurdian".tr,
          color: MyColors.PrimaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          maxLines: 2,
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        CustomLabel(
          title: "fullName".tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          textController: _binificiaryController.gaurdiaNameController,
          labelText: '',
          hintText: 'enterFullName'.tr,
          validate: true,
          isEnabled: true,
          validator:
              AppFormFieldValidator.generalEmptyValidatorWithNoSpecialChar,
          onSaved: (value) {
            // _dependentController.setName(value);
          },
          onChanged: (value) {
            AppFormFieldValidator.generalEmptyValidatorWithNoSpecialChar(value);
          },
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        CustomLabel(
          title: "dateOfBirth".tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            _binificiaryController
                .selectDate(context, DateTime(1990), islastDateToday: false)
                .then((value) =>
                    _binificiaryController.gaurdiaDateController.text = value);
          },
          child: CustomTextField(
            isReadOnly: true,
            textController: _binificiaryController.gaurdiaDateController,
            image: Images.date_picker,
            isSuffix: true,
            labelText: '',
            hintText: 'selectDob',
            validate: true,
            isEnabled: false,
            validator: AppFormFieldValidator.generalEmptyValidator,
            onSaved: (value) {
              // _dependentController.setDate(value);
            },
            onChanged: (value) {
              AppFormFieldValidator.generalEmptyValidator(value);
            },
          ),
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        //Contact number
        CustomLabel(
          title: "contactNumber".tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        SizedBox(
          height: 5,
        ),
        CustomInternationalPhoneValidate(
          initialPhoneNumber: _binificiaryController.gaurdianNumber,
          phoneController: _binificiaryController.gaurdiaContactNumController,
          dailCode: (val) {
            _binificiaryController.gaurdianCountryCode = val ?? "+973";
            _binificiaryController.hasGaurdianMobibleNumberAdded.value = true;
          },
        ),
        Obx(() {
          return !_binificiaryController.hasGaurdianMobibleNumberAdded.value
              ? Padding(
                  padding: const EdgeInsets.only(left: 95.0, top: 2.5),
                  child: CustomLabel(
                    title: "fieldCannotBeEmpty".tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: MyColors.red,
                  ),
                )
              : Container();
        }),
        // CustomTextField(
        //   textInputType: TextInputType.phone,
        //   textController: _binificiaryController.gaurdiaContactNumController,
        //   mobileCountryCode: _binificiaryController.gaurdianCountryCode,
        //   labelText: '',
        //   hintText: 'Mobile Number',
        //   validate: true,
        //   isEnabled: true,
        //   iconData: null,
        //   showcountryCodePicker: true,
        //   validator: AppFormFieldValidator.validateMobile,
        //   countryCodeOnChanged: (val) {
        //     _binificiaryController.gaurdianCountryCode = val.toString();
        //   },
        //   onSaved: (value) {
        //     // _dependentController.setEmail(value);
        //   },
        //   onChanged: (value) {
        //     AppFormFieldValidator.validateMobile(value);
        //   },
        // ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        CustomLabel(
          title: "idNumber".tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          textController: _binificiaryController.gaurdianIdNumberController,
          textInputType: TextInputType.number,
          labelText: '',
          hintText: 'enterIdNumber'.tr,
          validate: true,
          isEnabled: true,
          validator: AppFormFieldValidator.generalEmptyValidator,
          onSaved: (value) {
            // _dependentController.setName(value);
          },
          onChanged: (value) {
            AppFormFieldValidator.generalEmptyValidator(value);
          },
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        CustomLabel(
          title: "address".tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          textController: _binificiaryController.gaurdianAddressController,
          labelText: '',
          hintText: 'fullAddress',
          validate: true,
          isEnabled: true,
          validator: AppFormFieldValidator.generalEmptyValidator,
          onSaved: (value) {
            // _dependentController.setName(value);
          },
          onChanged: (value) {
            AppFormFieldValidator.generalEmptyValidator(value);
          },
        ),
        // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),

        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        CustomLabel(
          title: "relation".tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        SizedBox(
          height: 5,
        ),
        CustomDropDown(
          label: _binificiaryController.selectedGaurdianRelation,
          options: _binificiaryController.relationTypes,
          validator: AppFormFieldValidator.generalDropDownValidator,
          onChanged: (val) {
            AppFormFieldValidator.generalDropDownValidator(val);
            _binificiaryController.setGaurdianRelation(val);
          },
        ),
        // CustomTextField(
        //   textController: _binificiaryController.gaurdiaRelationController,
        //   labelText: '',
        //   hintText: 'relationStatus'.tr,
        //   validate: true,
        //   isEnabled: true,
        //   validator:
        //       AppFormFieldValidator.generalEmptyValidatorWithNoSpecialChar,
        //   onSaved: (value) {
        //     // controller.setEmail(value);
        //   },
        //   onChanged: (value) {
        //     AppFormFieldValidator.generalEmptyValidatorWithNoSpecialChar(value);
        //   },
        // ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        CustomLabel(
          title: "nationality".tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        SizedBox(
          height: 5,
        ),

        CustomDropDown(
          label: _binificiaryController.gaurdianNationality,
          options: Constants.baseCountries,
          validator: AppFormFieldValidator.generalDropDownValidator,
          onChanged: (val) {
            AppFormFieldValidator.generalDropDownValidator(val);
            _binificiaryController.setNationality(val);
          },
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        CustomLabel(
          title: "gender".tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        SizedBox(
          height: 5,
        ),
        CustomToggle(
          totalItems: _binificiaryController.genderTypes,
          onTap: (val) {
            _binificiaryController.switchGenderStatus(val);
          },
          isStatusSelected: _binificiaryController.isGenderStatusSelected,
        ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        CustomLabel(
          title: "emailAddressOptional".tr,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          textController: _binificiaryController.gaurdiaEmailController,
          labelText: '',
          hintText: 'enterEmailId'.tr,
          // validate: true,
          isEnabled: true,
          // validator: AppFormFieldValidator.emailValidator,
          onSaved: (value) {
            // controller.setEmail(value);
          },
          // onChanged: (value) {
          //   AppFormFieldValidator.emailValidator(value);
          // },
        ),
      ],
    );
  }

  /* SAVE BUTTON */
  Widget _buildNextButton() {
    return Center(
      child: CustomButton(
        title: "next".tr,
        width: 114,
        fontSize: 12,
        height: 26,
        buttonAction: () {
          if (_binificiaryController.formKey.currentState.validate()) {
            if (_binificiaryController.contactNumController.text != "") {
              _binificiaryController.hasBeneficiaryMobibleNumberAdded.value =
                  true;
              if (_binificiaryController.dateController.text.isNotEmpty) {
                _binificiaryController.saveBenificiary();
              }
            } else {
              _binificiaryController.hasBeneficiaryMobibleNumberAdded.value =
                  false;
            }

            // _controller.changeBenificiaryUI();
          } else {
            if (_binificiaryController.contactNumController.text == "") {
              _binificiaryController.hasBeneficiaryMobibleNumberAdded.value =
                  false;
            } else {
              _binificiaryController.hasBeneficiaryMobibleNumberAdded.value =
                  true;
            }
            if (_binificiaryController
                .isBenificiaryMinor.value) if (_binificiaryController
                    .gaurdiaContactNumController.text ==
                "") {
              _binificiaryController.hasGaurdianMobibleNumberAdded.value =
                  false;
            } else {
              _binificiaryController.hasGaurdianMobibleNumberAdded.value = true;
            }
          }
        },
      ),
    );
  }

  /* SAVE BUTTON */
  Widget _buildDeleteButton() {
    return Center(
      child: CustomButton(
        title: "delete".tr,
        bgColor: MyColors.RedColor,
        width: 114,
        fontSize: 12,
        height: 26,
        buttonAction: () {
          _binificiaryController.deleteBeneficiary();
        },
      ),
    );
  }
}
