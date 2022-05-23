import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/base/custom_text_field.dart';
import 'package:ebpv2/src/views/base/custom_toogle.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/basic_info_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/widgets/basic_info_form.dart';
import 'package:ebpv2/src/views/ui/customer_profile/widgets/financial_details_form.dart';
import 'package:ebpv2/src/views/ui/customer_profile/widgets/identification_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerBasicInformationScreen extends StatelessWidget {
  // final BasicInfoXController controller = Get.put(BasicInfoXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.MainColor,
        resizeToAvoidBottomInset: true,
        body: Container() // CustomScrollView(
        //   slivers: <Widget>[
        //     CustomSilverBar(title: "Account", isBackButtonExist: true),
        //     SliverFillRemaining(
        //       hasScrollBody: false,
        //       child: Container(
        //         margin: const EdgeInsets.only(left: 25.0, right: 25, top: 48),
        //         child: GetBuilder(
        //           init: controller,
        //           builder: (_) {
        //             return _customerBasicInformation(context);
        //           },
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }

  Widget _customerBasicInformation(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(18.0),
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabel(
              fontSize: 18,
              title: "Financial Details",
              fontFamily: Constants.FONT_PROXIMA_NOVA,
            ),
            SizedBox(
              height: 20,
            ),
            //  BasicInfoFormView(),
            //FinancialDetailsFormView(),
            IdentificationDetailsFormView()
          ],
        ),
      ),
    );
  }
}
