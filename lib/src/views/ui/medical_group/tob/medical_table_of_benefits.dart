import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_bottom_call_options.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/medical_group/tob/medical_table_of_benefits_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MedicalTableOfBenefits extends StatelessWidget {
  MedicalTableOfBenefits({Key key}) : super(key: key);

  MedicalTabbleOfBenefitsXController _controller =
      Get.put(MedicalTabbleOfBenefitsXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalTabbleOfBenefitsXController>(
        init: MedicalTabbleOfBenefitsXController(),
        builder: (_controller) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT * 2),
            child: ListView(
              children: [
                // CustomLabel(
                //   title: "Search",
                //   color: MyColors.PrimaryColor,
                //   fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                //   fontWeight: FontWeight.w400,
                //   fontSize: 13,
                // ),
                // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT / 2),
                // Row(
                //   children: [
                //     MedicalGroupCustomSearchBar(
                //       onChanged: (val) {},
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Container(
                //       width: 50,
                //       height: 50,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: MyColors.PrimaryColor,
                //       ),
                //       child: Center(
                //         child: SvgPicture.asset(
                //           Images.filter,
                //           width: 12.5,
                //           height: 12.5,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                CustomLabel(
                  title:
                      "${"tableOfBenefits".tr} : ${_controller.titleTOB ?? ""}",
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  maxLines: 2,
                ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                CustomLabel(
                  title: "summary".tr,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  maxLines: 2,
                ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                    ),
                    elevation: 2,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Column(
                            children: List.from(
                          _controller.headerTOBSections.map(
                            (item) => Theme(
                              data: ThemeData()
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                trailing: GetBuilder<LocalizationController>(
                                    builder: (localizationController) {
                                  return RotatedBox(
                                    quarterTurns: localizationController
                                                .locale.languageCode ==
                                            'en'
                                        ? 0
                                        : 2,
                                    child: SvgPicture.asset(
                                      Images.expand_icon,
                                      height: 10,
                                      width: 10,
                                    ),
                                  );
                                }),
                                title: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: _controller
                                                  .selectImage(item.ref) !=
                                              "NoImage"
                                          ? SvgPicture.asset(
                                              _controller.selectImage(item.ref),
                                              height: 20,
                                              width: 20,
                                            )
                                          : Padding(
                                              padding: EdgeInsets.all(5),
                                              child: ClipOval(
                                                child: Container(
                                                  height: 10,
                                                  width: 10,
                                                  color: MyColors.PrimaryColor,
                                                ),
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                                    Flexible(
                                      child: CustomLabel(
                                        title: item.title,
                                        color: MyColors.PrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 0, 25, 5),
                                    child: GetBuilder<LocalizationController>(
                                        builder: (localizationController) =>
                                            Align(
                                              alignment: localizationController
                                                          .locale
                                                          .languageCode ==
                                                      "en"
                                                  ? Alignment.centerLeft
                                                  : Alignment.centerRight,
                                              child: CustomLabel(
                                                title: item.value,
                                                color: MyColors.PrimaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                maxLines: 100,
                                              ),
                                            )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                      ),
                    )),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                CustomLabel(
                  title: "allBenefits".tr,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  maxLines: 2,
                ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                    ),
                    elevation: 2,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                          children: List.from(
                        _controller.totalTOBSections.map(
                          (item) => Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                                trailing: GetBuilder<LocalizationController>(
                                    builder: (localizationController) {
                                  return RotatedBox(
                                    quarterTurns: localizationController
                                                .locale.languageCode ==
                                            'en'
                                        ? 0
                                        : 2,
                                    child: SvgPicture.asset(
                                      Images.expand_icon,
                                      height: 10,
                                      width: 10,
                                    ),
                                  );
                                }),
                                title: Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: _controller.selectImage(
                                                      item.title) !=
                                                  "NoImage"
                                              ? SvgPicture.asset(
                                                  _controller
                                                      .selectImage(item.title),
                                                  height: 20,
                                                  width: 20,
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: ClipOval(
                                                    child: Container(
                                                      height: 10,
                                                      width: 10,
                                                      color:
                                                          MyColors.PrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        SizedBox(
                                          width:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        ),
                                        Flexible(
                                          child: CustomLabel(
                                            title: item.title,
                                            color: MyColors.PrimaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          35, 0, 10, 5),
                                      child: GetBuilder<LocalizationController>(
                                          builder: (localizationController) =>
                                              Align(
                                                alignment:
                                                    localizationController
                                                                .locale
                                                                .languageCode ==
                                                            "en"
                                                        ? Alignment.centerLeft
                                                        : Alignment.centerRight,
                                                child: CustomLabel(
                                                  title:
                                                      item.subSections[0].value,
                                                  color: MyColors.PrimaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  maxLines: 100,
                                                ),
                                              )),
                                    ),
                                  ],
                                ),
                                children: List.from(item.subSections.map((e) =>
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 0, 25, 5),
                                      child: Column(
                                        children: [
                                          if (!e.ref.contains("00"))
                                            GetBuilder<LocalizationController>(
                                                builder:
                                                    (localizationController) =>
                                                        Align(
                                                          alignment: localizationController
                                                                      .locale
                                                                      .languageCode ==
                                                                  "en"
                                                              ? Alignment
                                                                  .centerLeft
                                                              : Alignment
                                                                  .centerRight,
                                                          child: CustomLabel(
                                                            title: e.title,
                                                            color: MyColors
                                                                .PrimaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            maxLines: 2,
                                                          ),
                                                        )),
                                          if (!e.ref.contains("00"))
                                            GetBuilder<LocalizationController>(
                                                builder:
                                                    (localizationController) =>
                                                        Align(
                                                          alignment: localizationController
                                                                      .locale
                                                                      .languageCode ==
                                                                  "en"
                                                              ? Alignment
                                                                  .centerLeft
                                                              : Alignment
                                                                  .centerRight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5.0),
                                                            child: CustomLabel(
                                                              title: e.value,
                                                              color: MyColors
                                                                  .PrimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                              maxLines: 100,
                                                            ),
                                                          ),
                                                        )),
                                          if (!e.ref.contains("00"))
                                            SizedBox(
                                              height: 16,
                                            )
                                        ],
                                      ),
                                    )))),
                          ),
                        ),
                      )),
                    )),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                CustomLabel(
                  title: "benefitsCoverage".tr,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  maxLines: 2,
                ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                    ),
                    elevation: 2,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Column(
                          children: List.from(
                        _controller.bottomTOBSections.map(
                          (item) => Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              trailing: GetBuilder<LocalizationController>(
                                  builder: (localizationController) {
                                return RotatedBox(
                                  quarterTurns: localizationController
                                              .locale.languageCode ==
                                          'en'
                                      ? 0
                                      : 2,
                                  child: SvgPicture.asset(
                                    Images.expand_icon,
                                    height: 10,
                                    width: 10,
                                  ),
                                );
                              }),
                              title: Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: _controller
                                                .selectImage(item.title) !=
                                            "NoImage"
                                        ? SvgPicture.asset(
                                            _controller.selectImage(item.title),
                                            height: 20,
                                            width: 20,
                                          )
                                        : Padding(
                                            padding: EdgeInsets.all(5),
                                            child: ClipOval(
                                              child: Container(
                                                height: 10,
                                                width: 10,
                                                color: MyColors.PrimaryColor,
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT,
                                  ),
                                  Flexible(
                                    child: CustomLabel(
                                      title: item.title,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 25, 5),
                                  child: GetBuilder<LocalizationController>(
                                      builder: (localizationController) =>
                                          Align(
                                            alignment: localizationController
                                                        .locale.languageCode ==
                                                    "en"
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                            child: CustomLabel(
                                              title: item.value,
                                              color: MyColors.PrimaryColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              maxLines: 100,
                                            ),
                                          )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                    )),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                _buildActionButton(context, "contactSupport".tr,
                    svgImage: Images.call, onclick: () {
                  showBottomcallOptions(_controller.contactSupport);
                }),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                _buildActionButton(context, "getTravelCertificate".tr,
                    svgImage: Images.download_white, onclick: () {
                  showTravelCertificateMembers(_controller);
                }),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
              ],
            ),
          );
        });
  }

  /* ADD NEW  BUTTON */
  Widget _buildActionButton(BuildContext context, String title,
      {String svgImage, Function onclick}) {
    return Center(
      child: Builder(builder: (context) {
        debugPrint("CODES ${_controller.lang}");
        return CustomButton(
            title: title,
            width: MediaQuery.of(context).size.width / 2 + 50,
            fontSize: 12,
            paddingWidth: 10,
            height: 40,
            svgImage: svgImage,
            buttonAction: onclick,
            languageCode: false);
      }),
    );
  }

  void showTravelCertificateMembers(
      MedicalTabbleOfBenefitsXController controller) {
    showModalBottomSheet(
      context: Get.context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: 300,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomLabel(
                    title: "${"selectMembers".tr} : ",
                    color: MyColors.PrimaryColor,
                    fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 175,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Scrollbar(
                      thickness: 5,
                      isAlwaysShown: true,
                      radius: Radius.circular(5),
                      child: ListView.builder(
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.checkedBoxData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(() {
                            return CheckboxListTile(
                              title: CustomLabel(
                                  title: controller
                                      .totalClaimants[index].insuredMemberName),
                              value: controller.checkedBoxData[index],
                              onChanged: (newValue) {
                                controller.updateCheckBox(newValue, index);
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: CustomButton(
                    title: "confirm".tr,
                    width: 110,
                    height: 26,
                    buttonAction: () {
                      Get.back();

                      // Get.toNamed()
                      // if (_controller.reimbbursementFrom != null &&
                      //     _controller.receipts != null) {
                      //   // _controller.submitClaim();
                      String endPoint = controller.getEndPointString();

                      if (endPoint.isNotEmpty) {
                        Get.toNamed(AppRoutes.VIEW_DOCUMENT_SHARE,
                            arguments: {"endPoint": endPoint});
                      }

                      // }
                    },
                  ),
                ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
              ],
            ),
          ),
        );
      },
    );
  }
}
