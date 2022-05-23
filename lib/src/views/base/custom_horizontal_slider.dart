import 'package:ebpv2/src/data/base_controller/localization_controller.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HorizontalCustomalSider extends StatelessWidget {
  final int pageNo, maxCount;
  final Function onPreviousPageTap, onNextPageTap;

  HorizontalCustomalSider(
      {this.pageNo, this.onPreviousPageTap, this.onNextPageTap, this.maxCount});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        height: 20,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onPreviousPageTap,
              child: SvgPicture.asset(
                localizationController.locale.languageCode == 'en'
                    ? pageNo == 0
                        ? Images.disabledbackbtn
                        : Images.backbtn
                    : pageNo == 0
                        ? Images.disabledfowardbtn
                        : Images.fowardbtn,
                width: 25,
                height: 25,
              ),
            ),
            Container(
              height: 10,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: maxCount,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(2.0),
                        height: 5.0,
                        width: 5.0,
                        decoration: new BoxDecoration(
                            color: index == pageNo
                                ? MyColors.PrimaryColor
                                : MyColors.GrayColor,
                            border: new Border.all(
                                width: 1.0,
                                color: index == pageNo
                                    ? MyColors.PrimaryColor
                                    : MyColors.GrayColor),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0))));
                  }),
            ),
            InkWell(
              onTap: onNextPageTap,
              child: SvgPicture.asset(
                localizationController.locale.languageCode == 'en'
                    ? pageNo == maxCount - 1
                        ? Images.disabledfowardbtn
                        : Images.fowardbtn
                    : pageNo == maxCount - 1
                        ? Images.disabledbackbtn
                        : Images.backbtn,
                width: 25,
                height: 25,
              ),
            ),
          ],
        ),
      );
    });
  }
}
