import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/group_life/benefits/benifits_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TableOfBenefitsScreen extends StatelessWidget {
  final BenifitsXController _benifitsController =
      Get.put(BenifitsXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _benifitsController,
        builder: (cntrlr) {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_VERY_EXTRA_LARGE,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT),
              children: [
                CustomLabel(
                  title: _benifitsController.title.tr,
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
                        _benifitsController.totalGroupLifeSections.map(
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
                                    width: Dimensions.PADDING_SIZE_SMALL,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: _benifitsController
                                                .selectImage(item.title) !=
                                            "NoImage"
                                        ? SvgPicture.asset(
                                            _benifitsController
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
                                      title: item.title.tr,
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
                                      const EdgeInsets.fromLTRB(58, 0, 25, 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomLabel(
                                      title: item.value.tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      maxLines: 100,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                    )),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                CustomLabel(
                  title: "additionalBenefits".tr,
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
                        _benifitsController.totatAdditionalLifeSections.map(
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
                                    child:
                                        // _benifitsController
                                        //             .selectImage(item.title) !=
                                        //         "NoImage"
                                        //     ?
                                        //     SvgPicture.asset(
                                        //   _benifitsController
                                        //       .selectImage(item.title),
                                        //   height: 20,
                                        //   width: 20,
                                        // )
                                        // :
                                        Padding(
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
                                      title: item.title.tr,
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
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomLabel(
                                      title: item.value.tr,
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      maxLines: 100,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                    )),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
              ],
            ),
          );
        });
  }
}
