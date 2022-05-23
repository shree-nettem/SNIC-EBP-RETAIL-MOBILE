import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_radio_button.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/minor_motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiniMotorCalimFlow extends StatelessWidget {
  MotorClaimXController claimController = Get.find();
  MotorClaimDetailsXController motorClaimcontroller = Get.find();
  MinorMotorCalimXController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: CustomLabel(
            title: 'eTrafficApplication'.tr,
            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            maxLines: 2,
          ),
        ),
        CustomRadioButton(
          text: 'yes'.tr,
          value: _controller.eTrafficApplication[0],
          onTap: () {
            _controller.switchETrafficApplication(0, claimController);
          },
        ),
        CustomRadioButton(
          text: 'no'.tr,
          value: _controller.eTrafficApplication[1],
          onTap: () {
            _controller.switchETrafficApplication(1, claimController);
          },
        ),
        _controller.eTrafficApplication[0]
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: CustomLabel(
                      title: 'intimationNumber'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      maxLines: 2,
                    ),
                  ),
                  CustomTextField(
                    textController: _controller.intimationNumber,
                    labelText: '',
                    hintText: 'intimationNumber'.tr,
                    validate: true,
                    isEnabled: true,
                    onChanged: (value) {},
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                    child: CustomLabel(
                      title: 'requiredDocuments'.tr,
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    ),
                  ),
                  _uploadDocumentItem('Ownership\n(front)'),
                  _uploadDocumentItem('Ownership\n(back)'),
                  _uploadDocumentItem('Driving license\n(front)'),
                  _uploadDocumentItem('Driving license\n(back)'),
                  Container(
                      margin: EdgeInsets.all(20.0),
                      child: _buildStartButton('Next', ''))
                ],
              )
            : _controller.eTrafficApplication[1]
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.0, bottom: 0.0),
                        child: CustomLabel(
                          title: 'step1'.tr,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: CustomLabel(
                          title: 'accidentReportNote'.tr,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0, bottom: 0.0),
                        child: CustomLabel(
                          title: 'step2'.tr,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: CustomLabel(
                          title: 'insuraceApplicationNote'.tr,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  )
                : Container(),
        SizedBox(
          height: 20,
        ),
      ]),
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
              _buildStartButton('Upload', title)
            ],
          ),
          Visibility(
            visible: claimController.isMinorMotorClaimSelected &&
                    _controller.alreadyExist(title)
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
  Widget _buildStartButton(String title, String docName) {
    return Center(
      child: CustomButton(
        title: title.tr,
        width: 75,
        fontSize: 12,
        height: 26,
        bgColor: title == 'Upload'
            ? MyColors.VerticalDividerColor
            : MyColors.PrimaryColor,
        buttonAction: () {
          if (title == 'Next') {
            if (_controller.checkAllDocumentsSubmitted()) {
              _controller.submitClaim();
            } else {
              CustomDialogHelper.showAlertDialog(
                  title: "Alert",
                  description: "All Document are mandatory",
                  okBtnFunction: () {
                    Get.back();
                  });
            }
          } else {
            Utils.showPickerImagePicker(
                hideCamerabutton: true,
                galleryBtn: () {
                  if (claimController.isMinorMotorClaimSelected) {
                    _controller.getImageGallery(docName);
                  }
                },
                cameraBtn: () {
                  if (claimController.isMinorMotorClaimSelected) {
                    _controller.getImageCamera(docName);
                  }
                });
          }
        },
      ),
    );
  }
}
