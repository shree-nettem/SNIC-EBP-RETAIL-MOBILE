import '../../../utilities/colors.dart' as Style;
import '../../../utilities/ui_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import 'employee_profile_controller.dart';

class EmployeeProfileScreen extends StatelessWidget {
  static final pageId = "/employeeProfileScreen";
  final EmployeeProfileXController controller =
      Get.put(EmployeeProfileXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return employeeProfileUI();
        },
      ),
    );
  }

  //EMPLOYEE PROFILE UI
  Widget employeeProfileUI() {
    return SafeArea(
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              addVerticalHeight(30.0),
              _employeeProfileTextUI(),
              addVerticalHeight(40.0),
              _employeeImageUI(),
              addVerticalHeight(40.0),
              _employeeProfileFormUI(),
              addVerticalHeight(5.0),
              _continueButtonUI(),
              addVerticalHeight(5.0),
            ],
          ),
        ),
      ),
    );
  }

  //EMPLOYEE PROFILE TEXT
  Widget _employeeProfileTextUI() {
    return Container(
      child: new Column(
        children: <Widget>[
          label("Welcome to employee benefits platform",
              textAlign: TextAlign.center,
              fontSize: LargeFontSize,
              color: Color(0xFF707070),
              maxLines: 2),
          addVerticalHeight(20.0),
          label("Complete your profile to log in",
              textAlign: TextAlign.center,
              fontSize: RegularFontSize,
              color: Color(0xFF707070),
              maxLines: 2),
        ],
      ),
    );
  }

//EMPLOYEE PROFILE PICTURE
  Widget _employeeImageUI() {
    return Container(
      alignment: Alignment.center,
      child: new Container(
        child: InkWell(
          onTap: () {
            _showPicker();
          },
          child: CircleAvatar(
            radius: 70,
            child: controller.image != null
                ? Container(
                    width: 200.0,
                    height: 200.0,
                    child: Center(
                      child: label(
                        'Click here to upload photo',
                        maxLines: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        fontSize: SmallFontSize,
                      ),
                    ),
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2),
                          BlendMode.srcOver,
                        ),
                        image: FileImage(controller.image),
                      ),
                    ),
                  )
                : Container(
                    width: 200.0,
                    height: 200.0,
                    child: Center(
                      child: label(
                        'Click here to upload photo',
                        maxLines: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        fontSize: SmallFontSize,
                      ),
                    ),
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
        ),
      ),
    );
  }

  void _showPicker() {
    showModalBottomSheet(
      context: Get.context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: label("documents".tr, fontSize: MediumFontSize),
                  onTap: () {
                    controller.getImageGallery();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: label("camera".tr, fontSize: MediumFontSize),
                  onTap: () {
                    controller.getImageCamera();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //EMPLOYEE PROFILE FORM
  Widget _employeeProfileFormUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paddingLabel("NAME*"),
        textField(
          textController: controller.firstNameController,
          keyboardInputType: InputTypeEnum.alpha,
          textInputType: TextInputType.name,
          hintText: 'First Name',
          errorText: 'First Name is required',
          validate: controller.validate['first_name'],
          onChanged: (value) {
            controller.updateProfileFNameValidation();
          },
        ),
        textField(
          textController: controller.middleNameController,
          hintText: 'Middle Name',
          keyboardInputType: InputTypeEnum.alpha,
          textInputType: TextInputType.name,
          onChanged: (value) {},
        ),
        textField(
          textController: controller.lastNameController,
          hintText: 'Last Name',
          keyboardInputType: InputTypeEnum.alpha,
          textInputType: TextInputType.name,
          errorText: 'Last Name is required',
          validate: controller.validate['last_name'],
          onChanged: (value) {},
        ),
        addVerticalHeight(10.0),
        paddingLabel("GENDER*"),
        addVerticalHeight(10.0),
        _genderSegmentControlView(),
        addVerticalHeight(25.0),
        paddingLabel("DATE OF BIRTH*"),
        textField(
          textController: controller.dobController,
          isReadOnly: true,
          hintText: "DD/MM/YYYY",
          textInputType: TextInputType.datetime,
          errorText: 'Date of Birth is required.',
          validate: controller.validate['dob'],
          onTapAction: () {
            controller.selectDate();
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 15.0),
          child: label(
            "CORPORATE EMAIL ADDRESS*",
            textAlign: TextAlign.left,
            fontSize: MediumFontSize,
          ),
        ),
        textField(
          textController: controller.emailController,
          focusNode: controller.emailFocusNode,
          hintText: 'Corporate E-mail (required)',
          errorText: 'Corporate E-mail',
          validate: controller.validate['email'],
          onChanged: (value) {
            controller.updateProfileEmailValidation();
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 15.0),
          child: label(
            "PRIMARY CONTACT NUMBER*",
            textAlign: TextAlign.left,
            fontSize: MediumFontSize,
          ),
        ),
        textField(
          textController: controller.contactController,
          keyboardInputType: InputTypeEnum.numeric,
          textInputType: TextInputType.number,
          hintText: 'Phone Number (required)',
          errorText: 'Phone Number (required)',
          validate: controller.validate['contact'],
          onChanged: (value) {
            controller.updateProfileContactValidation();
          },
        ),
      ],
    );
  }

  //GENDER SEGMENT CONTROL
  Widget _genderSegmentControlView() {
    return Container(
      width: double.infinity,
      child: MaterialSegmentedControl(
        children: controller.genderType,
        selectionIndex: controller.genderSelection,
        borderColor: Style.MyColors.themeColor,
        selectedColor: Style.MyColors.themeColor,
        unselectedColor: Colors.white,
        borderRadius: 8.0,
        onSegmentChosen: (index) {
          controller.setGenderSegmentState(index);
        },
      ),
    );
  }

  //CONTINUE BUTTON
  Widget _continueButtonUI() {
    return Center(
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: button(
            'Continue',
            () => controller.submit(),
            isRounded: true,
          ),
        ),
      ),
    );
  }
}
