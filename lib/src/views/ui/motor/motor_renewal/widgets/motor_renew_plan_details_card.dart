import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_rich_text.dart';
import 'package:ebpv2/src/views/ui/motor/model/calculating_premium_renewal_flow.dart';
import 'package:ebpv2/src/views/ui/motor/model/motor_switch_plan.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/policy_benifits.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/controller/motor_renewal_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/controller/renew_switch_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MotorRenewPlanDetailsCardView extends StatelessWidget {
  //MotorPalnXController controller = Get.find();


  MotorRenewalXController renewalXController=Get.find();
  final RenewSwitchController controller = Get.find();

  final int index;
  final CalculatingPremium data;
  final   SwitchPlan switchPlan;


  MotorRenewPlanDetailsCardView({this.index,this.data,this.switchPlan});


  @override
  Widget build(BuildContext context) {
    return Container(

      child: InkWell(
        onTap: () {
          controller.setSelectedPlan(index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          padding: EdgeInsets.all(5.0),
          decoration: new BoxDecoration(
            border: Border.all(
              color: controller.selectedIndex.value == index
                  ? MyColors.VerticalDividerColor
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Color(0xffcfd7db), Color(0xffffffff)],
              stops: [0, 1],
              begin: Alignment(0.42, 0.91),
              end: Alignment(-0.42, -0.91),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color(0x336f8693),
                  offset: Offset(0, 5),
                  blurRadius: 12,
                  spreadRadius: 0)
            ],
          ),
          child: AutoScrollTag(
            key: ValueKey(index),
            controller: controller.scrollController,
            index: index,
            child: Container(
              padding: controller.isRecommendedVisible
                  ? const EdgeInsets.only(left: 10, right: 10, top: 35.0)
                  : const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomLabel(
                        title:
                            data!=null?
                            data.actualPolicyName.toUpperCase():switchPlan!=null?
                            switchPlan.result[index].actualPolicyName.toUpperCase():"",
                        fontFamily: Constants.FONT_PROXIMA_NOVA,
                        fontSize: 18,
                      ),
                      Spacer(),
                      CustomRichText(
                          spanText1: "BHD ",
                          spanText2:  data!=null?
                          data.strBasicPremium.toUpperCase():switchPlan!=null?
                          switchPlan.result[index].strBasicPremium:""),
                    ],
                  ),
                  ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                      data!=null?
                      data.planCovers.length:switchPlan!=null?
                      switchPlan.result[index].planCovers.length:0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomLabel(
                                title: data!=null? data.planCovers[index].label
                                :switchPlan!=null?
                                switchPlan.result[this.index].planCovers[index].label:"",
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                fontSize: 12,
                                maxLines: 2,
                              ),
                              data!=null? data.planCovers[index].value == "Covered"
                                  ||  data.planCovers[index].value == "Not Covered"
                                  ? SvgPicture.asset(
                                data.planCovers[index].value == "Covered" ?
                                Images.tick : Images.cancel,
                                width: 12,
                                height: 12,
                              )
                                  : Flexible(
                                child: CustomLabel(
                                  title: data!=null? data.planCovers[index].value:"",
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                  fontSize: 12,
                                  maxLines: 2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ): switchPlan!=null? switchPlan.result[this.index].planCovers[index].value == "Covered"
                                  ||  switchPlan.result[this.index].planCovers[index].value == "Not Covered"
                                  ? SvgPicture.asset(
                                switchPlan.result[this.index].planCovers[index].value == "Covered" ?
                                Images.tick : Images.cancel,
                                width: 12,
                                height: 12,
                              )
                                  : Flexible(
                                child: CustomLabel(
                                  title:  switchPlan.result[this.index].planCovers[index].value,
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                  fontSize: 12,
                                  maxLines: 2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ):Container()
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
