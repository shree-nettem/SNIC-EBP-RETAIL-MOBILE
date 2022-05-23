import 'dart:io';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_expandabletile.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/screen/vehicle_details.dart';
import 'package:ebpv2/src/views/ui/motor/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';
import 'controller/upload_document_controller.dart';
import 'motor_plan/screen/motor_plan.dart';

class MotorInsuranceScreen extends StatelessWidget {
  final MotorXController controller = Get.put(MotorXController());

  final MotorPalnXController planController = Get.put(MotorPalnXController());
  final UploadDocumentController _documentController =
      Get.put(UploadDocumentController());

  final VehicleDetailsXController vehicleDetailsXController =
      Get.put(VehicleDetailsXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: ConditionalWillPopScope(
        shouldAddCallback: Platform.isAndroid ? true : false,
        onWillPop: () async {
          planController.onBackPressed();
          return false;
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              CustomSilverBar(
                title: 'motorInsurance'.tr,
                isBackButtonExist: true,
                isActionButtonExist: true,
                info: "medical_innsurance_help_text".tr,
                onBackClick: planController.onBackPressed,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  color: Colors.white,
                  child: GetBuilder(
                    init: controller,
                    builder: (_) {
                      return _motorInsuranceUI(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _motorInsuranceUI(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        SvgPicture.asset(
          Images.car,
        ),
        Container(
            margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
            height: 1,
            color: MyColors.PrimaryColor),
        CustomExpandableTile(
          expansionCardKey: controller.expansionCardKey[0],
          classview: VehicleDetailsFormView(),
          title: '1'.tr,
          isTileDisable:
              controller.draftProgressStatus[0].status == 0 ? true : false,
          name: 'vehicleDetails'.tr,
          isButtonVisible: controller.draftProgressStatus[0].isExpanded ||
                  controller.draftProgressStatus[0].status == 2 ||
                  controller.draftProgressStatus[0].status == 0
              ? false
              : true,
          status:
              controller.draftProgressStatus[0].status == 2 ? "Completed" : '',
          buttonText: 'start'.tr,
          isStatusVisible:
              controller.draftProgressStatus[0].status == 2 ? true : false,
          onButtonClick: () {
            controller.onStartButtonClicked(position: 0);
          },
          onExpansionChanged: (val) {
            controller.onStartButtonClicked(position: 0, isExpanded: val);
          },
        ),
        IgnorePointer(
          ignoring:
              controller.draftProgressStatus[1].status == 0 ? true : false,
          child: CustomExpandableTile(
            expansionCardKey: controller.expansionCardKey[1],
            classview: MotorPalnScreen(),
            title: '2'.tr,
            isTileDisable: false,
            name: 'selectPlan'.tr,
            isButtonVisible: controller.draftProgressStatus[1].isExpanded ||
                    controller.draftProgressStatus[1].status == 2 ||
                    controller.draftProgressStatus[1].status == 0
                ? false
                : true,
            status: controller.draftProgressStatus[1].status == 2
                ? "Completed"
                : '',
            buttonText: 'start'.tr,
            isStatusVisible:
                controller.draftProgressStatus[1].status == 2 ? true : false,
            onButtonClick: () {
              controller.onStartButtonClicked(position: 1);
            },
            onExpansionChanged: (val) {
              controller.onStartButtonClicked(position: 1, isExpanded: val);
            },
          ),
        ),
        Obx(() => IgnorePointer(
              ignoring:
                  controller.draftProgressStatus[2].status == 0 ? true : false,
              child: CustomExpandableTile(
                expansionCardKey: controller.expansionCardKey[2],
                isTileDisable: false,
                classview: PaymentScreen(
                  planController.quote != null
                      ? planController.quote.value.actualPolicyName != null
                          ? planController.quote.value
                          : vehicleDetailsXController.draftFormat != null
                              ? vehicleDetailsXController
                                  .draftFormat.result.quote
                              : null
                      : vehicleDetailsXController.draftFormat != null
                          ? vehicleDetailsXController.draftFormat.result.quote
                          : null,
                  'motorInsurance'.tr,
                ),
                title: '3'.tr,
                isButtonVisible: controller.draftProgressStatus[2].isExpanded ||
                        controller.draftProgressStatus[2].status == 2 ||
                        controller.draftProgressStatus[2].status == 0
                    ? false
                    : true,
                status: controller.draftProgressStatus[2].status == 2
                    ? "Completed"
                    : '',
                buttonText: 'start'.tr,
                isStatusVisible: controller.draftProgressStatus[2].status == 2
                    ? true
                    : false,
                name: 'payment'.tr,
                onButtonClick: () {
                  controller.onStartButtonClicked(position: 2);
                },
                onExpansionChanged: (val) {
                  controller.onStartButtonClicked(position: 2, isExpanded: val);
                },
              ),
            ))
      ]),
    );
  }
}
