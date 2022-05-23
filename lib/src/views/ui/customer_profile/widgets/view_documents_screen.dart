import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/customer_profile/view_documents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ViewDocumentsScreen extends StatelessWidget {
  ViewDocumentsScreen({Key key}) : super(key: key);

  final ViewDocumentXController controller = Get.put(ViewDocumentXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: "cpr".tr,
            isBackButtonExist: true,
            isActionButtonExist: false,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _viewDocumentBody(),
          )
        ],
      ),
    );
  }

  Widget _viewDocumentBody() {
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PdfCardView(
                            textInBG: "Front",
                            filePath: "${controller.filePath1}",
                          ),
                          PdfCardView(
                            textInBG: "Back",
                            filePath: "${controller.filePath2}",
                          )
                          // OpenFile.open(controller.passport),
                        ],
                      ),
                    )),
                ShareViewCPR(
                  controller: controller,
                )
              ],
            ),
          );
        });
  }
}

class ShareViewCPR extends StatelessWidget {
  final ViewDocumentXController controller;
  const ShareViewCPR({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.2,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
            topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              controller.downloadImage();
            },
            child: Container(
              height: Get.height * 0.125,
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                color: MyColors.PrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.RADIUS_LARGE),
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Images.download_white),
                  CustomSpacer(
                    value: Dimensions.PADDING_SIZE_SMALL,
                    isHeight: true,
                  ),
                  CustomLabel(
                    title: 'download'.tr,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.sharingData();
            },
            child: Container(
              alignment: Alignment.center,
              height: Get.height * 0.125,
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                color: MyColors.PrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.RADIUS_LARGE),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Images.share_white),
                  CustomSpacer(
                    value: Dimensions.PADDING_SIZE_SMALL,
                    isHeight: true,
                  ),
                  CustomLabel(
                    title: 'share'.tr,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PdfCardView extends StatelessWidget {
  final String textInBG;
  final String filePath;
  PdfCardView({Key key, this.textInBG, this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return filePath != ""
        ? Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            height: Get.height * 0.3 - 19,
            width: Get.width,
            child: Container(
              child: Center(
                  child: CachedNetworkImage(
                imageUrl: "http://20.203.8.34/Files/Documents/" + filePath,
                fit: BoxFit.fitWidth,
                errorWidget: (context, value, data) => Container(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    height: Get.height * 0.4 - 19,
                    width: Get.width,
                    child: Center(
                      child: CustomLabel(
                        title: textInBG,
                        color: MyColors.GrayColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )),
            ))
        : Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            height: Get.height * 0.4 - 19,
            width: Get.width,
            child: Center(
              child: CustomLabel(
                title: textInBG,
                color: MyColors.GrayColor,
                fontWeight: FontWeight.w600,
                fontSize: 50,
              ),
            ),
          );
  }
}
