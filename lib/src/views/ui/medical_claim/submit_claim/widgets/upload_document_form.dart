import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/widgets/upload_document_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadDocumentForm extends StatelessWidget {
  UploadDocumentForm({Key key}) : super(key: key);

  final UploadDocumentFormXController _controller =
      Get.put(UploadDocumentFormXController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (cnntrlr) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _uploadDocumentItem("reimbursementForm".tr, 5),
                _uploadDocumentItem("invoices".tr, 8),
                _uploadDocumentItem("addNewDocument".tr, 10),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                CustomButton(
                  title: "confirm".tr,
                  width: 110,
                  height: 26,
                  buttonAction: () {
                    if (_controller.reimbbursementFrom != null &&
                        _controller.receipts != null) {
                      _controller.submitClaim();
                    } else {
                      errorMessage("addDocuments".tr);
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        });
  }

  _uploadDocumentItem(String title, int type) {
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
              _buildStartButton(type)
            ],
          ),
          if ((type == 5 && _controller.reimbbursementFrom != null) ||
              (type == 8 && _controller.receipts != null) ||
              (type == 10 && _controller.newDoc != null))
            Row(
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
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 5, top: 10),
                    child: CustomLabel(
                      title: type == 5
                          ? "${_controller.reimbbursementFrom.path.split('/').last ?? ""}"
                          : type == 8
                              ? "${_controller.receipts.path.split('/').last ?? ""}"
                              : "${_controller.newDoc.path.split('/').last ?? ""}",
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 14,
                      maxLines: 5,
                      color: MyColors.GrayColor,
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  /* SAVE BUTTON */
  Widget _buildStartButton(int type) {
    return Center(
      child: CustomButton(
        title: "upload".tr,
        width: 75,
        fontSize: 12,
        height: 26,
        bgColor: MyColors.VerticalDividerColor,
        buttonAction: () {
          _showPicker(type);
        },
      ),
    );
  }

  void _showPicker(int type) {
    showModalBottomSheet(
      context: Get.context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: label("gallery".tr, fontSize: MediumFontSize),
                  onTap: () {
                    _controller.getImageGallery(type);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: label("camera".tr, fontSize: MediumFontSize),
                  onTap: () {
                    _controller.getImageCamera(type);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
