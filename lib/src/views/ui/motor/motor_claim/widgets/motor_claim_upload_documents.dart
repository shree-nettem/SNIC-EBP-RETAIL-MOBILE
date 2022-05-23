import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/windshiled_claim_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MotorClaimUploadDocument extends StatelessWidget {
  MotorClaimXController claimController = Get.find();
  MotorClaimDetailsXController _controller = Get.find();
  WindScreenClaimFlowXController windScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Visibility(
              visible: claimController.isPoliceReportSelected ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _uploadDocumentItem('Police Report'),
                  _uploadDocumentItem('Ownership\n(front)'),
                  _uploadDocumentItem('Ownership\n(back)'),
                  _uploadDocumentItem('Copy of IBAN'),
                  _uploadDocumentItem('Driving license\n(front)'),
                  _uploadDocumentItem('Driving license\n(back)'),
                  if (!(_controller.verification.personalVerification) ||
                      _controller.selectedDriverType == "Not Policy Holder")
                    _uploadDocumentItem('CPR\n(front)'),
                  if (!(_controller.verification.personalVerification) ||
                      _controller.selectedDriverType == "Not Policy Holder")
                    _uploadDocumentItem('CPR\n(back)'),
                  _uploadDocumentItem('otherDocuments'.tr),
                ],
              )),
          Visibility(
              visible: claimController.isCarWindScreenSelected ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _uploadDocumentItem('windSceenPicture'.tr),
                  _uploadDocumentItem('carPicture'.tr),
                ],
              )),
          CustomSpacer(
            value: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          CustomButton(
            title: 'confirm'.tr,
            width: 110,
            height: 26,
            buttonAction: () {
              print('clicked');
              if (claimController.isPoliceReportSelected) {
                if (_controller.checkAllDocumentsSubmitted()) {
                  _controller.submitClaim("Motor claim with police report");
                } else {
                  CustomDialogHelper.showAlertDialog(
                      title: "Alert",
                      description: "All Document are mandatory",
                      okBtnFunction: () {
                        Get.back();
                      });
                }
              } else if (claimController.isCarWindScreenSelected) {
                if (windScreenController.checkAllDocumentsSubmitted()) {
                  windScreenController.submitClaim("Car Windscreen claim");
                } else {
                  CustomDialogHelper.showAlertDialog(
                      title: "Alert",
                      description: "All Document are mandatory",
                      okBtnFunction: () {
                        Get.back();
                      });
                }
              }
            },
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  _uploadDocumentItem(String title) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomLabel(
                  title: title,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 14,
                  maxLines: 2,
                ),
              ),
              _buildStartButton(title)
            ],
          ),
          Visibility(
            visible: claimController.isPoliceReportSelected &&
                    _controller.alreadyExist(title)
                ? true
                : claimController.isCarWindScreenSelected &&
                        windScreenController.alreadyExist(title)
                    ? true
                    : false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    title: "$title.pdf",
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
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
    );
  }

  /* SAVE BUTTON */
  Widget _buildStartButton(String title) {
    return Center(
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
                if (claimController.isPoliceReportSelected) {
                  _controller.getImageGallery(title);
                } else if (claimController.isCarWindScreenSelected) {
                  windScreenController.getImageGallery(title);
                }
              },
              cameraBtn: () {
                if (claimController.isPoliceReportSelected) {
                  _controller.getImageCamera(title);
                } else if (claimController.isCarWindScreenSelected) {
                  windScreenController.getImageCamera(title);
                }
              });
        },
      ),
    );
  }
}
