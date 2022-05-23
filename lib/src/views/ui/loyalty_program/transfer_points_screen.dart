import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_dialog.dart';
import 'package:ebpv2/src/views/base/custom_international_phone_validate.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_snackbar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/loyalty_program/controllers/loyalty_program_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferPointsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(title: 'loyalty_program'.tr),
          SliverFillRemaining(
            hasScrollBody: false,
            child: TransferView(),
          ),
        ],
      ),
    );
  }
}

class TransferView extends StatelessWidget {
  final LoyaltyPointsHistoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Container(
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
                  elevation: 4,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    width: Get.width,
                    margin: const EdgeInsets.all(26),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabel(
                          title: 'transfer_points'.tr,
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        ),
                        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                        Row(
                          children: [
                            Container(
                              height: Get.height * 0.35,
                              child: VerticalDivider(
                                color: Color.fromRGBO(64, 162, 190, 1),
                                thickness: 2,
                              ),
                            ),
                            CustomSpacer(
                              value: 16,
                              isHeight: false,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomLabel(
                                    title: 'mobile_no'.tr,
                                    color: MyColors.PrimaryColor,
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                  ),
                                  CustomInternationalPhoneValidate(
                                    initialPhoneNumber: controller.number,
                                    phoneController:
                                        controller.mobileNumberController,
                                    onSaved: (value) {},
                                    dailCode: (val) {
                                      controller.updatedCountryCode(val);
                                    },
                                  ),
                                  CustomSpacer(value: 12),
                                  CustomLabel(
                                    title: 'points_to_transfer'.tr,
                                    color: MyColors.PrimaryColor,
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                  ),
                                  CustomSpacer(value: 8),
                                  CustomTextField(
                                    textController: controller.pointsController,
                                    labelText: "",
                                    hintText: "200",
                                    validate: true,
                                    textInputType: TextInputType.number,
                                    keyboardInputType: InputTypeEnum.numeric,
                                    onSaved: (value) {},
                                    isOtpField: true,
                                    validator: (value) {
                                      return AppFormFieldValidator
                                          .customEmptyValidatorWithMessage(
                                              value, 'please_enter_points'.tr);
                                    },
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        controller
                                            .calculateRemainingPoints(value);
                                      } else {
                                        controller.remainingPoints.value =
                                            controller.loyaltyPointsDetails
                                                .outstandingPoints
                                                .toInt();
                                      }
                                      AppFormFieldValidator
                                          .customEmptyValidatorWithMessage(
                                              value, 'please_enter_points'.tr);
                                    },
                                  ),
                                  CustomSpacer(value: 12),
                                  Obx(
                                    () => CustomLabel(
                                      title:
                                          "Remaining points: ${controller.remainingPoints.toString()}pts",
                                      color: MyColors.PrimaryColor,
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                    ),
                                  ),
                                  CustomSpacer(value: 12),
                                  CustomLabel(
                                    title: 'send_gifts_from_your'.tr,
                                    color: MyColors.PrimaryColor,
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                    maxLines: 10,
                                    height: 1.4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CustomSpacer(value: 32),
                        Center(
                          child: CustomButton(
                            title: 'transfer'.tr,
                            paddingWidth: 8,
                            bgColor: controller.outstandingPoints > 0
                                ? MyColors.PrimaryColor
                                : MyColors.disableGreyColor,
                            isActive: controller
                                        .loyaltyPointsDetails.outstandingPoints
                                        .toInt() >
                                    0
                                ? false
                                : true,
                            buttonAction: () {
                              controller.loyaltyPointsDetails.outstandingPoints
                                          .toInt() >
                                      0
                                  ? validate()
                                  : null;
                            },
                            height: 40,
                            width: Get.width * 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validate() async {
    if (controller.formKey.currentState.validate()) {
      controller.formKey.currentState.save();
      FocusManager.instance.primaryFocus?.unfocus();
      if (int.parse(controller.pointsController.text) <=
          controller.loyaltyPointsDetails.outstandingPoints.toInt()) {
        // CALL API TO GET THE NAME OF THE OTHER USER
        String name = await controller.getCustomerName();
        if (name != null) if (name.isNotEmpty) displayAlertDialog();
      } else {
        showCustomSnackBar("No sufficient balance");
      }
    }
  }

  displayAlertDialog() {
    showAnimatedDialog(
      Align(
        alignment: Alignment.center,
        child: Container(
          height: Get.height * 0.299,
          width: Get.width * 0.8,
          margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
          padding: EdgeInsets.only(top: 20, left: 25, right: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabel(
                  textAlign: TextAlign.start,
                  title: "Are you sure you want to transfer",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  height: 1.8,
                ),
                CustomLabel(
                  textAlign: TextAlign.start,
                  title:
                      "${controller.pointsController.text} points to ${controller.customerName}?",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                ),
                CustomSpacer(value: 24),
                CustomLabel(
                  title:
                      "Transferring your points to your friends and family will be as a gift towards a discount on their transaction. The equivalent points will be deducted from your balance.",
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  maxLines: 5,
                  height: 1.4,
                ),
                CustomSpacer(value: 22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        title: "Cancel",
                        width: 114.0,
                        isActive: false,
                        fontSize: 12,
                        bgColor: Color.fromRGBO(209, 215, 219, 1),
                        height: 26,
                        buttonAction: () {
                          Get.back();
                        }),
                    CustomButton(
                        title: "Transfer",
                        width: 114.0,
                        fontSize: 12,
                        height: 26,
                        buttonAction: () {
                          controller.transferPoints();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
