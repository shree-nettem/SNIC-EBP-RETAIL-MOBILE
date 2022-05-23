import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_horizontal_slider.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/medical_ecard/medical_tabbar_view_controller.dart';
import 'package:ebpv2/src/views/ui/medical_group/widgets/medical_group_custom_dropdown.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MedicalTabbarView extends StatelessWidget {
  MedicalTabbarView({Key key}) : super(key: key);

  final MedicalTabbarViewXController _controller =
      Get.put(MedicalTabbarViewXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (cntrlr) {
          return VisibilityDetector(
              key: Key('medical_ecards-widget-key'),
              onVisibilityChanged: (VisibilityInfo info) {
                _controller.isCardFrontSide = true;
                if (_controller.totalEcards.length == 0) _controller.getToken();
              },
              child: Container(
                child: ListView(
                  children: [
                    if (_controller.totalCompanies.length > 1)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        child: MedicalGroupCustomDropDown(
                          options: _controller.totalCompaniesForDropdown,
                          label: _controller.selectedCompany,
                          onChanged: (val) {
                            _controller.selectedTokenFromDropDown(val);
                          },
                        ),
                      ),
                    if (_controller.totalCompanies.length > 1)
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                    if (_controller.totalEcards.length > 0)
                      horizantalCardView(),
                    if (_controller.totalEcards.length > 0)
                      Center(
                        child: HorizontalCustomalSider(
                          onNextPageTap: () {
                            _controller.scrollToNextPage();
                          },
                          onPreviousPageTap: () {
                            _controller.scrollToPreviousPage();
                          },
                          pageNo: _controller.pageNo,
                          maxCount: _controller.totalEcards.length,
                        ),
                      ),
                    Obx(() => _controller.isMedicalCardsLoading.value
                        ? Container(
                            height: 100,
                            width: Get.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : _controller.totalEcards.length == 0
                            ? Center(
                                child: CustomLabel(
                                title: 'currentlyNoCardsAvailable'.tr,
                                color: MyColors.PrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ))
                            : Container()),
                    if (_controller.totalEcards.length > 0)
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                    if (_controller.totalEcards.length > 0)
                      _buildActionButton(context, "share".tr,
                          svgImage: Images.share_white, onClick: () {
                        _controller.sharingData();
                      }),
                    if (_controller.totalEcards.length > 0)
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                    if (_controller.totalEcards.length > 0)
                      _buildActionButton(context, "download".tr,
                          svgImage: Images.download_white, onClick: () {
                        _controller.downloadImage();
                      }),
                    if (_controller.totalEcards.length > 0)
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 7),
                  ],
                ),
              ));
        });
  }

  Widget horizantalCardView() {
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
          itemCount: _controller.totalEcards.length,
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: EcardMedicalFlipView(
                  currentIndex: index,
                  controller: _controller,
                ),
              ),
            );
          }),
    );
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
}

class EcardMedicalFlipView extends StatelessWidget {
  EcardMedicalFlipView({Key key, this.currentIndex, this.controller})
      : super(key: key);
  final MedicalTabbarViewXController controller;
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
          // gradient: LinearGradient(
          //   colors: [Color(0xffcfd7db), Color(0xffffffff)],
          //   stops: [0, 1],
          //   begin: Alignment(0.42, 0.91),
          //   end: Alignment(-0.42, -0.91),
          // ),
          // boxShadow: [
          //   BoxShadow(
          //       color: Color(0x336f8693),
          //       offset: Offset(0, 5),
          //       blurRadius: 12,
          //       spreadRadius: 0)
          // ],
        ),
        child: VisibilityDetector(
          key: Key('medical-ecard-$currentIndex'),
          onVisibilityChanged: (VisibilityInfo info) {
            controller.pageNo = currentIndex;
            // controller.isCardFrontSide = true;
            // controller.update();
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
                  child: Obx(() => FlipCard(
                        fill: Fill
                            .fillBack, // Fill the back side of the card to make in the same size as the front.
                        direction: FlipDirection.HORIZONTAL,
                        key: cardKey,
                        flipOnTouch: true,
                        onFlipDone: (status) {},
                        front: CachedNetworkImage(
                          imageUrl:
                              "http://20.203.8.34/Medical/CardImage?id=${controller.totalEcards[currentIndex].identityId}&lifecode=${controller.totalEcards[currentIndex].lifeCode}&principalLifeCode=${controller.totalEcards[currentIndex].principal}&customerId=${controller.userID}&companyId=${controller.companyID}",
                          fit: BoxFit.fitWidth,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        back: controller.backUrlLoaded.value
                            ? CachedNetworkImage(
                                imageUrl: controller.backSideUrl,
                                fit: BoxFit.fitWidth,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      )),
                ),
                InkWell(
                  onTap: () {
                    controller.toggleCards(currentIndex: currentIndex);
                    cardKey.currentState.toggleCard();
                    // controller.toggleCards();
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
