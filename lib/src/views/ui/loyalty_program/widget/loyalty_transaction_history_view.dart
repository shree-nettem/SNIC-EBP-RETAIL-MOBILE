import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_divider.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/loyalty_program/controllers/loyalty_program_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoyaltyTransactionHistoryView extends StatelessWidget {
  final LoyaltyPointsHistoryController controller = Get.find();
  final int index;

  LoyaltyTransactionHistoryView({this.index});

  @override
  Widget build(BuildContext context) {
    int transactionValue =
        controller.loyaltyTransactionHistoryList[index].value.toInt();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomLabel(
              title: controller.loyaltyTransactionHistoryList[index].date,
              color: Color.fromRGBO(207, 215, 219, 1),
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.FONT_SIZE_SMALL,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              height: 1.6,
            ),
          ),
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: SvgPicture.asset(Images.open_transfer),
                    ),
                    CustomSpacer(
                      value: 8,
                      isHeight: false,
                    ),
                    CustomLabel(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        title: controller.loyaltyTransactionHistoryList[index]
                                .activity ??
                            "",
                        height: 1.9),
                  ],
                ),
                CustomLabel(
                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    title: transactionValue.toString() + " pts" ?? "0 pts",
                    color: transactionValue.isNegative
                        ? Color.fromRGBO(214, 125, 122, 1)
                        : MyColors.turquoise,
                    height: 1.9),
              ],
            ),
          ),
          CustomDivider(
            color: Color.fromRGBO(241, 243, 245, 1),
          ),
          // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
          // Center(
          //   child: CustomLabel(
          //     fontSize: Dimensions.FONT_SIZE_SMALL,
          //     fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          //     fontWeight: FontWeight.w600,
          //     title: "View more",
          //   ),
          // ),
        ],
      ),
    );
  }
}
