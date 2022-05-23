import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_expandabletile.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/controller/select_vehicle_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/widgets/minor_motor_claim.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/widgets/motor_claims.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/widgets/motor_claim_upload_documents.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/widgets/select_vehicle.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'controller/motor_claim_controller.dart';

class SubmitMotorClaimScreen extends StatelessWidget {
  final MotorClaimXController _controller = Get.find();

  SelectVehicleXController vehicleDetailsXController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return ListView(
            children: [
              CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
              Container(
                child: SvgPicture.asset(
                  Images.motor_claim,
                ),
              ),
              Visibility(
                visible: !_controller.isCarWindScreenSelected &&
                        !_controller.isMinorMotorClaimSelected &&
                        !_controller.isPoliceReportSelected
                    ? true
                    : false,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _controller.flowControl(1);
                      },
                      child: motorClaimCard(
                          Images.car_collision, 'motorClaimPoliceReport'.tr),
                    ),
                    InkWell(
                      onTap: () {
                        _controller.flowControl(2);
                      },
                      child: motorClaimCard(
                          Images.car_minor_crash, 'minorMotorClaim'.tr),
                    ),
                    InkWell(
                        onTap: () {
                          _controller.flowControl(3);
                        },
                        child: motorClaimCard(
                            Images.car_windscreen, 'carWindScreenClaim'.tr)),
                  ],
                ),
              ),
              Column(
                children: [
                  Visibility(
                    visible: _controller.isCarWindScreenSelected ||
                            _controller.isPoliceReportSelected ||
                            _controller.isMinorMotorClaimSelected
                        ? true
                        : false,
                    child: IgnorePointer(
                      ignoring: vehicleDetailsXController.isNextButtonClicked &&
                              vehicleDetailsXController.isAnActivePlanSelected
                          ? true
                          : false,
                      child: CustomExpandableTile(
                        expansionCardKey:
                            vehicleDetailsXController.expansionCardKey[0],
                        classview: SelectVehicle(
                          isFromWindScreen: _controller.isCarWindScreenSelected,
                        ),
                        title: '1',
                        name: 'selectVehicle'.tr,
                        isStatusVisible:
                            vehicleDetailsXController.isNextButtonClicked
                                ? true
                                : false,
                        isButtonVisible:
                            vehicleDetailsXController.isNextButtonClicked
                                ? false
                                : true,
                        status: "completed".tr,
                        buttonText: 'Start',
                        onButtonClick: () {
                          _controller.onStartButtonClicked(position: 0);
                        },
                        onExpansionChanged: (val) {},
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _controller.isCarWindScreenSelected ||
                            _controller.isPoliceReportSelected
                        ? true
                        : false,
                    child: IgnorePointer(
                      ignoring:
                          !vehicleDetailsXController.isAnActivePlanSelected
                              ? true
                              : false,
                      child: CustomExpandableTile(
                        expansionCardKey:
                            vehicleDetailsXController.expansionCardKey[1],
                        title: '2',
                        classview: ClaimDetails(),
                        name: 'enterClaimDetails'.tr,
                        isButtonVisible:
                            vehicleDetailsXController.isAnActivePlanSelected &&
                                    !vehicleDetailsXController
                                        .isClaimDetailSubmitted
                                ? true
                                : false,
                        isStatusVisible: vehicleDetailsXController
                                    .isAnActivePlanSelected &&
                                vehicleDetailsXController.isClaimDetailSubmitted
                            ? true
                            : false,
                        buttonText:
                            vehicleDetailsXController.isClaimDetailSubmitted
                                ? 'Edit'
                                : 'Start',
                        status: "completed".tr,
                        onButtonClick: () {
                          _controller.onStartButtonClicked(position: 1);
                        },
                        onExpansionChanged: (val) {},
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _controller.isCarWindScreenSelected ||
                            _controller.isPoliceReportSelected
                        ? true
                        : false,
                    child: IgnorePointer(
                      ignoring:
                          vehicleDetailsXController.isUploadDocumentVisible
                              ? false
                              : true,
                      child: CustomExpandableTile(
                        expansionCardKey:
                            vehicleDetailsXController.expansionCardKey[2],
                        title: '3',
                        classview: MotorClaimUploadDocument(),
                        name: 'uploadDocuments'.tr,
                        isStatusVisible: vehicleDetailsXController
                                    .isAnActivePlanSelected &&
                                vehicleDetailsXController.isClaimDetailSubmitted
                            ? true
                            : false,
                        isButtonVisible: vehicleDetailsXController
                                    .isAnActivePlanSelected &&
                                vehicleDetailsXController.isClaimDetailSubmitted
                            ? true
                            : false,
                        buttonText: 'Start',
                        onButtonClick: () {
                          _controller.onStartButtonClicked(position: 2);
                        },
                        onExpansionChanged: (val) {},
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _controller.isMinorMotorClaimSelected ? true : false,
                child: IgnorePointer(
                  ignoring: vehicleDetailsXController.isNextButtonClicked &&
                          vehicleDetailsXController.isAnActivePlanSelected
                      ? false
                      : true,
                  child: CustomExpandableTile(
                    expansionCardKey:
                        vehicleDetailsXController.expansionCardKey[1],
                    classview: MiniMotorCalimFlow(),
                    leadindIcon: '',
                    title: '2',
                    name: 'minorMotorClaim'.tr,
                    isButtonVisible: vehicleDetailsXController
                                .isAnActivePlanSelected &&
                            !vehicleDetailsXController.isClaimDetailSubmitted
                        ? true
                        : false,
                    isStatusVisible: vehicleDetailsXController
                                .isAnActivePlanSelected &&
                            !vehicleDetailsXController.isClaimDetailSubmitted
                        ? true
                        : false,
                    buttonText: 'Start',
                    onButtonClick: () {
                      _controller.onStartButtonClicked(position: 1);
                    },
                    onExpansionChanged: (val) {},
                  ),
                ),
              )
            ],
          );
        });
  }

  motorClaimCard(String image, String title) {
    return Container(
      margin:
          const EdgeInsets.only(left: 20, right: 20.0, top: 10.0, bottom: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: MyColors.container_Bg,
                offset: Offset(0, 6),
                blurRadius: 9,
                spreadRadius: 0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            child: SvgPicture.asset(image),
          ),
          SizedBox(
            width: 8,
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
    );
  }
}
