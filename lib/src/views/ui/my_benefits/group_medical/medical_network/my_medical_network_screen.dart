import '../../../../../utilities/ui_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'medical_network_controller.dart';

class MyMedicalNetworkScreen extends StatelessWidget {
  static final pageId = "/myMedicalNetworkScreen";
  final MedicalNetworkXController controller =
      Get.put(MedicalNetworkXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: true,
      appBar: appBar("My Medical Network"),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return myMedicalNetworkView();
        },
      ),
    );
  }

  Widget myMedicalNetworkView() {
    return SafeArea(
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(12.0),
        child: MyMedicalNetworkView(controller: controller),
      ),
    );
  }
}

class MyMedicalNetworkView extends StatelessWidget {
  final MedicalNetworkXController controller;

  MyMedicalNetworkView({this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.providerList.length,
      itemBuilder: (context, index) {
        var provider = controller.providerList[index];
        return Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // if you need this
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
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
                trailing: InkWell(
                  child: Icon(MdiIcons.starOutline),
                  onTap: () {
                    controller.makeFavourite(provider.pROVIDERID);
                  },
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child:
                      label(provider.cITYDESCRIPTION, fontSize: SmallFontSize),
                ),
                selected: true,
                onTap: () {
                  print("On Tapped!");
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
