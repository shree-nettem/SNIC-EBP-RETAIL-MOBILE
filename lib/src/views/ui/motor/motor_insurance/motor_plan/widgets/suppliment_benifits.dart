import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_check_box.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SupplimentBenefits extends StatelessWidget {
  MotorPalnXController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(
            // alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 5, bottom: 10),
            child: CustomLabel(
              title: 'addSupplimentBenifits'.tr,
              fontFamily: Constants.FONT_PROXIMA_NOVA,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              maxLines: 1,
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.premium.data[controller.selectedIndex.value]
                  .optionalCovers.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                    child: supplementBenefits(index: index, context: context),
                  ),
                );
              }),
        ]));
  }

  supplementBenefits({int index, BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => Flexible(
              child: CustomCheckBox(
                text: controller.premium.data[controller.selectedIndex.value]
                    .optionalCovers[index].label,
                value: controller != null
                    ? controller.premium.data[controller.selectedIndex.value]
                        .optionalCovers[index].isSelected.value
                    : false,
                onTap: () {
                  controller != null
                      ? controller.switchSupplimentBenifits(index)
                      : null;
                },
              ),
            )),
        SizedBox(
          width: 10,
        ),
        CustomLabel(
          textAlign: TextAlign.end,
          title:
              "BHD ${controller.premium.data[controller.selectedIndex.value].optionalCovers[index].price}",
          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          maxLines: 1,
        ),
      ],
    );
  }
}
