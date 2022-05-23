import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/contact_form/contact_form_controller.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ComplaintStatusView extends StatelessWidget {
  ComplaintStatusView({Key key}) : super(key: key);

  final ContactFormXController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return Obx(() => Container(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: _controller.totalSuggestedMessages.length == 0
                    ? Center(
                        child: CustomLabel(
                          title: 'noComplaintsAvailable'.tr,
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _controller.totalSuggestedMessages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SigleComplaintExpansionTile(
                            index: index,
                          );
                        },
                      ),
              ));
        });
  }
}

class SigleComplaintExpansionTile extends StatelessWidget {
  SigleComplaintExpansionTile({Key key, this.index}) : super(key: key);
  final ContactFormXController _controller = Get.find();
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTileCard(
        contentPadding: const EdgeInsets.all(8.0),
        initialElevation: 2.0,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: CustomLabel(
                            title:
                                _controller.totalSuggestedMessages[index].name,
                            color: MyColors.PrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStartButton(
                      _controller.totalSuggestedMessages[index].status, 0),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel(
                    title: 'date_submitted'.tr,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                  CustomLabel(
                    title: DateFormat('dd/MM/yyyy').format(
                        _controller.totalSuggestedMessages[index].createdAt),
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel(
                    title: 'message'.tr,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                  CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomLabel(
                    title: _controller
                        .totalSuggestedMessages[index].suggestionMessage,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    maxLines: 100,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(String title, int status) {
    return IgnorePointer(
      child: CustomButton(
        title: title,
        width: 100,
        fontSize: 12,
        height: 26,
        bgColor: _controller.getStatusColor(status),
        buttonAction: () {},
      ),
    );
  }
}
