import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/utilities/app_helper.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/base/custom_dialog.dart';
import 'package:ebpv2/src/views/base/custom_divider.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/dashboard/widgets/Insurance_plan_view.dart';
import 'package:ebpv2/src/views/ui/home/home_screen.dart';
import 'package:ebpv2/src/views/ui/medical_ecard/medical_ecard_screen.dart';
import 'package:ebpv2/src/views/ui/more/more_screen.dart';
import 'package:ebpv2/src/views/ui/plan/plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardXController controller = Get.put(DashboardXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: WillPopScope(
            onWillPop: () {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('confirm_logout'.tr),
                      content: Text('are_you_sure_logout'.tr),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            primary: Colors.white,
                          ),
                          child: CustomLabel(
                            title: 'yes'.tr,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            AppHelper.logout();
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            primary: Colors.white,
                          ),
                          child: CustomLabel(
                            title: 'no'.tr,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
            child: Scaffold(
              backgroundColor: MyColors.MainColor,
              resizeToAvoidBottomInset: true,
              body: DashboardIndexStackView(controller: controller),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: new FloatingActionButton(
                child: SvgPicture.asset(
                  Images.plus_active,
                ),
                onPressed: () {
                  showAnimatedDialog(
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 375,
                        width: Get.width * 0.6,
                        margin: EdgeInsets.only(
                            bottom: Get.height * 0.12, left: 12, right: 12),
                        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Column(
                            children: [
                              CustomLabel(
                                title: "Set up your",
                                fontSize: 22,
                                fontWeight: FontWeight.normal,
                                fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                              ),
                              CustomDivider(),
                              InsurancePlanView(
                                title: "Ghady Saving Plan",
                                image: Images.ghady_insurance,
                                onTapped: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.GHADY_SAVING_HOME,
                                      arguments: {"index": 1});
                                },
                              ),
                              CustomDivider(),
                              InsurancePlanView(
                                title: "Motor Insurance",
                                image: Images.motor_insurance,
                                onTapped: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.MOTOR_INSURANCE);
                                },
                              ),
                              CustomDivider(),
                              InsurancePlanView(
                                title: "Group Medical",
                                image: Images.medical,
                                onTapped: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.MEDICAL_GROUP);
                                },
                              ),
                              CustomDivider(),
                              InsurancePlanView(
                                title: "Group Life",
                                image: Images.group_life,
                                onTapped: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.GROUP_LIFE_SCREEN);
                                },
                              ),
                              CustomDivider(),
                              InsurancePlanView(
                                title: "Plan Renewal",
                                image: Images.plan,
                                onTapped: () {
                                  Get.back();
                                  // Get.find<DashboardXController>()
                                  // .changeTabIndex(1);
                                  Get.toNamed(AppRoutes.MOTOR_RENEWAL);

                                  // Get.toNamed(AppRoutes.LOYALTY_HOME);
                                },
                              ),
                              CustomDivider(),
                              InsurancePlanView(
                                title: "Loyalty Program",
                                image: Images.loyalty,
                                onTapped: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.LOYALTY_HOME);
                                },
                              ),
                              CustomDivider(),
                              InsurancePlanView(
                                title: "Claims",
                                image: Images.claims,
                                onTapped: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.CLAIM_SCREEN);
                                },
                              ),
                              CustomDivider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(color: Colors.lightGreen),
                selectedItemColor: Colors.black,
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: SvgPicture.asset(
                        (controller.tabIndex == 0)
                            ? Images.dashboard_active
                            : Images.dashboard,
                      ),
                    ),
                    label: 'home'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: SvgPicture.asset(
                        (controller.tabIndex == 1)
                            ? Images.plans_active
                            : Images.plans,
                      ),
                    ),
                    label: 'plans'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Visibility(visible: false, child: Container()),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: SvgPicture.asset(
                        (controller.tabIndex == 3)
                            ? Images.e_card_active
                            : Images.e_card,
                      ),
                    ),
                    label: 'e_card'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: SvgPicture.asset(
                        (controller.tabIndex == 4
                            ? Images.more_active
                            : Images.more),
                      ),
                    ),
                    label: 'more'.tr,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DashboardIndexStackView extends StatelessWidget {
  final DashboardXController controller;

  DashboardIndexStackView({this.controller});

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: controller.tabIndex,
      children: [
        HomeScreen(),
        Plans(),
        HomeScreen(),
        MedicalEcardScreen(),
        MoreScreen(),
      ],
    );
  }
}
