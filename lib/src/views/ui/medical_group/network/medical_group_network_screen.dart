import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_bottom_call_options.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_divider.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/medical_group/network/medical_group_network_controller.dart';
import 'package:ebpv2/src/views/ui/medical_group/widgets/medical_group_custom_dropdown.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/medical_network/medical_network_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/medical_group_custom_search.dart';
import 'package:get/get.dart';

class MedicalGroupNetworkScreen extends StatelessWidget {
  final MedicalGroupNetwornXController _controller =
      Get.put(MedicalGroupNetwornXController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (cntrlr) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              children: [
                if (_controller.viewHospital)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabel(
                        title: "search".tr,
                        color: MyColors.PrimaryColor,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT / 2),
                      Row(
                        children: [
                          MedicalGroupCustomSearchBar(
                            onChanged: (val) {
                              print(val);
                              _controller.searchText = val;
                              _controller.filteredHospitalFromFilters();
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              _controller.activateFitlerAction();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.PrimaryColor,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  Images.filter,
                                  width: 12.5,
                                  height: 12.5,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                    ],
                  ),
                if (_controller.viewHospital && _controller.filterActivate)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabel(
                        title: "category".tr,
                        color: MyColors.PrimaryColor,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: MedicalGroupCustomDropDown(
                          options: _controller.totslCategories,
                          label: _controller.selectedCategory,
                          onChanged: (val) {
                            _controller.selectedCategory = val;
                            _controller.filteredHospitalFromFilters();
                          },
                        ),
                      ),
                      CustomLabel(
                        title: "specialization".tr,
                        color: MyColors.PrimaryColor,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: MedicalGroupCustomDropDown(
                          options: _controller.totalSpecilization,
                          label: _controller.selectedSpecilization,
                          onChanged: (val) {
                            _controller.selectedSpecilization = val;
                            _controller.filteredHospitalFromFilters();
                          },
                        ),
                      ),
                      CustomLabel(
                        title: "location".tr,
                        color: MyColors.PrimaryColor,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: MedicalGroupCustomDropDown(
                          options: _controller.totalCities,
                          label: _controller.selectedCity,
                          onChanged: (val) {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            _controller.selectedCity = val;
                            _controller.filteredHospitalFromFilters();
                          },
                        ),
                      ),
                    ],
                  ),
                if (!_controller.viewHospital)
                  CustomLabel(
                    title: "myFavorite".tr,
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    maxLines: 2,
                  ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                MyFavoriteView(
                  controller: _controller,
                  isHospitalList: _controller.viewHospital,
                ),
                CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                if (!_controller.viewHospital)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_controller.medicalNetwork.isNotEmpty)
                        CustomLabel(
                          title: "medicalNetwork".tr,
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          maxLines: 2,
                        ),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                      if (_controller.medicalNetwork.isNotEmpty)
                        PremiumPlusView(
                          controller: _controller,
                        ),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                      _buildActionButton(context, "viewAllHospitals".tr,
                          svgImage: null, onclick: () {
                        _controller.toggleViewHospital();
                      }),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
                      _buildActionButton(context, "contactSupport".tr,
                          svgImage: Images.call, onclick: () {
                        showBottomcallOptions(_controller.contactSupport);
                      }),
                      CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
                    ],
                  ),
              ],
            ),
          );
        });
  }

  /* ADD NEW  BUTTON */
  Widget _buildActionButton(BuildContext context, String title,
      {String svgImage, Function onclick}) {
    return Center(
      child: CustomButton(
          title: title,
          width: MediaQuery.of(context).size.width / 2 + 50,
          fontSize: 12,
          paddingWidth: 10,
          height: 40,
          svgImage: svgImage,
          buttonAction: onclick != null ? onclick : () {},
          languageCode: false),
    );
  }
}

class PremiumPlusView extends StatelessWidget {
  final MedicalGroupNetwornXController controller;

