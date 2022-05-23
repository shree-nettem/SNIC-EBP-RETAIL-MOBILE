import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/mailing_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'custom_town_drop_down_view.dart';

class MailingInfoForm extends StatelessWidget {
  final MailingInfoXController _mailingController =
      Get.put(MailingInfoXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _mailingController,
      builder: (_) {
        return VisibilityDetector(
          key: Key('mail-widget-key'),
          onVisibilityChanged: (VisibilityInfo info) {
            if (info.visibleFraction > 0.1) {
              debugPrint("${info.visibleFraction} of my widget is visible");
              _mailingController.setData(!_mailingController.isMailVisible);
            } else {
              debugPrint("${info.visibleFraction} of my widget is invisible");
            }
          },
          child: Form(
            key: _mailingController.formKey,
            child: Stack(
              children: [
                Visibility(
                  visible: !_mailingController.isEditClicked.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          _mailingController.changeEditingStatus();
                        },
                        child: SvgPicture.asset(
                          Images.edit,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomLabel(
                      title: "Town",
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IgnorePointer(
                      ignoring: _mailingController.isEditing.value,
                      child: CustomTownDropDownView(
                        isDisableColored: _mailingController.isEditing.value,
                        label: _mailingController.mailTown,
                        options: _mailingController.townList,
                        onChanged: (val) {
                          _mailingController.selectedMailingTown = val;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLabel(
                      title: "Block",
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IgnorePointer(
                      ignoring: _mailingController.isEditing.value,
                      child: CustomTextField(
                        isReadOnly: _mailingController.isEditing.value,
                        isDisableColored: _mailingController.isEditing.value,
                        textController:
                            _mailingController.addressBlockController,
                        labelText: '',
                        hintText: 'Block',
                        onSaved: (value) {
                          // controller.setName(value);
                        },
                        onChanged: (val) {
                          _mailingController.selectedMailingBlock = val;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLabel(
                      title: "Road",
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      isReadOnly: _mailingController.isEditing.value,
                      isDisableColored: _mailingController.isEditing.value,
                      textController: _mailingController.mailRoadController,
                      labelText: '',
                      hintText: 'Road',
                      onSaved: (value) {
                        // controller.setName(value);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLabel(
                      title: "House",
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      isReadOnly: _mailingController.isEditing.value,
                      isDisableColored: _mailingController.isEditing.value,
                      textController: _mailingController.mailHouseController,
                      labelText: '',
                      hintText: 'House',
                      validate: true,
                      isEnabled: true,
                      validator: AppFormFieldValidator.generalEmptyValidator,
                      onSaved: (value) {
                        // controller.setName(value);
                      },
                      onChanged: (value) {
                        AppFormFieldValidator.generalEmptyValidator(value);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLabel(
                      title: "Flat",
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      isReadOnly: _mailingController.isEditing.value,
                      isDisableColored: _mailingController.isEditing.value,
                      textController: _mailingController.flatMailController,
                      labelText: '',
                      hintText: 'Flat',
                      validate: true,
                      isEnabled: true,
                      validator: AppFormFieldValidator.generalEmptyValidator,
                      onSaved: (value) {},
                      onChanged: (value) {
                        AppFormFieldValidator.generalEmptyValidator(value);
                      },
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    //HOME ADDRESS
                    CustomLabel(
                      title: 'home_address'.tr,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomLabel(
                      title: 'town'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: CustomTownDropDownView(
                        isDisableColored: true,
                        label: _mailingController.homeTown,
                        options: _mailingController.townList,
                        onChanged: (val) {
                          _mailingController.selectedHomeTown = val;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLabel(
                      title: 'block'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: CustomTextField(
                        isReadOnly: true,
                        isDisableColored: true,
                        textController: _mailingController.homeBlockController,
                        labelText: '',
                        hintText: 'block'.tr,
                        validate: true,
                        isEnabled: true,
                        onSaved: (value) {
                          // controller.setName(value);
                        },
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLabel(
                      title: "Road",
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: CustomTextField(
                        isReadOnly: true,
                        isDisableColored: true,
                        textController: _mailingController.homeRoadController,
                        labelText: '',
                        hintText: 'road'.tr,
                        validate: true,
                        isEnabled: true,
                        onSaved: (value) {
                          // controller.setName(value);
                        },
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLabel(
                      title: 'house'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: CustomTextField(
                        isReadOnly: true,
                        isDisableColored: true,
                        textController: _mailingController.homeHouseController,
                        labelText: '',
                        hintText: 'House',
                        validate: true,
                        isEnabled: true,
                        onSaved: (value) {
                          // controller.setName(value);
                        },
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLabel(
                      title: "Flat",
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: CustomTextField(
                        isReadOnly: true,
                        isDisableColored: true,
                        textController: _mailingController.homeFlatController,
                        labelText: '',
                        hintText: 'Flat',
                        validate: true,
                        isEnabled: true,
                        onSaved: (value) {
                          // controller.setName(value);
                        },
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
