import 'dart:io';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/auth/profile/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class CompleteProfileScreen extends StatelessWidget {
  final CompleteProfileController controller =
      Get.put(CompleteProfileController());

  @override
  Widget build(BuildContext context) {
    return ConditionalWillPopScope(
      shouldAddCallback: Platform.isAndroid ? true : false,
      onWillPop: () async {
        Get.back();
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSilverBar(
              title: 'identity_verification'.tr,
              isBackButtonExist: false,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: GetBuilder(
                init: controller,
                builder: (_) {
                  return profileView();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileView() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: MyColors.PrimaryColor),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1,
                      color: MyColors.PrimaryColor,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.PrimaryColor,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1,
                      color: Color.fromRGBO(209, 215, 219, 1),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromRGBO(209, 215, 219, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(32),
              decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: MyColors.GrayColor,
                    blurRadius: 22.0,
                    offset: Offset(
                      0.0,
                      6.0,
                    ),
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 2,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              border: Border.all(
                                color: MyColors.PrimaryColor,
                                width: 2.0,
                              ),
                            ),
                            height: 26,
                            width: 26,
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.PrimaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          CustomLabel(
                            title: 'complete_profile'.tr,
                            color: MyColors.PrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ],
                      ),
                      CustomSpacer(
                        value: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      CompleteProfileView(controller: controller),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: CustomButton(
                title: 'confirm'.tr,
                width: 114,
                fontSize: 12,
                height: 26,
                buttonAction: () {
                  controller.navigateToCompleteRegistration();
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class CompleteProfileView extends StatelessWidget {
  final CompleteProfileController controller;

  const CompleteProfileView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.05,
              height: double.infinity,
              margin:
                  const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
              child: VerticalDivider(
                color: MyColors.VerticalDividerColor,
                thickness: 2,
              ),
            ),
            Container(
              width: Get.width * 0.60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomLabel(
                    title: 'full_name'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.firstNameController,
                    focusNode: null,
                    isReadOnly: true,
                    isDisableColored: true,
                    iconData: Icons.email,
                    labelText: '',
                    hintText: 'enter_first_name'.tr,
                    errorText: 'first_name_required'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    textController: controller.middleNameController,
                    focusNode: null,
                    isReadOnly: true,
                    isDisableColored: true,
                    labelText: '',
                    hintText: 'enter_middle_name'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    isReadOnly: true,
                    isDisableColored: true,
                    textController: controller.lastNameController,
                    labelText: '',
                    hintText: 'enterLastName'.tr,
                    validate: true,
                    isEnabled: true,
                    onSaved: (value) {
                      // controller.setName(value);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: 'dateOfBirth'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.dateOfBirthController,
                    focusNode: null,
                    isReadOnly: true,
                    isDisableColored: true,
                    iconData: Icons.email,
                    labelText: '',
                    hintText: '15/12/1995',
                    errorText: 'date_of_birth_required'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: 'place_of_birth'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.placeOfBirthController,
                    focusNode: null,
                    iconData: Icons.email,
                    labelText: '',
                    isReadOnly: true,
                    isDisableColored: true,
                    hintText: 'Bahrain, Manama',
                    errorText: 'corporate_email_required'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: 'nationality'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.nationalityController,
                    focusNode: null,
                    isReadOnly: true,
                    isDisableColored: true,
                    iconData: Icons.email,
                    labelText: '',
                    hintText: 'Bahraini',
                    errorText: 'corporate_email_required'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: 'address'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.addressController,
                    labelText: '',
                    isReadOnly: true,
                    isDisableColored: true,
                    isTextArea: true,
                    hintText: 'Hamad Town, 2733 1133',
                    errorText: 'corporate_email_required'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: 'enterIdNumber'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.idNumberController,
                    focusNode: null,
                    isReadOnly: true,
                    isDisableColored: true,
                    labelText: '',
                    hintText: '951201234',
                    errorText: 'corporate_email_required'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: 'resident'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.residentController,
                    isReadOnly: true,
                    isDisableColored: true,
                    labelText: '',
                    hintText: 'Yes',
                    errorText: '',
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: "Passport Number",
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.passportNumberController,
                    focusNode: null,
                    isReadOnly: true,
                    isDisableColored: true,
                    iconData: Icons.email,
                    labelText: '',
                    hintText: '12345678',
                    errorText: 'Corporate E-mail is required',
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: "Occupation",
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.occupationController,
                    focusNode: null,
                    iconData: Icons.email,
                    labelText: '',
                    hintText: 'Creative Director',
                    errorText: 'Corporate E-mail is required',
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: "Employer Name",
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.employeeNameController,
                    focusNode: null,
                    iconData: Icons.email,
                    labelText: '',
                    hintText: 'Enter employer name',
                    errorText: 'Corporate E-mail is required',
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: "Employer Address",
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    textController: controller.employeeAddressController,
                    focusNode: null,
                    iconData: Icons.email,
                    labelText: '',
                    hintText: 'Enter employer address',
                    errorText: 'Corporate E-mail is required',
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: "Monthly income",
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomDropDown(
                    options: controller.monthlyIncomeTypes,
                    onChanged: (val) {
                      debugPrint(val);
                      controller.selectedMonthlyIncome = val;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: "Source of income",
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomDropDown(
                    options: controller.sourceOfIncomeOptions,
                    onChanged: (val) {
                      debugPrint(val);
                      controller.selectedSourceOfIncome = val;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomLabel(
                    title: "Reason for opening an account*",
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      GFCheckbox(
                        size: 18,
                        type: GFCheckboxType.basic,
                        inactiveBorderColor: Color.fromRGBO(209, 215, 219, 1),
                        activeBgColor: MyColors.PrimaryColor,
                        activeIcon: Icon(
                          Icons.check,
                          size: 15,
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          controller.onSavingGhady();
                        },
                        value: controller.isSavingGhady,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomLabel(
                          title: "Saving with Ghady (investment)",
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      GFCheckbox(
                        size: 18,
                        type: GFCheckboxType.basic,
                        inactiveBorderColor: Color.fromRGBO(209, 215, 219, 1),
                        activeBgColor: MyColors.PrimaryColor,
                        activeIcon: Icon(
                          Icons.check,
                          size: 15,
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          controller.onGeneralInsurance();
                        },
                        value: controller.isGeneralInsurance,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CustomLabel(
                        title: 'general_insurance'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      GFCheckbox(
                        size: 18,
                        type: GFCheckboxType.basic,
                        inactiveBorderColor: Color.fromRGBO(209, 215, 219, 1),
                        activeBgColor: MyColors.PrimaryColor,
                        activeIcon: Icon(
                          Icons.check,
                          size: 15,
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          controller.onViewingMedicalBenefits();
                        },
                        value: controller.viewMedicalBenefits,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CustomLabel(
                        title: 'viewing_medical_benefits'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
