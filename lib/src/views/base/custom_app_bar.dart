import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/ui/home/widget/contact_support_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final bool isActionButtonExist;

  CustomAppBar(
      {@required this.title,
      this.isBackButtonExist = true,
      this.isActionButtonExist = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          Images.logo,
          width: 30,
          height: 30,
          fit: BoxFit.contain,
        ),
        onPressed: () {},
      ),
      actions: isActionButtonExist
          ? [
              IconButton(
                icon: SvgPicture.asset(
                  Images.head_phones,
                ),
                onPressed: () {
                  Get.bottomSheet(ContactSupportView());
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  Images.notification_bell,
                ),
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.NOTIFICATION,
                  );
                },
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
