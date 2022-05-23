import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CommonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 48.0,
        right: 48,
      ),
      child: Column(
        children: [
          Spacer(),
          Column(
            children: [
              CustomLabel(
                title: 'year_snic_insurance'.tr,
                fontSize: 10,
                color: Color.fromRGBO(209, 215, 219, 1),
              ),
              SizedBox(
                height: 18,
              ),
              CustomLabel(
                title:
                    'licensed_by_cbb'.tr,
                fontSize: 10,
                color: Color.fromRGBO(209, 215, 219, 1),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
