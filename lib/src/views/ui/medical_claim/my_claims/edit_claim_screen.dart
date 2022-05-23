import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/widgets/enter_claim_details_form.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/widgets/upload_document_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditClaimScreen extends StatelessWidget {
  const EditClaimScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: "healthClaim".tr,
            isBackButtonExist: true,
            isActionButtonExist: false,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child:
                Container(color: Colors.white, child: _editClaimView(context)),
          )
        ],
      ),
    );
  }

  _editClaimView(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 2,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomLabel(
                      fontSize: 16,
                      title: "editClaim".tr,
                      fontFamily: Constants.FONT_PROXIMA_NOVA,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  EnterClaimDetailsForm(
                    needProgressLine: false,
                  ),
                  CustomSpacer(
                    value: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _uploadDocumentItem("policeReport".tr),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _uploadDocumentItem("ownership".tr),
                  ),
                  CustomSpacer(
                    value: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  _buildSaveButton()
                ],
              ),
            ),
          ),
        ),
        _cancelClaimsButton(context, "cancelClaim".tr),
        CustomSpacer(
          value: Dimensions.PADDING_SIZE_DEFAULT * 2,
        ),
      ],
    );
  }

  _uploadDocumentItem(String title) {
    return Column(
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
            _builduploadButton()
          ],
        ),
        CustomSpacer(
          value: Dimensions.PADDING_SIZE_DEFAULT,
        ),
      ],
    );
  }

  /* upload BUTTON */
  Widget _builduploadButton() {
    return Center(
      child: CustomButton(
        title: "upload".tr,
        width: 75,
        fontSize: 12,
        height: 26,
        bgColor: MyColors.VerticalDividerColor,
        buttonAction: () {},
      ),
    );
  }

  /* SAVE BUTTON */
  Widget _buildSaveButton() {
    return Center(
      child: CustomButton(
        title: "save".tr,
        width: 114,
        fontSize: 12,
        height: 26,
        buttonAction: () {},
      ),
    );
  }

  /* ADD NEW DEPENDET BUTTON */
  Widget _cancelClaimsButton(
    BuildContext context,
    String title, {
    Function onclick,
  }) {
    return Center(
      child: CustomButton(
        title: title,
        width: MediaQuery.of(context).size.width / 2 + 50,
        fontSize: 12,
        paddingWidth: 10,
        height: 40,
        buttonAction: () {},
      ),
    );
  }
}