  PremiumPlusView({this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // if you need this
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.from(controller.medicalNetwork
              .map((e) => commonPremiumPlusView(e.title, e.value))),
        ),
      ),
    );
  }

  //COMMON WIDGET
  Widget commonPremiumPlusView(title, subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Container(
            height: 5,
            width: 5,
            decoration: BoxDecoration(
                color: MyColors.PrimaryColor,
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabel(
                title: title,
                maxLines: 5,
              ),
              CustomLabel(
                title: subTitle,
                maxLines: 15,
              ),
              CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
            ],
          ),
        ),
      ],
    );
  }
}

class MyFavoriteView extends StatelessWidget {
  final MedicalGroupNetwornXController controller;
  final bool isHospitalList;

  const MyFavoriteView({this.controller, this.isHospitalList});

  @override
  Widget build(BuildContext context) {
    var items = isHospitalList
        ? controller.totalFilteredHospitals
        : controller.totalFavHospitals;
    return items.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (isHospitalList)
                    ? label('no_provider_currently'.tr,
                        fontSize: SmallFontSize,
                        color: MyColors.mainBackgroundColor)
                    : label('no_fav_provider'.tr,
                        fontSize: SmallFontSize,
                        color: MyColors.mainBackgroundColor),
                if (!isHospitalList) addVerticalHeight(5.0),
                if (!isHospitalList)
                  label('add_prodviders_to_your_fav'.tr,
                      fontSize: SmallFontSize,
                      maxLines: 4,
                      color: MyColors.mainBackgroundColor),
              ],
            ),
          )
        : Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: isHospitalList
                  ? controller.totalFilteredHospitals.length > 10
                      ? (controller.currentLoadedIndex + 1)
                      : controller.currentLoadedIndex + 1
                  : controller.totalFavHospitals.length,
              itemBuilder: (context, index) {
                if (isHospitalList && index == controller.currentLoadedIndex) {
                  return index == controller.totalFilteredHospitals.length
                      ? Container()
                      : Column(
                          children: [
                            CustomDivider(
                              color: Color.fromRGBO(241, 243, 245, 1),
                            ),
                            CustomSpacer(
                                value: Dimensions.PADDING_SIZE_DEFAULT),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  controller.getMoreDataPagination();
                                },
                                child: CustomLabel(
                                  fontSize: Dimensions.FONT_SIZE_SMALL,
                                  fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                                  fontWeight: FontWeight.w600,
                                  title: 'view_more'.tr,
                                ),
                              ),
                            ),
                          ],
                        );
                }

                return Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: ListTile(
                          leading: Image(
                            image: AssetImage('assets/images/medical.png'),
                          ),
                          title: label(
                            isHospitalList
                                ? controller
                                    .totalFilteredHospitals[index].providerName
                                : controller.filterFavHospitalName(controller
                                        .totalFavHospitals[index].branchId) ??
                                    "",
                            fontWeight: FontWeight.bold,
                            fontSize: MediumFontSize,
                            maxLines: 3,
                          ),
                          trailing: InkWell(
                            onTap: () {
                              isHospitalList
                                  ? controller.checkingFavHospital(controller
                                          .totalFilteredHospitals[index]
                                          .providerId)
                                      ? controller.saveFavoriteHospitals(
                                          controller
                                              .totalFilteredHospitals[index]
                                              .providerId,
                                          addingNewHosp: false)
                                      : controller.saveFavoriteHospitals(
                                          controller
                                              .totalFilteredHospitals[index]
                                              .providerId)
                                  : controller.saveFavoriteHospitals(
                                      controller
                                          .totalFavHospitals[index].branchId,
                                      addingNewHosp: false);
                            },
                            child: SvgPicture.asset(
                              isHospitalList
                                  ? controller.checkingFavHospital(controller
                                          .totalFilteredHospitals[index]
                                          .providerId)
                                      ? Images.favorite_full
                                      : Images.favorite_empty
                                  : Images.favorite_full,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          subtitle: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                            child: label(
                                isHospitalList
                                    ? controller.totalFilteredHospitals[index]
                                        .cityDescription
                                    : controller.filterFavHospitalName(
                                            controller.totalFavHospitals[index]
                                                .branchId,
                                            isTitle: false) ??
                                        "",
                                fontSize: SmallFontSize),
                          ),
                          selected: true,
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
