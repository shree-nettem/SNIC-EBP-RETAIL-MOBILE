import '../../../utilities/colors.dart' as Style;
import '../../../utilities/ui_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import 'employee_profile_wizard_controller.dart';

class EmployeeProfileWizardTwoScreen extends StatelessWidget {
  static final pageId = "/employeeProfileWizardTwoScreen";
  final EmployeeProfileWizardTwoXController controller =
      Get.put(EmployeeProfileWizardTwoXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return employeeProfileWizardTwoUI();
        },
      ),
    );
  }

  //EMPLOYEE PROFILE UI
  Widget employeeProfileWizardTwoUI() {
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
              _employeeProfileFormUI(),
              addVerticalHeight(5.0),
              // _continueButtonUI(),
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

  //EMPLOYEE PROFILE FORM
  Widget _employeeProfileFormUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paddingLabel("NATIONALITY*"),
        addVerticalHeight(10.0),
        _countriesDDView(),
        addVerticalHeight(20.0),
        paddingLabel("ID TYPE*"),
        addVerticalHeight(10.0),
        _segmentIdTypeButtonUI(),
        addVerticalHeight(20.0),
        paddingLabel("ID NUMBER*"),
        Visibility(
          visible: controller.idTypeVisible,
          child: textField(
            textController: controller.idNumberController,
            keyboardInputType: InputTypeEnum.numeric,
            textInputType: TextInputType.number,
            hintText: 'ID Number (required)',
            errorText: controller.cprErrorMessage,
            validate: controller.validateWizardTwo['id_number'],
            onChanged: (value) {
              if (controller.idTypeVisible) {
                controller.updateIdTypeValidation();
              }
            },
          ),
        ),
        Visibility(
          visible: !controller.idTypeVisible,
          child: textField(
            textController: controller.idNumberController,
            keyboardInputType: InputTypeEnum.alphanumeric,
            textInputType: TextInputType.text,
            hintText: 'PPT# ID Number (required)',
            errorText: controller.passportErrorMessage,
            validate: controller.validateWizardTwo['id_number'],
            onChanged: (value) {
              if (!controller.idTypeVisible) {
                controller.updateIdTypeValidation();
              }
            },
          ),
        ),
        addVerticalHeight(10.0),
        paddingLabel("ADDRESS*"),
        textField(
          textController: controller.addressController,
          keyboardInputType: InputTypeEnum.alphanumeric,
          textInputType: TextInputType.text,
          hintText: 'Address (required)',
          errorText: "Address is required",
          validate: controller.validateWizardTwo['address'],
          onChanged: (value) {
            controller.updateAddressValidation();
          },
        ),
        addVerticalHeight(10.0),
        paddingLabel("MARITAL STATUS*"),
        addVerticalHeight(10.0),
        _segmentMaritalButtonUI(),
        addVerticalHeight(20.0),
        paddingLabel("CHILDREN*"),
        addVerticalHeight(10.0),
        _segmentChildrenButtonUI(),
        addVerticalHeight(10.0),
        _subscribeSwitch(),
        addVerticalHeight(10.0),
        _continueButtonUI(),
      ],
    );
  }

  // LIST OF COUNTRIES IN DROPDOWN
  Widget _countriesDDView() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: DropdownButtonFormField<String>(
        focusColor: Colors.white70,
        decoration: InputDecoration(
          border: OutlineBorderStyleBorder,
          enabledBorder: OutlineEnabledBorderStyle,
          focusedBorder: OutlineFocusedBorderStyle,
          filled: true,
        ),
        hint: label(
          "Nationality (required)",
          fontSize: MediumFontSize,
        ),
        isExpanded: true,
        iconEnabledColor: Colors.black,
        validator: (value) => value == null ? 'Nationality is required' : null,
        items: controller.countries
            .map(
              (country) => DropdownMenuItem(
                value: country,
                child: label(
                  country,
                  fontSize: MediumFontSize,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          controller.onNationalitySelection(value);
        },
      ),
    );
  }

  // SEGMENT BUTTON UI
  Widget _segmentIdTypeButtonUI() {
    return Container(
      width: double.infinity,
      child: MaterialSegmentedControl(
        children: controller.identityType,
        selectionIndex: controller.currentSelectionIdType,
        borderColor: Style.MyColors.themeColor,
        selectedColor: Style.MyColors.themeColor,
        unselectedColor: Colors.white,
        borderRadius: 8.0,
        onSegmentChosen: (index) {
          controller.setIdTypeSegmentState(index);
        },
      ),
    );
  }

  Widget _segmentMaritalButtonUI() {
    return Container(
      width: double.infinity,
      child: MaterialSegmentedControl(
        children: controller.maritalType,
        selectionIndex: controller.currentSelectionMaritalType,
        borderColor: Style.MyColors.themeColor,
        selectedColor: Style.MyColors.themeColor,
        unselectedColor: Colors.white,
        borderRadius: 8.0,
        onSegmentChosen: (index) {
          controller.setMaritalTypeSegmentState(index);
        },
      ),
    );
  }

  Widget _segmentChildrenButtonUI() {
    return Container(
      width: double.infinity,
      child: MaterialSegmentedControl(
        children: controller.childrenType,
        selectionIndex: controller.currentSelectionChildren,
        borderColor: Style.MyColors.themeColor,
        selectedColor: Style.MyColors.themeColor,
        unselectedColor: Colors.white,
        borderRadius: 8.0,
        onSegmentChosen: (index) {
          controller.setChildrenSegmentState(index);
        },
      ),
    );
  }

  Widget _subscribeSwitch() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Switch(
            onChanged: controller.toggleSwitch,
            value: controller.isSwitched,
            activeColor: Colors.white70,
            activeTrackColor: Colors.blue,
            inactiveThumbColor: Colors.white70,
            inactiveTrackColor: Colors.grey,
          ),
          Expanded(
            child: label(
              "Subscribe to receive marketing email and updates",
              fontSize: SmallFontSize,
              maxLines: 2,
            ),
          ),
        ],
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
            () => controller.submitWizardTwo(),
            isRounded: true,
          ),
        ),
      ),
    );
  }
}
