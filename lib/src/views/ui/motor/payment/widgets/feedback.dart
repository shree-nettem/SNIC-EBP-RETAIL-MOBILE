import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/motor/payment/widgets/feedback_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FeedBackView extends StatelessWidget {
  final String productName;
  FeedBackView({
    @required this.productName,
  });

  final InnerFeedbackXController _controller =
      Get.put(InnerFeedbackXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return _controller.feedbackAddedToBackend
              ? FeedbackSuccessViewAfterFeedback()
              : Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      CustomLabel(
                        title: 'rateExperience'.tr,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _controller.getFeedbackData(-1, productName);
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  Images.bad,
                                  height: 40,
                                  width: 40,
                                ),
                                CustomLabel(
                                  title: 'bad'.tr,
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          InkWell(
                            onTap: () {
                              _controller.getFeedbackData(0, productName);
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  Images.good,
                                  height: 40,
                                  width: 40,
                                ),
                                CustomLabel(
                                  title: 'good'.tr,
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          InkWell(
                            onTap: () {
                              _controller.getFeedbackData(1, productName);
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  Images.great,
                                  height: 40,
                                  width: 40,
                                ),
                                CustomLabel(
                                  title: 'great'.tr,
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]));
        });
  }
}

class FeedbackSuccessViewAfterFeedback extends StatelessWidget {
  FeedbackSuccessViewAfterFeedback({Key key}) : super(key: key);
  final InnerFeedbackXController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return _controller.currentFeedbackValue == 1
        ? Center(
            child: Column(
              children: [
                CustomLabel(
                  title: 'thanksYou'.tr,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                Center(
                  child: CustomButton(
                    title:'referFriend'.tr,
                    isActive: true,
                    width: MediaQuery.of(context).size.width / 2 + 50,
                    fontSize: 12,
                    paddingWidth: 10,
                    height: 40,
                    buttonAction: () {
                      Get.toNamed(AppRoutes.REFER_A_FRIEND);
                    },
                  ),
                )
              ],
            ),
          )
        : Center(
            child: CustomLabel(
              title: 'thanksForFeedback'.tr,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          );
  }
}
