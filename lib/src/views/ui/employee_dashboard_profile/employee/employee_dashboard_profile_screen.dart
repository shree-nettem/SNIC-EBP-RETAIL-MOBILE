import '../../../../utilities/colors.dart' as Style;
import '../../../../utilities/ui_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import 'employee_dashboard_profile_controller.dart';

class EmployeeDashboardProfileScreen extends StatelessWidget {
  static final pageId = "/employeeDashboardProfileScreen";
  final EmployeeDashboardProfileXController controller =
      Get.put(EmployeeDashboardProfileXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      appBar: appBar("My Profile"),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return employeeDashboardProfileUI();
        },
      ),
    );
  }

  //  EMPLOYEE DASHBOARD PROFILE UI
  Widget employeeDashboardProfileUI() {
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
              _employeeImageUI(),
              addVerticalHeight(20.0),
              _employeeFullNameView(),
              addVerticalHeight(20.0),
              _employeeProfileForm(),
            ],
          ),
        ),
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
            _showPicker(1);
          },
          child: CircleAvatar(
            radius: 70,
            child: controller.profilePic != null
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
                        image: (controller.image != null)
                            ? FileImage(controller.image)
                            : NetworkImage(controller.profilePic),
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

  void _showPicker(n) {
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
                    controller.getImageGallery(n);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: label("camera".tr, fontSize: MediumFontSize),
                  onTap: () {
                    controller.getImageCamera(n);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //FULL EMPLOYEE NAME
  Widget _employeeFullNameView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        label(controller.fullName ?? " ", fontSize: LargeFontSize),
      ],
    );
  }

  Widget _employeeProfileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paddingLabel("NAME*"),
        textField(
          textController: controller.firstNameController,
          focusNode: controller.firstNameFocusNode,
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
          focusNode: controller.middleNameFocusNode,
          keyboardInputType: InputTypeEnum.alpha,
          textInputType: TextInputType.name,
          onChanged: (value) {},
        ),
        textField(
          textController: controller.lastNameController,
          hintText: 'Last Name',
          focusNode: controller.lastNameFocusNode,
          keyboardInputType: InputTypeEnum.alpha,
          textInputType: TextInputType.name,
          errorText: 'Last Name is required',
          validate: controller.validate['last_name'],
          onChanged: (value) {
            controller.updateProfileLNameValidation();
          },
        ),
        addVerticalHeight(10.0),
        paddingLabel("GENDER*"),
        addVerticalHeight(10.0),
        _genderSegmentControlView(),
        addVerticalHeight(20.0),
        paddingLabel("MARITAL STATUS*"),
        addVerticalHeight(10.0),
        _maritalSegmentControlView(),
        addVerticalHeight(20.0),
        paddingLabel("DATE OF BIRTH*"),
        textField(
          textController: controller.dobController,
          isReadOnly: true,
          hintText: "DD/MM/YYYY",
          textInputType: TextInputType.datetime,
          errorText: 'Date of Birth is required.',
          // validate: controller.validate['dob'],
          onTapAction: () {
            controller.selectDate();
          },
        ),
        addVerticalHeight(20.0),
        paddingLabel("CORPORATE EMAIL ADDRESS*"),
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
        addVerticalHeight(20.0),
        paddingLabel("PERSONAL EMAIL ADDRESS"),
        textField(
          textController: controller.personalEmailController,
          focusNode: controller.personalEmailFocusNode,
          hintText: 'Personal E-mail',
          errorText: 'Personal E-mail',
          // validate: controller.validate['email'],
          onChanged: (value) {
            // controller.updateProfileEmailValidation();
          },
        ),
        addVerticalHeight(20.0),
        paddingLabel("PRIMARY CONTACT NUMBER*"),
        textField(
          textController: controller.contactController,
          keyboardInputType: InputTypeEnum.numeric,
          textInputType: TextInputType.number,
          focusNode: controller.primaryContactFocusNode,
          hintText: 'Phone Number (required)',
          errorText: 'Phone Number (required)',
          // validate: controller.validate['contact'],
          onChanged: (value) {
            // controller.updateProfileContactValidation();
          },
        ),
        addVerticalHeight(20.0),
        paddingLabel("SECONDARY CONTACT NUMBER"),
        textField(
          textController: controller.secondaryContactController,
          keyboardInputType: InputTypeEnum.numeric,
          focusNode: controller.secondaryContactFocusNode,
          textInputType: TextInputType.number,
          hintText: 'Secondary Contact Number (required)',
          errorText: 'Secondary Contact Number (required)',
          onChanged: (value) {
            // controller.updateProfileContactValidation();
          },
        ),
        addVerticalHeight(10.0),
        paddingLabel("ADDRESS*"),
        textField(
          textController: controller.addressController,
          keyboardInputType: InputTypeEnum.alphanumeric,
          focusNode: controller.addressFocusNode,
          textInputType: TextInputType.text,
          hintText: 'Address (required)',
          errorText: "Address is required",
          validate: controller.validate['address'],
          onChanged: (value) {
            controller.updateAddressValidation();
          },
        ),
        addVerticalHeight(10.0),
        paddingLabel("MONTHLY INCOME"),
        textField(
          textController: controller.monthlyIncomeController,
          focusNode: controller.incomeFocusNode,
          keyboardInputType: InputTypeEnum.numeric,
          textInputType: TextInputType.text,
          hintText: 'Monthly income in BHD',
          // validate: controller.validateWizardTwo['address'],
          onChanged: (value) {
            // controller.updateAddressValidation();
          },
        ),
        addVerticalHeight(10.0),
        paddingLabel("BANK"),
        _bankDDView(),
        addVerticalHeight(20.0),
        paddingLabel("IBAN"),
        textField(
          textController: controller.ibanController,
          focusNode: controller.ibanFocusNode,
          keyboardInputType: InputTypeEnum.numeric,
          textInputType: TextInputType.text,
          hintText: 'IBAN',
          onChanged: (value) {},
        ),
        addVerticalHeight(10.0),
        paddingLabel("NATIONALITY*"),
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
            focusNode: controller.idNumberFocusNode,
            hintText: 'ID Number (required)',
            errorText: controller.cprErrorMessage,
            validate: controller.validate['id_number'],
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
            focusNode: controller.idNumberFocusNode,
            textInputType: TextInputType.text,
            hintText: 'PPT# ID Number (required)',
            errorText: controller.passportErrorMessage,
            validate: controller.validate['id_number'],
            onChanged: (value) {
              if (!controller.idTypeVisible) {
                controller.updateIdTypeValidation();
              }
            },
          ),
        ),
        addVerticalHeight(10.0),
        paddingLabel("PASSPORT ID"),
        textField(
          textController: controller.passportIdController,
          keyboardInputType: InputTypeEnum.numeric,
          focusNode: controller.passportIdFocusNode,
          textInputType: TextInputType.text,
          hintText: 'PASSPORT ID',
          // validate: controller.validateWizardTwo['address'],
          onChanged: (value) {
            // controller.updateAddressValidation();
          },
        ),
        addVerticalHeight(20.0),
        paddingLabel("IDENTITY ID EXPIRATION DATE"),
        textField(
          textController: controller.iedController,
          focusNode: controller.iedFocusNode,
          isReadOnly: true,
          hintText: "DD/MM/YYYY",
          textInputType: TextInputType.datetime,
          onTapAction: () {
            controller.selectIEDate();
          },
        ),
        addVerticalHeight(20.0),
        paddingLabel("DRIVING LICENSE EXPIRATION DATE"),
        textField(
          textController: controller.dledController,
          isReadOnly: true,
          focusNode: controller.dledFocusNode,
          hintText: "DD/MM/YYYY",
          textInputType: TextInputType.datetime,
          // errorText: 'Date of Birth is required.',
          // validate: controller.validate['dob'],
          onTapAction: () {
            controller.selectDLEDDate();
          },
        ),
        addVerticalHeight(10.0),
        paddingLabel("OCCUPATION"),
        addVerticalHeight(10.0),
        _occupationDDView(),
        addVerticalHeight(10.0),
        _subscribeSwitch(),
        addVerticalHeight(10.0),
        addVerticalHeight(10.0),
        SaveDocumentsWidget(employeeController: controller),
        addVerticalHeight(10.0),
        _saveButtonUI(),
        _dependentWidget(),
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

  //MARITAL SEGMENT CONTROL
  Widget _maritalSegmentControlView() {
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

  // SEGMENT ID BUTTON UI
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
        value: controller.selectedCountry,
        onChanged: (value) {
          controller.onNationalitySelection(value);
        },
      ),
    );
  }

  // LIST OF COUNTRIES IN DROPDOWN
  Widget _occupationDDView() {
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
          "Occupation",
          fontSize: MediumFontSize,
        ),
        isExpanded: true,
        iconEnabledColor: Colors.black,
        items: controller.occupation
            .map(
              (occupation) => DropdownMenuItem(
                value: occupation,
                child: label(
                  occupation,
                  fontSize: MediumFontSize,
                ),
              ),
            )
            .toList(),
        value: controller.selectedOccupation,
        onChanged: (value) {
          controller.onOccupationSelection(value);
        },
      ),
    );
  }

  // LIST OF BANKS IN DROPDOWN
  Widget _bankDDView() {
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
          "BANK",
          fontSize: MediumFontSize,
        ),
        isExpanded: true,
        iconEnabledColor: Colors.black,
        items: controller.banks
            .map(
              (bank) => DropdownMenuItem(
                value: bank,
                child: label(
                  bank,
                  fontSize: MediumFontSize,
                ),
              ),
            )
            .toList(),
        value: controller.selectedBank,
        onChanged: (value) {
          controller.onBankSelection(value);
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

  //SAVE BUTTON
  Widget _saveButtonUI() {
    return Center(
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: button(
            'Save',
            () => controller.submit(),
            isRounded: true,
          ),
        ),
      ),
    );
  }

  //SAVE BUTTON
  Widget _dependentWidget() {
    return Center(
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: button(
            'Dependents',
            () => controller.dependentScreen(),
            isRounded: true,
          ),
        ),
      ),
    );
  }
}

class SaveDocumentsWidget extends StatelessWidget {
  final EmployeeDashboardProfileXController employeeController;

  SaveDocumentsWidget({this.employeeController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              paddingLabel("ID Card"),
              button(
                'Upload',
                () => _showPicker(2),
                isRounded: true,
              ),
            ],
          ),
          addVerticalHeight(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              paddingLabel("Passport"),
              button(
                'Upload',
                () => _showPicker(3),
                isRounded: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPicker(n) {
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
                    employeeController.getImageGallery(n);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: label("camera".tr, fontSize: MediumFontSize),
                  onTap: () {
                    employeeController.getImageCamera(n);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
