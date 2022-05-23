import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/home/model/pending_payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'home_controller.dart';

class PendingPaymentView extends StatelessWidget {
  final HomeXController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          CustomSilverBar(
            title: "pendingPayments".tr,
            isBackButtonExist: true,
            isActionButtonExist: true,
            onBackClick: () {
              Get.back();
            },
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: GetBuilder(
                init: controller,
                builder: (_) {
                  return VisibilityDetector(
                      key: Key('payment-widget-key'),
                      onVisibilityChanged: (VisibilityInfo info) {
                        controller.getAllPaymentList();
                      },
                      child: _pendingPaymentList(context));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pendingPaymentList(BuildContext context) {
    return controller.isLoading
        ? Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          )
        : controller.pendingPaymentList.length > 0
            ? Container(
                color: Colors.white,
                margin: EdgeInsets.all(20.0),
                child: Column(
                    children: List.from(controller.pendingPaymentList.map(
                        (item) => Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: InkWell(
                              onTap: () {},
                              child: pendingPayment(item),
                            ))))))
            : Container(
                child: Center(
                  child: CustomLabel(
                    title: 'noRecordFound'.tr,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              );
  }

  pendingPayment(PendingPayment item) {
    return Container(
      margin: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_LARGE,
          bottom: Dimensions.PADDING_SIZE_LARGE),
      child: Card(
        color: MyColors.PrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              Dimensions.RADIUS_LARGE), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
            top: Dimensions.PADDING_SIZE_DEFAULT,
            bottom: Dimensions.PADDING_SIZE_SMALL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: Dimensions.RADIUS_EXTRA_LARGE,
                  ),
                  addHorizontalWidth(8.0),
                  CustomLabel(
                    title: item.type,
                    color: Colors.white,
                  ),
                ],
              ),
              addVerticalHeight(6.0),
              Padding(
                padding: const EdgeInsets.only(left: 27.5, right: 27.5),
                child: CustomLabel(
                  title: item.description,
                  color: Colors.white,
                ),
              ),
              addVerticalHeight(6.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: CustomLabel(
                      title: "BHD ${controller.payment.amount}",
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.makePayment(item);
                    },
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_LARGE),
                          side: BorderSide(
                            color: Colors.white70.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_DEFAULT,
                              right: Dimensions.PADDING_SIZE_DEFAULT,
                              top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: CustomLabel(
                            title: "pay".tr,
                            color: MyColors.PrimaryColor,
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
