import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import 'custom_label.dart';

class CustomSilverBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final bool isActionButtonExist;
  final Function onBackClick;
  final String info;

  CustomSilverBar(
      {@required this.title,
      this.onBackClick,
      this.isBackButtonExist = true,
      this.isActionButtonExist = false,
      this.info = ""});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backwardsCompatibility: false,
      automaticallyImplyLeading: false,
      primary: true,
      pinned: false,
      snap: false,
      expandedHeight: 140,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF000252),
                const Color(0xFF40a2be),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(Dimensions.RADIUS_VERY_EXTRA_LARGE),
                    topRight:
                        Radius.circular(Dimensions.RADIUS_VERY_EXTRA_LARGE),
                  ),
                  gradient: LinearGradient(
                      colors: [
                        const Color(0xFF000252),
                        const Color(0xFF40a2be),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: FlexibleSpaceBar(
                  stretchModes: <StretchMode>[
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  centerTitle: true,
                  titlePadding: const EdgeInsets.fromLTRB(
                      Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      Dimensions.PADDING_SIZE_DEFAULT),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: onBackClick == null
                            ? () {
                                Get.back();
                              }
                            : onBackClick,
                        child: isBackButtonExist
                            ? Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: Dimensions.PADDING_SIZE_DEFAULT,
                              )
                            : SizedBox.shrink(),
                      ),
                      CustomLabel(
                        title: title,
                        color: Colors.white,
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                      ),
                      Visibility(
                        visible: isActionButtonExist,
                        child: InkWell(
                          onTap: () {
                            if (info.isNotEmpty) {
                              CustomDialogHelper.showAlertDialog(
                                  title: "help".tr,
                                  description: info,
                                  okBtnFunction: () {
                                    Get.back();
                                  });
                            }
                          },
                          child: Icon(
                            Icons.help,
                            color: Colors.white,
                            size: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.RADIUS_VERY_EXTRA_LARGE),
                  topRight: Radius.circular(Dimensions.RADIUS_VERY_EXTRA_LARGE),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
