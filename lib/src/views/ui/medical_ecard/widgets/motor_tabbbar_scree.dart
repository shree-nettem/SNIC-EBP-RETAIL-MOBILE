import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/base/custom_horizontal_slider.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/medical_ecard/motor_ecard_view_controller.dart';
import 'package:ebpv2/src/views/ui/medical_group/widgets/medical_group_custom_dropdown.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MotorTabbbarView extends StatelessWidget {
  MotorTabbbarView({Key key}) : super(key: key);

  final MotorEcardViewXController _controller =
      Get.put(MotorEcardViewXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (cntrlr) {
          return Container(
            child: ListView(
              children: [
                // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                //   child: MedicalGroupCustomDropDown(
                //     options: ["CustomersBenefits".tr],
                //     label: "CustomersBenefits".tr,
                //   ),
                // ),
                // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                // if (_controller.frontImages.length > 0)
                Obx(() {
                  return _controller.frontImages.length > 0
                      ? horizantalCardView(_controller)
                      : _controller.isDownloadingInitialMotorCards.value
                          ? Container(
                              height: Get.width / 2,
                              width: Get.width,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Container();
                }),
                if (_controller.frontImages.length > 0)
                  Obx(() {
                    return Center(
                      child: HorizontalCustomalSider(
                        onNextPageTap: () {
                          _controller.scrollToNextPage();
                        },
                        onPreviousPageTap: () {
                          _controller.scrollToPreviousPage();
                        },
                        pageNo: _controller.pageNo,
                        maxCount: _controller.frontImages.length,
                      ),
                    );
                  }),

                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                if (_controller.frontImages.length > 0)
                  _buildActionButton(context, "share".tr,
                      svgImage: Images.share_white, onClick: () {
                    _controller.sharingData();
                  }),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                if (_controller.frontImages.length > 0)
                  _buildActionButton(context, "download".tr,
                      svgImage: Images.download_white, onClick: () {
                    _controller.downloadImage();
                  }),
                if (_controller.frontImages.length == 0 &&
                    !_controller.isDownloadingInitialMotorCards.value)
                  Center(
                    child: CustomLabel(
                      title: 'currentlyNoCardsAvailable'.tr,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 7),
              ],
            ),
          );
        });
  }

  /* ADD NEW  BUTTON */
  Widget _buildActionButton(BuildContext context, String title,
      {String svgImage, Function onClick}) {
    return Center(
      child: CustomButton(
        title: title,
        width: MediaQuery.of(context).size.width / 2 + 50,
        fontSize: 12,
        paddingWidth: 10,
        height: 40,
        svgImage: svgImage,
        buttonAction: onClick,
      ),
    );
  }

  Widget horizantalCardView(MotorEcardViewXController controller) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(bottom: 5),
      height: Get.width * 0.65,
      width: Get.width,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          controller: _controller.scrollController,
          physics: PageScrollPhysics(),

          // physics: scroll,
          scrollDirection: Axis.horizontal,
          itemCount: _controller.frontImages.length,
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: EcardFlipView(
                  currentIndex: index,
                  controller: controller,
                ),
              ),
            );
          }),
    );
  }
}

class EcardFlipView extends StatelessWidget {
  EcardFlipView({Key key, this.currentIndex, this.controller})
      : super(key: key);
  final MotorEcardViewXController controller;
  final currentIndex;
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: Get.width - 20,
        padding: EdgeInsets.all(2.0),
        decoration: new BoxDecoration(
          border: Border.all(
            color: MyColors.VerticalDividerColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: VisibilityDetector(
          key: Key('motor-ecard-$currentIndex'),
          onVisibilityChanged: (VisibilityInfo info) {
            controller.pageNo = currentIndex;
            controller.isCardFrontSide = true;
            controller.update();
          },
          child: AutoScrollTag(
            key: ValueKey(currentIndex),
            controller: controller.scrollController,
            index: currentIndex,
            child: Stack(
              children: [
                Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(2),
                  // height: Get.width * 0.7,
                  width: Get.width - 20,
                  child: FlipCard(
                    fill: Fill
                        .fillBack, // Fill the back side of the card to make in the same size as the front.
                    direction: FlipDirection.HORIZONTAL,
                    key: cardKey,
                    flipOnTouch: true,
                    onFlipDone: (status) {
                      print(status);
                    },
                    front: Image(
                      image: MemoryImage(
                          controller.frontImages[currentIndex].bytes),
                    ),
                    back: Image(
                      image: MemoryImage(
                          controller.backImages[currentIndex].bytes),
                    ),
                    // front: PdfViewer.openAsset(Images.test_pdf_file),
                    //                   (

                    //     pageNumber: 1,
                    //     pageBuilder: (context, textureBuilder, pageSize) => textureBuilder(), doc: Images.test_pdf_file,
                    // ),
                    // front: SvgPicture.network(
                    //     "http://20.203.8.34/Motor/CardView?policyNumber=${controller.totalEcards[currentIndex].policyNumber}"),
                    // front: CachedNetworkImage(
                    //   imageUrl:
                    //       "http://20.203.8.34/Medical/CardImage?id=860106713&lifecode=555555&principalLifeCode=555555&customerId=176&companyId=9",
                    //   fit: BoxFit.fitWidth,
                    //   imageBuilder: (context, imageProvider) => Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       image: DecorationImage(
                    //         image: imageProvider,
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // back: controller.backUrlLoaded
                    //     ? CachedNetworkImage(
                    //         imageUrl: controller.backSideUrl,
                    //         fit: BoxFit.fitWidth,
                    //         imageBuilder: (context, imageProvider) => Container(
                    //           decoration: BoxDecoration(
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(10)),
                    //             image: DecorationImage(
                    //               image: imageProvider,
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : Container(),
                  ),
                ),
                InkWell(
                  onTap: () {
                    cardKey.currentState.toggleCard();
                    controller.toggleCards(currentIndex: currentIndex);
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      Images.flip_icon,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
