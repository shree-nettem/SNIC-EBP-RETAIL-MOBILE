import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_expandabletile.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/submit_claim_screen_controller.dart';
import 'package:ebpv2/src/views/ui/medical_claim/submit_claim/widgets/enter_claim_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'widgets/upload_document_form.dart';

class SubmitClaimScreen extends StatelessWidget {
  final SubmitClaimScreenXController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (cntrlr) {
          return ListView(
            children: [
              CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
              Container(
                child: SvgPicture.asset(
                  Images.medical_claim_image,
                ),
              ),
              CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
              CustomExpandableTile(
                expansionCardKey: _controller.formKey,
                classview: EnterClaimDetailsForm(),
                title: '1',
                name: "enterClaimDetails".tr,
                isButtonVisible: _controller.isDetailsAdded
                    ? false
                    : _controller.isEnterClaimViewExpanded,
                isStatusVisible: _controller.isDetailsAdded ? true : false,
                status: "completed".tr,
                onExpansionChanged: (val) {
                  _controller.togglClaimView();
                },
                onButtonClick: () {
                  _controller.formKey.currentState.expand();
                },
                buttonText: 'start'.tr,
              ),
              IgnorePointer(
                ignoring: _controller.filedUploaded
                    ? _controller.filedUploaded
                    : !_controller.isDetailsAdded,
                child: Opacity(
                  opacity: _controller.isDetailsAdded ? 1 : 0.5,
                  child: CustomExpandableTile(
                    expansionCardKey: _controller.documentFormKey,
                    classview: UploadDocumentForm(),
                    title: '2',
                    name: "uploadDocuments".tr,
                    // isTileDisable: false,
                    isButtonVisible: false,
                    isStatusVisible: false,
                    onExpansionChanged: (val) {
                      if (_controller.isUploadDocumentExpanded) {
                        _controller.isUploadDocumentExpanded = false;
                      } else {
                        _controller.isUploadDocumentExpanded = true;
                      }
                      print(_controller.isUploadDocumentExpanded);
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}
