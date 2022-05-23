import '../../../../../utilities/colors.dart' as Style;
import '../../../../../utilities/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'medical_cart_controller.dart';

class MedicalECardScreen extends StatelessWidget {
  static final pageId = "/medicalECardScreen";
  final MedicalCartController controller = Get.put(MedicalCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      appBar: appBar("Medical E-Cards"),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return medicalECardUI();
        },
      ),
    );
  }

  Widget medicalECardUI() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: controller.eCardList.length,
          itemBuilder: (BuildContext context, int index) {
            var eCard = controller.eCardList[index];
            return ListTile(
              leading: CircleAvatar(
                child: Container(
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.srcOver,
                      ),
                      image: AssetImage("assets/images/upload_icon.png"),
                    ),
                  ),
                ),
              ),
              title: label(
                eCard.firstName + " " + eCard.lastName,
                fontSize: MediumFontSize,
                fontWeight: FontWeight.bold,
              ),
              trailing: Icon(Icons.arrow_forward),
            );
          },
        ),
      ),
    );
  }
}
