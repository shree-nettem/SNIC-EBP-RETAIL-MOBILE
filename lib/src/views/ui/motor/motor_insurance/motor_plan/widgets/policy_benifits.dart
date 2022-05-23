import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/motor/model/calculate_premium.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/motor_paln_Controller.dart';

class PolicyBenifits extends StatelessWidget {
  //final MotorPalnXController controller = Get.find();
  // final MotorXController motorXController = Get.find();
  final int index;
  final List<EligibleUpgrade> list;

  PolicyBenifits({this.index, this.list});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomLabel(
          title: list[index].label,
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          fontSize: 12,
          maxLines: 2,
        ),
        list[index].value == "Covered" || list[index].value == "Not Covered"
            ? SvgPicture.asset(
                list[index].value == "Covered" ? Images.tick : Images.cancel,
                width: 12,
                height: 12,
              )
            : Flexible(
                child: CustomLabel(
                  title: list[index].value,
                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                  fontSize: 12,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ],
    );
  }
}
