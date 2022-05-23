import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/upload_document_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CashPayment extends StatelessWidget {
  final MotorPalnXController controller = Get.find();
  final MotorXController motorXController = Get.find();
  final VehicleDetailsXController vehicleDetailsXController = Get.find();
  final UploadDocumentController _documentController = Get.find();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabel(
              title: "Enter Vehicle details:",
              fontFamily: Constants.FONT_PROXIMA_NOVA,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 15,
            ),
            CustomLabel(
              title: "Vehicle Number*",
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              fontSize: 14,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              textController: controller.vehicleNumber,
              labelText: '',
              hintText: 'vehicleNumber'.tr,
              textInputType: TextInputType.number,
              keyboardInputType: InputTypeEnum.numeric,
              validate: true,
              restrictSpecialCharecter: true,
              isEnabled: controller.isQuotIssued ? false : true,
              onSaved: (value) {},
              validator: (value) {
                return AppFormFieldValidator.vehicleNumberValidator(value);
              },
              onChanged: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            CustomLabel(
              title: "${'chassisNumber'.tr}*",
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              fontSize: 14,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              textController: controller.chassisNumber,
              labelText: '',
              hintText: 'chassisNumber'.tr,
              validate: true,
              validator: (value) {
                return AppFormFieldValidator.chasisNumberValidator(value);
              },
              isEnabled: controller.isQuotIssued ? false : true,
              onSaved: (value) {},
              onChanged: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            // CustomLabel(
            //   title: 'eGovtExpDate'.tr,
            //   fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // InkWell(
            //   onTap: () {
            //     var now = DateTime.now();
            //     Utils.selectDate(context, now,
            //             firstDate: now, lastDate: DateTime(2101))
            //         .then((value) => controller.eGovExpieryDate.text = value);
            //     controller.update();
            //   },
            //   child: CustomTextField(
            //     isReadOnly: true,
            // textController: controller.eGovExpieryDate,
            //     image: Images.date_picker,
            //     isSuffix: true,
            //     labelText: '',
            //     hintText: 'date'.tr,
            //     validate: true,
            //     isEnabled: false,
            //     onChanged: (value) {
            //       controller.eGovExpieryDate.text = value;
            //     },
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            CustomLabel(
              title: 'policyExpirydate'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
            SizedBox(
              height: 5,
            ),
            CustomTextField(
              isReadOnly: true,
              textController: vehicleDetailsXController.policyExpiryDate,
              labelText: '',
              hintText: 'date'.tr,
              isEnabled: false,
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
              visible: !controller.isQuotIssued ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      controller.onBackPressed();
                    },
                    child: CustomBackNextutton(
                      isBackButton: true,
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    title: 'next'.tr,
                    width: 90,
                    height: 26,
                    buttonAction: () {
                      if (formKey.currentState.validate()) {
                        // if (vehicleDetailsXController.isBrandNew[1]) {
                        //   controller.getEGovt();
                        // } else if (vehicleDetailsXController.isBrandNew[0]) {
                        DateTime startDate = DateFormat("yyyy-MM-dd").parse(
                            vehicleDetailsXController.policyStartDate.text);
                        DateTime lastDayOfMonth = new DateTime(
                            startDate.year + 1, startDate.month + 1, 0);
                        vehicleDetailsXController.policyExpiryDate.text =
                            lastDayOfMonth.toString();
                        controller.getPlanDetails(
                            paymentMethodCall: true, updateDetails: false);
                        // }
                      }

                      //motorXController.expansionCardKey[1].currentState.collapse();
                    },
                  ),
                ],
              ),
            ),

            /* Container(
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Row(
                children: [
                  CustomLabel(
                    title: MyString.dealerQutation,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Spacer(),
                  CustomButton(
                    isActive: false,
                    title: MyString.upload,
                    bgColor: MyColors.VerticalDividerColor,
                    buttonAction: () {},
                    width: 90,
                    height: 26,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Row(
                children: [
                  CustomLabel(
                    title: MyString.scanNewCPR,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Spacer(),
                  CustomButton(
                    isActive: false,
                    title: MyString.scan,
                    bgColor: MyColors.VerticalDividerColor,
                    buttonAction: () {},
                    width: 90,
                    height: 26,
                  )
                ],
              ),
            ),*/

            Visibility(
                visible: controller.isQuotIssued ? true : false,
                child: Column(
                  children: [
                    CustomLabel(
                      title: 'requiredDocuments'.tr,
                      fontFamily: Constants.FONT_PROXIMA_NOVA,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CustomLabel(
                                  title: vehicleDetailsXController.isBrandNew[0]
                                      ? 'dealerQutation'.tr
                                      : 'ownership'.tr,
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                  fontSize: 14,
                                  maxLines: 2,
                                ),
                              ),
                              Center(
                                child: CustomButton(
                                  title: 'upload'.tr,
                                  width: 75,
                                  fontSize: 12,
                                  height: 26,
                                  bgColor: MyColors.VerticalDividerColor,
                                  buttonAction: () {
                                    Utils.showPickerImagePicker(
                                        hideCamerabutton: true,
                                        galleryBtn: () {
                                          _documentController
                                              .getImageGallery(1);
                                        },
                                        cameraBtn: () {
                                          _documentController.getImageCamera(1);
                                        });
                                  },
                                ),
                              )
                            ],
                          ),
                          Obx(() => _documentController
                                  .isDealerQuotionUploaded.value
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.zero,
                                          color: MyColors.container_Bg,
                                          height: 15,
                                          width: 1,
                                        ),
                                        Container(
                                          color: MyColors.container_Bg,
                                          height: 1,
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5, top: 10),
                                      child: CustomLabel(
                                        title: vehicleDetailsXController
                                                .isBrandNew[0]
                                            ? 'dealerQutation'.tr
                                            : 'ownership'.tr,
                                        fontFamily:
                                            Constants.FONT_SF_UI_TEXT_REGULAR,
                                        fontSize: 14,
                                        maxLines: 2,
                                        color: MyColors.GrayColor,
                                      ),
                                    ),
                                  ],
                                )
                              : Container())
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !controller.verification.personalVerification
                          ? true
                          : false,
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomLabel(
                                    title: 'scanNewCPR'.tr,
                                    fontFamily:
                                        Constants.FONT_SF_UI_TEXT_REGULAR,
                                    fontSize: 14,
                                    maxLines: 2,
                                  ),
                                ),
                                Center(
                                  child: CustomButton(
                                    title: 'scan'.tr,
                                    width: 75,
                                    fontSize: 12,
                                    height: 26,
                                    bgColor: MyColors.VerticalDividerColor,
                                    buttonAction: () {
                                      //? CALL JUMIO SDK FOR CPR
                                      controller.initializeJumio();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible:
                                  _documentController.isCprValid ? true : false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.zero,
                                        color: MyColors.container_Bg,
                                        height: 15,
                                        width: 1,
                                      ),
                                      Container(
                                        color: MyColors.container_Bg,
                                        height: 1,
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5, top: 10),
                                    child: CustomLabel(
                                      title: 'tittle'.tr,
                                      fontFamily:
                                          Constants.FONT_SF_UI_TEXT_REGULAR,
                                      fontSize: 14,
                                      maxLines: 2,
                                      color: MyColors.GrayColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.onBackPressed();
                          },
                          child: CustomBackNextutton(
                            isBackButton: true,
                          ),
                        ),
                        Spacer(),
                        CustomButton(
                          title: 'next'.tr,
                          width: 90,
                          height: 26,
                          buttonAction: () {
                            if (vehicleDetailsXController.draftFormat.result
                                    .isDealerQuotionUploaded ||
                                _documentController
                                    .isDealerQuotionUploaded.value) {
                              controller.cashNextButton();
                            } else {
                              CustomDialogHelper.showAlertDialog(
                                  title: "Alert",
                                  description: "Dealer quotation is mandatory",
                                  okBtnFunction: () {
                                    Get.back();
                                  });
                            }
                            //motorXController.expansionCardKey[1].currentState.collapse();
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

/* void _showPicker(int decider) {
    showModalBottomSheet(
      context: Get.context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: label(MyString.gallery, fontSize: MediumFontSize),
                  onTap: () {
                    _documentController.getImageGallery(decider);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: label(MyString.camera, fontSize: MediumFontSize),
                  onTap: () {
                    _documentController.getImageCamera(decider);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }*/
}
