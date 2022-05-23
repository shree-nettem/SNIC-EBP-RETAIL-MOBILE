import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_back_next_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_text_button.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/motor_claim_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/select_vehicle_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/windshiled_claim_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/widgets/police_report_flow.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/widgets/windscreem_claim_flow.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/widgets/policy_benifits.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClaimDetails extends StatelessWidget {
  MotorClaimXController claimController = Get.find();
  MotorClaimDetailsXController _controller = Get.find();
  SelectVehicleXController detailsXController = Get.find();
  WindScreenClaimFlowXController windScreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //will be enabled once api has the policy data
              /* Container(
            margin: EdgeInsets.only(bottom: 20.0),
            padding: EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0, top: 5.0),
                  child: CustomLabel(
                    title: "Policy Details",
                    fontFamily: Constants.FONT_PROXIMA_NOVA,
                    fontSize: 18,
                  ),
                ),
                ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: PolicyBenifits(index: index),
                      );
                    }),
              ],
            ),
          ),*/
              Visibility(
                  visible:
                      claimController.isPoliceReportSelected ? true : false,
                  child: PoliceReportContentView()),
              Visibility(
                  visible:
                      claimController.isCarWindScreenSelected ? true : false,
                  child: WindScreenCalimFlow()),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      try {
                        detailsXController.expansionCardKey[1].currentState
                            .collapse();
                      } catch (e) {}

                      // Get.back();
                    },
                    child: CustomBackNextutton(
                      isBackButton: true,
                    ),
                  ),
                  Visibility(
                    visible: claimController.isCarWindScreenSelected &&
                            windScreenController.otherPartInvolved[0]
                        ? false
                        : true,
                    child: InkWell(
                      onTap: () {
                        if (claimController.isPoliceReportSelected) {
                          if (_controller.formKey.currentState.validate()) {
                            if (detailsXController.isAnActivePlanSelected) {
                              detailsXController.isClaimDetailSubmitted = true;
                              detailsXController.isUploadDocumentVisible = true;
                              detailsXController
                                  .expansionCardKey[1].currentState
                                  .collapse();
                              detailsXController
                                  .expansionCardKey[2].currentState
                                  .expand();
                              claimController.update();
                              // _controller.submitClaim("Motor claim with police report");
                            }
                          }
                        } else if (claimController.isCarWindScreenSelected) {
                          if (windScreenController.formKey.currentState
                              .validate()) {
                            detailsXController.isClaimDetailSubmitted = true;
                            detailsXController.isUploadDocumentVisible = true;

                            detailsXController.expansionCardKey[1].currentState
                                .collapse();
                            detailsXController.expansionCardKey[2].currentState
                                .expand();
                            claimController.update();
                            // windScreenController.submitClaim("Car Windscreen claim");
                          }
                        }
                      },
                      child: CustomBackNextutton(
                        isBackButton: false,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          );
        });
  }
}
