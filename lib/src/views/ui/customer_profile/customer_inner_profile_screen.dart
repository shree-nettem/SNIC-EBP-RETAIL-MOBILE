import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_loader.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/Identification_details_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/basic_info_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/financial_details_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/mailing_info_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/widgets/basic_info_form.dart';
import 'package:ebpv2/src/views/ui/customer_profile/widgets/financial_details_form.dart';
import 'package:ebpv2/src/views/ui/customer_profile/widgets/identification_form.dart';
import 'package:ebpv2/src/views/ui/customer_profile/widgets/mailing_info_form.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'customer_profile_controllers/customer_profile_controller.dart';

class InnerProfileView extends StatelessWidget {
  final CustomerProfileController _profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _profileController,
      builder: (_) {
        return !_profileController.isLoading
            ? ListView.builder(
                shrinkWrap: true,
                controller: _profileController.scrollController,
                physics: PageScrollPhysics(),
                // physics: ScrollPhysics(),
                // physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  bool status = false;
                  if (index == 1) {
                    status = _profileController.basicInformation.value;
                  } else if (index == 2) {
                    status = _profileController.financialDetails.value;
                  } else if (index == 3) {
                    status = _profileController.identification.value;
                  } else if (index == 4) {
                    status = _profileController.personalVerification.value;
                  } else if (index == 5) {
                    status = _profileController.mailingAddress.value;
                  }
                  if (index == 0)
                    return Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomLabel(
                          textAlign: TextAlign.center,
                          title: _profileController.customerName.value,
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        ),
                      );
                    });
                  return InkWell(
                    onTap: () {},
                    child: ExpansionCardView(
                      index: index - 1,
                      isCompleted: status,
                    ),
                  );
                },
              )
            : CustomLoader();
      },
    );
  }
}

class ExpansionCardView extends StatelessWidget {
  final index;
  final bool isCompleted;
  final CustomerProfileController _profileController = Get.find();

  ExpansionCardView({Key key, this.index, this.isCompleted}) : super(key: key);
  final GlobalKey<ExpansionTileCardState> _expansionCardKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 5, 32, 5),
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: MyColors.GrayColor,
            blurRadius: 22.0,
            offset: Offset(
              0.0,
              6.0,
            ),
          ),
        ],
      ),
      child: AutoScrollTag(
        key: ValueKey(index),
        controller: _profileController.scrollController,
        index: 4,
        child: Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Obx(() {
              return Opacity(
                opacity: _profileController.cardViewExpanded.value
                    ? _profileController.expandedIndex.value == index
                        ? 1.0
                        : _profileController.opacityValue.value
                    : 1.0,
                child: IgnorePointer(
                  ignoring: _profileController.expandedIndex.value == index
                      ? false
                      : _profileController.cardViewExpanded.value,
                  child: ExpansionTileCard(
                    trailing: SizedBox.shrink(),
                    key: _expansionCardKey,
                    onExpansionChanged: (expandedValue) {
                      print(expandedValue);
                      print("object");

                      print(_profileController
                          .scrollController.position.maxScrollExtent);
                      print(index);
                      if (expandedValue && index == 4) {
                        _profileController.scrollController.scrollToIndex(4,
                            preferPosition: AutoScrollPosition.begin);
                        // _profileController.update();
                      }

                      !_profileController.personalVerification.value
                          ? _profileController.togglingExpansion(
                              expandedValue, index)
                          : SizedBox.shrink();
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Opacity(
                            opacity: _profileController.cardViewExpanded.value
                                ? _profileController.expandedIndex.value ==
                                        index
                                    ? 1.0
                                    : _profileController.opacityValue.value
                                : 1.0,
                            child: CustomLabel(
                              title:
                                  _profileController.profileCategories[index],
                              color: MyColors.PrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        if (!_profileController.cardViewExpanded.value)
                          statusWidget(
                              isCompleted
                                  ? MyColors.VerticalDividerColor
                                  : MyColors.requiredFieldColor,
                              widgetText:
                                  isCompleted ? 'completed'.tr : 'required'.tr),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: _innerProfileExpansionViews(index),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSaveButton(index),
                            const SizedBox(
                              width: 8,
                            ),
                            _buildCancelButton(index),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }

  Widget _innerProfileExpansionViews(int index) {
    if (index == 0) {
      return BasicInfoFormView();
    } else if (index == 1) {
      return FinancialDetailsFormView();
    } else if (index == 2) {
      return IdentificationDetailsFormView();
    } else if (index == 3) {
      return PersonalIdentificationView();
    } else if (index == 4) {
      return MailingInfoForm();
    } else {
      return Container();
    }
  }

//Marks the status of information
  Widget statusWidget(Color widgetColor, {String widgetText = ''}) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            height: 10,
            width: 10,
            color: widgetColor,
          ),
        ),
        SizedBox(width: 5),
        CustomLabel(
          title: widgetText,
          color: widgetColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ],
    );
  }

  /* SAVE BUTTON */
  Widget _buildSaveButton(int index) {
    return Center(
      child: Opacity(
        opacity: index == 3
            ? _profileController.personalVerification.value
                ? 0.3
                : 1
            : 1,
        child: CustomButton(
          title: index == 3
              ? _profileController.personalVerification.value
                  ? "completed".tr
                  : 'Start'
              : 'Save',
          width: 114,
          fontSize: 12,
          height: 26,
          buttonAction: () {
            _expansionCardKey.currentState.collapse();
            if (index == 0) {
              Get.find<BasicInfoXController>().saveBasicInformation();
            } else if (index == 1) {
              Get.find<FinancialDetailsXController>().saveFinancialInfo();
            } else if (index == 2) {
              Get.find<IdentificationDetailsXController>().saveIdentityInfo();
            } else if (index == 4) {
              // _profileController.scrollToIndex();
              Get.find<MailingInfoXController>().saveMailInfo();
            } else if (index == 3) {
              if (!_profileController.personalVerification.value)
                _profileController.initJumio();
            }

            _profileController.togglingExpansion(false, index);
          },
        ),
      ),
    );
  }

/* CANCEL BUTTON */
  Widget _buildCancelButton(int index) {
    return Center(
      child: CustomButton(
        title: 'cancel'.tr,
        width: 114,
        fontSize: 12,
        height: 26,
        bgColor: Colors.grey,
        isActive: false,
        buttonAction: () {
          _expansionCardKey.currentState.collapse();
          _profileController.togglingExpansion(false, index);
        },
      ),
    );
  }
}

class PersonalIdentificationView extends StatelessWidget {
  final CustomerProfileController _profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('personal-widget-key'),
      onVisibilityChanged: (VisibilityInfo info) {},
      child: Container(),
    );
  }
}
