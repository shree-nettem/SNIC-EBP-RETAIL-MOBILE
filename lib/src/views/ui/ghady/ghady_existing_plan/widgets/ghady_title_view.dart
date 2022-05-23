import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class GhadyTitleView extends StatelessWidget {
  final String icon;
  final String title;
  final String status;

  const GhadyTitleView(this.icon, this.title, this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icon,
                      width: 17,
                      height: 17,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: CustomLabel(
                        title: title,
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                title: status,
                width: null,
                fontSize: 12,
                height: 26,
                bgColor: MyColors.successGreen,
                buttonAction: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
