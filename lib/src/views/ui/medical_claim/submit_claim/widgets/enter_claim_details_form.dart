import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_drop_down.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/submit_claim_screen_controller.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/widgets/enter_claim_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterClaimDetailsForm extends StatelessWidget {
  bool needProgressLine;
  EnterClaimDetailsForm({Key key, this.needProgressLine = true})
      : super(key: key);
  final EnterClaimDetailsXController _controller =
      Get.put(EnterClaimDetailsXController());
  final SubmitClaimScreenXController _subbmitController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return Form(
              key: _controller.formKey,
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (needProgressLine)
                            Container(
                              height: 650,
                              width: 2,
                              color: MyColors.themeColor,
                            ),
                          if (needProgressLine)
                            SizedBox(
                              width: 20,
                            ),
                          Flexible(
                            child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    CustomLabel(
                                      title: "claimantName".tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomDropDown(
                                      label: _controller.totalClaimantNames[0],
                                      options: _controller.totalClaimantNames,
                                      validator: AppFormFieldValidator
                                          .generalDropDownValidator,
                                      onChanged: (val) {
                                        AppFormFieldValidator
                                            .generalDropDownValidator(val);
                                        _controller.setClaim(val);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomLabel(
                                      title: "treatmentDate".tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Utils.selectDate(
                                                context, DateTime.now(),
                                                firstDate: DateTime(1975),
                                                lastDate: DateTime.now())
                                            .then((value) => _controller
                                                .treatmentDateController
                                                .text = value);
                                      },
                                      child: CustomTextField(
                                        isReadOnly: true,
                                        textController:
                                            _controller.treatmentDateController,
                                        image: Images.date_picker,
                                        isSuffix: true,
                                        labelText: '',
                                        hintText: "date".tr,
                                        validate: true,
                                        isEnabled: false,
                                        onChanged: (value) {},
                                      ),
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomLabel(
                                      title: "totalClamiedAmount".tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextField(
                                      textController: _controller
                                          .totalClaimedAmountController,
                                      labelText: '',
                                      textInputType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      hintText: "enterAmount".tr,
                                      validate: true,
                                      showcurrencyPicker: true,
                                      initialCurrency:
                                          _controller.selectedCurrency,
                                      totalCurrencies:
                                          _controller.totalCurrency,
                                      currencyOnChanged: (val) {
                                        _controller.selectedCurrency = val;
                                      },
                                      isEnabled: true,
                                      validator: AppFormFieldValidator
                                          .currencyValidator,
                                      onSaved: (value) {
                                        //controller.setEmail(value);
                                      },
                                      onChanged: (value) {
                                        AppFormFieldValidator.currencyValidator(
                                            value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomLabel(
                                      title: "medicalProvider".tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextField(
                                      textController:
                                          _controller.medicalProviderController,
                                      labelText: '',
                                      hintText: "enterMedicalProvider".tr,
                                      validate: true,
                                      isEnabled: true,
                                      validator: AppFormFieldValidator
                                          .generalEmptyValidator,
                                      onChanged: (value) {
                                        AppFormFieldValidator
                                            .generalEmptyValidator(value);
                                      },
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomLabel(
                                      title: "country".tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomDropDown(
                                      label: _controller.claimerNationality,
                                      options: Constants.baseCountries,
                                      validator: AppFormFieldValidator
                                          .generalDropDownValidator,
                                      onChanged: (val) {
                                        AppFormFieldValidator
                                            .generalDropDownValidator(val);
                                        _controller.setNationality(val);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    //Date Pickeer
                                    CustomLabel(
                                      title: "iban".tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextField(
                                      textController:
                                          _controller.ibanController,
                                      labelText: '',
                                      hintText: "enteriban".tr,
                                      validate: true,
                                      isEnabled: true,
                                      validator:
                                          AppFormFieldValidator.iBanValidator,
                                      onChanged: (value) {
                                        AppFormFieldValidator.iBanValidator(
                                            value);
                                        // _controller.ibanController.text =
                                        //     toPrintFormat(value);
                                      },
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomLabel(
                                      title: "noteRemarks".tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextField(
                                      textController:
                                          _controller.remarksController,
                                      labelText: '',
                                      hintText: "optional".tr,
                                      validate: true,
                                      isEnabled: true,
                                      // validator: AppFormFieldValidator
                                      // .generalEmptyValidator,
                                      onChanged: (value) {
                                        // AppFormFieldValidator
                                        //     .generalEmptyValidator(value);
                                      },
                                    ),
                                  ]),
                            ),
                          ),

                          // _buildSaveButton()
                        ]),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _subbmitController.formKey.currentState.collapse();
                          },
                          child: CustomBackNextutton(
                            isBackButton: true,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (_controller.formKey.currentState.validate()) {
                              if (_controller.treatmentDateController.text !=
                                  "") {
                                _controller.saveProfileData();
                              }
                            }
                          },
                          child: CustomBackNextutton(
                            isBackButton: false,
                          ),
                        ),
                      ],
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
        title: "save".tr,
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
