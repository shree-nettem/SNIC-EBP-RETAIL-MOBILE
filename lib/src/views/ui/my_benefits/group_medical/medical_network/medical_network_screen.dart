import '../../../../../utilities/colors.dart' as Style;
import '../../../../../utilities/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'medical_network_controller.dart';
import 'my_medical_network_screen.dart';

class MedicalNetworkScreen extends StatelessWidget {
  static final pageId = "/medicalNetworkScreen";
  final MedicalNetworkXController controller =
      Get.put(MedicalNetworkXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      appBar: appBar("Medical Network"),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return medicalNetworkUI();
        },
      ),
    );
  }

  Widget medicalNetworkUI() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label(
                "Premium Plus",
                fontSize: RegularFontSize,
                color: Style.MyColors.themeColor,
                fontWeight: FontWeight.bold,
              ),
              addVerticalHeight(15.0),
              PremiumPlusView(controller: controller),
              addVerticalHeight(15.0),
              label(
                "My Favorites",
                fontWeight: FontWeight.bold,
                fontSize: RegularFontSize,
              ),
              addVerticalHeight(8.0),
              MyFavoriteView(controller: controller),
              addVerticalHeight(16.0),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: button(
                  'View My Medical Network',
                  () => {
                    Get.toNamed(MyMedicalNetworkScreen.pageId),
                  },
                  isRounded: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PremiumPlusView extends StatelessWidget {
  final MedicalNetworkXController controller;

  PremiumPlusView({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.MyColors.themeColor,
        border: Border.all(
          color: Style.MyColors.themeColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Column(
        children: [
          networkSummaryUI(),
          freeAccessUI(),
          treatmentOutsideNetworkView(),
          contactSupportView(),
        ],
      ),
    );
  }

  //NETWORK SUMMARY
  Widget networkSummaryUI() {
    return commonPremiumPlusView("Network Summary", MdiIcons.hospitalBuilding,
        "21 Hospitals, 280 Clinics, 97 Pharmacies");
  }

  //FREE ACCESS
  Widget freeAccessUI() {
    return commonPremiumPlusView(
        "Free access at designated providers in",
        MdiIcons.currencyUsdOff,
        "Bahrain, Kuwait, Qatar, KSA, UAE, Oman, Jordan, Kurdistan, Egypt, Romania, India, subject to prior approval");
  }

  // TREATMENT OUTSIDE NETWORK
  Widget treatmentOutsideNetworkView() {
    return commonPremiumPlusView(
        "Treatment outside network",
        MdiIcons.currencyUsd,
        "20% deductible, claim submission period 30 days for treatments within Bahrain and 60 days outside from treatment date");
  }

  //CONTACT SUPPORT
  Widget contactSupportView() {
    return commonPremiumPlusView(
        "Contact Support", MdiIcons.phone, controller.longContact ?? "");
  }

  //COMMON WIDGET
  Widget commonPremiumPlusView(title, icon, subTitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 24.0,
              ),
              addHorizontalWidth(20.0),
              Flexible(
                child: label(title,
                    fontSize: RegularFontSize,
                    color: Style.MyColors.MainColor,
                    maxLines: 2),
              ),
            ],
          ),
          addVerticalHeight(8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Style.MyColors.themeColor,
                size: 24.0,
              ),
              addHorizontalWidth(20.0),
              Flexible(
                child: label(
                  subTitle,
                  fontSize: SmallFontSize,
                  color: Style.MyColors.MainColor,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyFavoriteView extends StatelessWidget {
  final MedicalNetworkXController controller;

  const MyFavoriteView({this.controller});

  @override
  Widget build(BuildContext context) {
    var items = controller.filteredFavoriteList;
    return items.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label('You don’t have any favorite providers currently',
                    fontSize: SmallFontSize,
                    color: Style.MyColors.mainBackgroundColor),
                addVerticalHeight(5.0),
                label(
                    'Add providers to your favorites for easy access by clicking the next to the provider you wish to favorite',
                    fontSize: SmallFontSize,
                    maxLines: 4,
                    color: Style.MyColors.mainBackgroundColor),
              ],
            ),
          )
        : Container(
            height: 100.0,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var provider = controller.filteredFavoriteList[index];
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
                            provider.pROVIDERNAME,
                            fontWeight: FontWeight.bold,
                            fontSize: MediumFontSize,
                            maxLines: 3,
                          ),
                          trailing: Icon(MdiIcons.star),
                          subtitle: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                            child: label(provider.cITYDESCRIPTION,
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
