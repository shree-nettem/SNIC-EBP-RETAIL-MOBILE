import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/financial_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FinancialDetailsFormView extends StatelessWidget {
  final FinancialDetailsXController controller =
      Get.put(FinancialDetailsXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return VisibilityDetector(
          key: Key('financial-widget-key'),
          onVisibilityChanged: (VisibilityInfo info) {
            if (info.visibleFraction > 0.5) {
              debugPrint("${info.visibleFraction} of my widget is visible");
              controller.setData();
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
                //Monthly Income
                CustomLabel(
                  title: "Monthly Income*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomDropDown(
                  label: controller.monthlyIncomeTypes[0],
                  options: controller.monthlyIncomeTypes,
                  isDisableColored: true,
                  onChanged: null,
                ),

                SizedBox(
                  height: 20,
                ),

                //Email ID
                CustomLabel(
                  title: "Source of income*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),

                SizedBox(
                  height: 5,
                ),
                CustomDropDown(
                  label: controller
                      .sourceOfIncomeOptions[controller.sourceOfIncomeIndex],
                  options: controller.sourceOfIncomeOptions,
                  isDisableColored: true,
                  onChanged: null,
                ),
                SizedBox(
                  height: 20,
                ),

                CustomLabel(
                  title: "Bank*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),

                SizedBox(
                  height: 5,
                ),
                CustomDropDown(
                  label: controller.baseBanks[controller.bankIndex],
                  options: controller.baseBanks,
                  isDisableColored: controller.bank != null ? true : false,
                  onChanged: (val) {
                    AppFormFieldValidator.generalDropDownValidator(val);
                    controller.setBank(val);
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                CustomLabel(
                  title: "IBAN*",
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  textController: controller.IBANController,
                  labelText: '',
                  hintText: 'IBAN Number',
                  validate: true,
                  isEnabled: true,
                  isReadOnly:
                      controller.IBANController.text.isNotEmpty ? true : false,
                  isDisableColored:
                      controller.IBANController.text.isNotEmpty ? true : false,
                  onSaved: (value) {},
                ),
                SizedBox(
                  height: 30,
                ),
                // _buildSaveButton()
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
        title: 'Save',
        width: 114,
        fontSize: 12,
        height: 26,
        buttonAction: () {
          controller.formKey.currentState.validate();
          // Get.toNamed(AppRoutes.MOBILE_EMAIL_VERIFICATION);
        },
      ),
    );
  }
}
