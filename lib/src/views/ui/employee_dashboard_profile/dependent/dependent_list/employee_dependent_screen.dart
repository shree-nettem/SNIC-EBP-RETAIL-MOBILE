import 'package:ebpv2/src/utilities/constants.dart';
import '../../../../../utilities/colors.dart' as Style;
import '../../../../../utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/employee_dashboard_profile/dependent/add_dependent/add_new_dependent_screen.dart';
import 'package:ebpv2/src/views/ui/employee_dashboard_profile/dependent/edit_dependent/edit_dependent_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'employee_dependent_controller.dart';

class EmployeeDependentScreen extends StatelessWidget {
  static final pageId = "/employeeDependentScreen";
  final EmployeeDependentXController controller =
      Get.put(EmployeeDependentXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      appBar: appBar("Dependents"),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return employeeDependentProfileUI();
        },
      ),
    );
  }

  //  EMPLOYEE DASHBOARD PROFILE UI
  Widget employeeDependentProfileUI() {
    return SafeArea(
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              addVerticalHeight(10.0),
              DependentListWidget(dependantController: controller),
              addVerticalHeight(20.0),
              addDependentStaticView(),
              addVerticalHeight(10.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget addDependentStaticView() {
    return Column(
      children: [
        new ListTile(
          onTap: () {
            Get.toNamed(AddNewDependentScreen.pageId);
          },
          leading: new ImageIcon(
            AssetImage("assets/images/add_new.png"),
            size: 56,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label("ADD NEW", fontSize: MediumFontSize),
              addVerticalHeight(5.0),
              label("ADD A NEW DEPENDENT"),
            ],
          ),
        ),
      ],
    );
  }
}

//DEPENDENT LIST
class DependentListWidget extends StatelessWidget {
  final EmployeeDependentXController dependantController;

  DependentListWidget({this.dependantController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: dependantController.dependents.length,
          itemBuilder: (context, index) {
            var dependents = dependantController.dependents[index];
            var middleName = dependents.middleName ?? "";
            var fullName = dependents.firstName +
                " " +
                middleName +
                " " +
                dependents.lastName;
            var relation =
                dependantController.dependents[index].relationshipType;
            var memberPhoto = dependents.photo;
            print("Photo $memberPhoto");
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Get.toNamed(EditDependentScreen.pageId, arguments: {
                    'dependent': dependents,
                  });
                },
                leading: CircleAvatar(
                  radius: 27,
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2),
                          BlendMode.srcOver,
                        ),
                        image: (memberPhoto != null)
                            ? NetworkImage(
                                Constants.BASE_FILE_URL + memberPhoto)
                            : (relation == 1)
                                ? AssetImage(
                                    "assets/images/female_customer.png")
                                : AssetImage("assets/images/upload_icon.png"),
                      ),
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label(fullName, fontSize: MediumFontSize),
                    addVerticalHeight(5.0),
                    label(
                        relation == 1
                            ? "Spouse"
                            : relation == 2
                                ? "Son"
                                : "Daughter",
                        fontSize: SmallFontSize),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
