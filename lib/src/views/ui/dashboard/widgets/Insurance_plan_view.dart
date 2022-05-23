import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InsurancePlanView extends StatelessWidget {
  final String title, image;
  final VoidCallback onTapped;

  const InsurancePlanView({Key key, this.title, this.image, this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(
                right: Dimensions.PADDING_SIZE_SMALL,
                left: Dimensions.PADDING_SIZE_SMALL),
            child: SvgPicture.asset(
              image,
              width: 15,
              // height: 20,
            ),
          ),
          Expanded(
            child: CustomLabel(
              title: title,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
            ),
          ),
        ],
      ),
    );
  }
}
