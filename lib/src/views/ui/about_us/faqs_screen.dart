import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/about_us/faq_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:html2md/html2md.dart' as html2md;

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(title: 'faq'.tr),
          SliverFillRemaining(
            hasScrollBody: false,
            child: FaqView(),
          ),
        ],
      ),
    );
  }
}

class FaqView extends StatelessWidget {
  final FAQController faqController = Get.put(FAQController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: faqController,
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
          child: Column(
            children: [
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
                  child: Column(
                      children: List.from(
                    faqController.faqModel.map(
                      (item) => Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
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
                                  child: Padding(
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
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    html2md.convert(item.discription),
                                    style: TextStyle(
                                      color: MyColors.PrimaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
