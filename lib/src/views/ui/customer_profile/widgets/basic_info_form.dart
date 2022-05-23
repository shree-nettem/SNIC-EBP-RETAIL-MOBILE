import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_international_phone_validate.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/base/custom_toogle.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/basic_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicInfoFormView extends StatelessWidget {
  final BasicInfoXController controller = Get.put(BasicInfoXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (cont) {
        return Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Full Name
              CustomLabel(
                title: 'firstName'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                isReadOnly: true,
                isDisableColored: true,
                textController: controller.nameController,
                labelText: '',
                hintText: 'enter_name'.tr,
                validate: true,
                isEnabled: true,
                validator: AppFormFieldValidator.generalEmptyValidator,
                onSaved: (value) {
                  controller.setName(value);
                },
                onChanged: (value) {
                  AppFormFieldValidator.generalEmptyValidator(value);
                  controller.setFullName();
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
                isReadOnly: true,
                isDisableColored: true,
                textController: controller.middleNameController,
                labelText: '',
                hintText: 'enterMiddleName'.tr,
                validate: true,
                isEnabled: true,
                onSaved: (value) {
                  // _dependentController.setName(value);
                },
                onChanged: (value) {
                  controller.setFullName();
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
                isReadOnly: true,
                isDisableColored: true,
                textController: controller.lastNameController,
                labelText: '',
                hintText: 'enterLastName'.tr,
                validate: true,
                isEnabled: true,
                validator: AppFormFieldValidator.generalEmptyValidator,
                onSaved: (value) {
                  // _dependentController.setName(value);
                },
                onChanged: (value) {
                  AppFormFieldValidator.generalEmptyValidator(value);
                  controller.setFullName();
                },
              ),
              SizedBox(
                height: 20,
              ),

              //Email ID
              CustomLabel(
                title: 'email_*'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.VERIFY_PASSWORD, arguments: {
                    "change_email": true,
                  });
                },
                child: CustomTextField(
                  isReadOnly: true,
                  textController: controller.emailController,
                  labelText: '',
                  hintText: 'enterEmailId'.tr,
                  validate: true,
                  isEnabled: false,
                  isSuffix: true,
                  image: Images.edit_email,
                  validator: AppFormFieldValidator.emailValidator,
                  onSaved: (value) {
                    controller.setEmail(value);
                  },
                  onChanged: (value) {
                    AppFormFieldValidator.emailValidator(value);
                  },
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //Gender
              CustomLabel(
                title: 'gender'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 5,
              ),
              CustomToggle(
                totalItems: ['Male', 'Female'],
                onTap: (val) {
                  // controller.switchGenderStatus(val);
                },
                isStatusSelected: controller.isGenderStatusSelected,
              ),

              SizedBox(
                height: 20,
              ),

              //Marital Status
              CustomLabel(
                title: 'marital_status'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 5,
              ),
              CustomToggle(
                totalItems: ['Single', 'Married'],
                onTap: (val) {
                  // controller.switchMaritalStatus(val);
                },
                isStatusSelected: controller.isMartialStatusSelected,
              ),

              //DatePicker
              SizedBox(
                height: 20,
              ),

              //Date Picker
              CustomLabel(
                title: 'dateOfBirth'.tr,
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  // Utils.selectDate(context, DateTime.now())
                  //     .then((value) => controller.dateController.text = value);
                },
                child: CustomTextField(
                  isReadOnly: true,
                  isDisableColored: true,
                  textController: controller.dateController,
                  image: Images.date_picker,
                  isSuffix: true,
                  labelText: '',
                  hintText: 'Select DOB',
                  validate: true,
                  isEnabled: false,
                  onSaved: (value) {
                    controller.setDate(value);
                  },
                  onChanged: (value) {},
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //Contact number
              CustomLabel(
                title: "Contact Number*",
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 5,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.VERIFY_PASSWORD, arguments: {
                      "change_email": false,
                    });
                  },
                  child: CustomTextField(
                    textInputType: TextInputType.number,
                    textController: controller.contactNumController,
                    labelText: '',
                    hintText: 'Mobile Number',
                    validate: true,
                    isEnabled: false,
                    isReadOnly: true,
                    image: Images.edit_email,
                    isSuffix: true,
                    showcountryCodePicker: true,
                    mobileCountryCode: controller.countryCode,
                    validator: AppFormFieldValidator.validateMobile,
                    onSaved: (value) {},
                    onChanged: (value) {
                      AppFormFieldValidator.validateMobile(value);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomLabel(
                title: "Secondary Contact Number",
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 5,
              ),

              CustomInternationalPhoneValidate(
                initialPhoneNumber: controller.alternateNumber,
                phoneController: controller.alternateNumController,
                hintText: 'Alternate Mobile Number',
                onSaved: (value) {
                  controller.alternateNumController.text = value;
                },
                dailCode: (val) {
                  controller.updatedCountryCode(val);
                },
              ),

              SizedBox(
                height: 20,
              ),
              //
              CustomLabel(
                title: "Occupation*",
                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                textController: controller.occupationController,
                labelText: '',
                isReadOnly: true,
                isDisableColored: true,
                hintText: 'Occupation',
                validate: true,
                isEnabled: true,
                onSaved: (value) {
                  controller.setOccupation(value);
                },
                onChanged: (value) {},
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
