import '../../../../../utilities/colors.dart' as Style;
import '../../../../../utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/table_of_benefits/table_of_benefits_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TableOfBenefitsScreen extends StatelessWidget {
  static final pageId = "/tableOfBenefitsScreen";
  final TableOfBenefitsController controller =
      Get.put(TableOfBenefitsController());

  @override
  Widget build(BuildContext context) {
    debugPrint("15");
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      appBar: appBar("Table of Benefits"),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //DOWNLOAD TRAVEL CERTIFICATE DOCUMENT
                    Visibility(
                      visible:
                          controller.medicalCardList.length > 0 ? true : false,
                      child: button(
                        'getTravelCertificate'.tr,
                        () {
                          travelCertificateDialog(context);
                        },
                      ),
                    ),
                    addVerticalHeight(16.0),
                    TableOfBenefitsView(
                      controller: controller,
                    ),
                    addVerticalHeight(16.0),
                    SubTableOfBenefitsView(
                      controller: controller,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void travelCertificateDialog(context) {
    var alertStyle = AlertStyle(
      isCloseButton: true,
      isOverlayTapDismiss: true,
      constraints: BoxConstraints.expand(width: Get.width * 0.9),
      descStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MediumFontSize,
        color: Colors.grey[700],
      ),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
      ),
      backgroundColor: Colors.white,
      alertAlignment: Alignment.center,
    );

    Alert(
      context: Get.context,
      style: alertStyle,
      closeIcon: Icon(
        Icons.close,
        color: Colors.red,
      ),
      closeFunction: () {
        Navigator.pop(context);
      },
      title: "Download Travel Certificate Document",
      desc: "Select members:",
      buttons: [],
      content: Column(
        children: <Widget>[
          GetBuilder(
            init: controller,
            builder: (_) {
              return Container(
                height: Get.height * 0.2,
                width: Get.width * 0.9,
                child: ListView.builder(
                  itemCount: controller.medicalCardList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      title: label(
                        controller.medicalCardList[index].firstName +
                                " " +
                                controller.medicalCardList[index].lastName ??
                            "",
                        fontSize: MediumFontSize,
                      ),
                      value: controller.isChecked[index],
                      onChanged: (bool value) {
                        controller.isMedicalCardChecked(value, index,
                            controller.medicalCardList[index].identityID);
                      },
                    );
                  },
                ),
              );
            },
          ),
          DialogButton(
            child: label(
              "Submit",
              fontSize: MediumFontSize,
              color: Colors.white,
            ),
            onPressed: () {
              controller.launchURL();
            },
            color: Style.MyColors.themeColor,
            width: Get.width * 0.9,
          ),
        ],
      ),
    ).show();
  }
}

class TableOfBenefitsView extends StatelessWidget {
  final TableOfBenefitsController controller;

  const TableOfBenefitsView({this.controller});

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
      child: ListView.builder(
        itemCount: controller.subSectionList.length > 0 ? 5 : 0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var list = controller.subSectionList[index];
          return ListTile(
            title: commonTableOfBenefitsWidget(
                controller.subSectionList.length > 0 ? list.title : "",
                MdiIcons.phone,
                controller.subSectionList.length > 0 ? list.value : ""),
          );
        },
      ),
    );
  }

  //COMMON WIDGET
  Widget commonTableOfBenefitsWidget(title, icon, subTitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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

class SubTableOfBenefitsView extends StatelessWidget {
  final TableOfBenefitsController controller;

  const SubTableOfBenefitsView({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: ListView.builder(
        itemCount: controller.customerTOBList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var list = controller.customerTOBList[index];
          return Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.black),
            child: ExpansionTile(
              title: commonTableOfBenefitsWidget(
                list.title ?? "",
                MdiIcons.phone,
                list.subSections[0].value ?? "",
              ),
              children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    label(
                      list.subSections[0].value ?? "",
                      fontSize: SmallFontSize,
                    ),
                    addVerticalHeight(16.0),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //COMMON WIDGET
  Widget commonTableOfBenefitsWidget(title, icon, subTitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Column(
        children: [
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
                  title,
                  fontSize: RegularFontSize,
                  color: Style.MyColors.themeColor,
                  maxLines: 2,
                ),
              ),
              addVerticalHeight(8.0),
            ],
          ),
          addVerticalHeight(8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Style.MyColors.MainColor,
                size: 24.0,
              ),
              addHorizontalWidth(20.0),
              Flexible(
                child: label(
                  subTitle,
                  fontSize: SmallFontSize,
                  color: Style.MyColors.black,
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
