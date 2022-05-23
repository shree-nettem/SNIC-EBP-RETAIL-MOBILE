import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_check_box.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/whatsapp_deep_link.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/controller/motor_renewal_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReleaseLetterView extends StatelessWidget {
  final MotorRenewalXController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: controller.detail.isMortgage
          ? EdgeInsets.only(top: 20.0)
          : EdgeInsets.all(0.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: controller.detail.isMortgage ? true : false,
            child: CustomCheckBox(
              text: 'release_letter'.tr,
              value: controller.isReleaseLetterSelected,
              onTap: () {
                controller.toggleRelaseLetter();
              },
            ),
          ),
          Visibility(
              visible: controller.detail.isMortgage &&
                      controller.isReleaseLetterSelected
                  ? true
                  : false,
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: WhatsAppDeepLinkView())),
          Visibility(
            visible: !controller.ifYearDiffernceGreaterThen2(),
            child: Column(
              children: [
                Container(
                  margin: !controller.detail.isMortgage
                      ? EdgeInsets.only(top: 20.0)
                      : EdgeInsets.all(0.0),
                  child: CustomLabel(
                    title: 'addYourPlateNumber'.tr,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: CustomTextField(
                    textController: controller.plateNumber,
                    labelText: '',
                    hintText: 'vehicleModel'.tr,
                    validate: true,
                    isEnabled:
                        !controller.isReleaseLetterSelected ? true : false,
                    validator: AppFormFieldValidator.generalEmptyValidator,
                    onSaved: (value) {
                      //controller.setEmail(value);
                    },
                    onChanged: (value) {
                      AppFormFieldValidator.generalEmptyValidator(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !controller.ifYearDiffernceGreaterThen2(),
            child: Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: [
                  CustomLabel(
                    title: 'copyOfOwnerShip'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Spacer(),
                  CustomButton(
                    isActive: false,
                    title: 'upload'.tr,
                    bgColor: MyColors.VerticalDividerColor,
                    buttonAction: () {},
                    width: 90,
                    height: 26,
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: controller.verification != null &&
                    !controller.verification.personalVerification
                ? true
                : false,
            child: Container(
              margin: controller.detail.isMortgage &&
                      controller.ifYearDiffernceGreaterThen2()
                  ? EdgeInsets.only(top: 20.0)
                  : EdgeInsets.all(00.0),
              child: Row(
                children: [
                  CustomLabel(
                    title: 'scanNewCPR'.tr,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Spacer(),
                  CustomButton(
                    isActive: false,
                    title: 'scan'.tr,
                    bgColor: MyColors.VerticalDividerColor,
                    buttonAction: () {
                       controller.initializeJumio();
                    },
                    width: 90,
                    height: 26,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
