import '../../../../../utilities/colors.dart' as Style;
import '../../../../../utilities/ui_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import 'dependent_profile_controller.dart';

class AddNewDependentScreen extends StatelessWidget {
  static final pageId = "/addNewDependentScreen";
  final DependentProfileXController controller =
      Get.put(DependentProfileXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      appBar: appBar("Add New Dependent"),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return addNewDependentUI();
        },
      ),
    );
  }

  Widget addNewDependentUI() {
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
              AddDependentImageWidget(dependentController: controller),
              addVerticalHeight(10.0),
              DependentProfileFormWidget(dependentController: controller),
              DependentProfileFormBottomWidget(dependentController: controller),
              SaveDocumentsWidget(dependentController: controller),
              _continueButtonView(),
            ],
          ),
        ),
      ),
    );
  }

  //CONTINUE BUTTON
  Widget _continueButtonView() {
    return Center(
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
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
}

//ADD DEPENDENT IMAGE
class AddDependentImageWidget extends StatelessWidget {
  final DependentProfileXController dependentController;

  AddDependentImageWidget({this.dependentController});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: new Container(
        child: InkWell(
          onTap: () {
            _showPicker();
          },
          child: CircleAvatar(
            radius: 70,
            child: dependentController.image != null
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
                        image: FileImage(dependentController.image),
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
                    dependentController.getImageGallery();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: label("camera".tr, fontSize: MediumFontSize),
                  onTap: () {
                    dependentController.getImageCamera();
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

//ADD DEPENDENT FORM 1st HALF
class DependentProfileFormWidget extends StatelessWidget {
  final DependentProfileXController dependentController;

  DependentProfileFormWidget({this.dependentController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paddingLabel("NAME*"),
        textField(
          textController: dependentController.firstNameController,
          focusNode: dependentController.firstNameFocusNode,
          keyboardInputType: InputTypeEnum.alpha,
          textInputType: TextInputType.name,
          hintText: 'First Name',
          errorText: 'First Name is required',
          validate: dependentController.validate['first_name'],
          onChanged: (value) {
            dependentController.updateProfileFNameValidation();
          },
        ),
        textField(
          textController: dependentController.middleNameController,
          focusNode: dependentController.middleNameFocusNode,
          hintText: 'Middle Name',
          keyboardInputType: InputTypeEnum.alpha,
          textInputType: TextInputType.name,
          onChanged: (value) {},
        ),
        textField(
          textController: dependentController.lastNameController,
          focusNode: dependentController.lastNameFocusNode,
          hintText: 'Last Name',
          keyboardInputType: InputTypeEnum.alpha,
          textInputType: TextInputType.name,
          errorText: 'Last Name is required',
          validate: dependentController.validate['last_name'],
          onChanged: (value) {
            dependentController.updateProfileLNameValidation();
          },
        ),
        addVerticalHeight(10.0),
        paddingLabel("RELATIONSHIP*"),
        addVerticalHeight(10.0),
        _genderRelationControlView(),
        addVerticalHeight(20.0),
        paddingLabel("NATIONALITY*"),
        _countriesDDView(),
        addVerticalHeight(20.0),
        paddingLabel("ID TYPE*"),
        addVerticalHeight(10.0),
        _segmentIdTypeControlView(),
        addVerticalHeight(20.0),
        paddingLabel("ID NUMBER*"),
        Visibility(
          visible: dependentController.idTypeVisible,
          child: textField(
            textController: dependentController.idNumberController,
            focusNode: dependentController.idNumberFocusNode,
            keyboardInputType: InputTypeEnum.numeric,
            textInputType: TextInputType.number,
            hintText: 'ID Number (required)',
            errorText: dependentController.cprErrorMessage,
            validate: dependentController.validate['id_number'],
            onChanged: (value) {
              if (dependentController.idTypeVisible) {
                dependentController.updateIdTypeValidation();
              }
            },
          ),
        ),
        Visibility(
          visible: !dependentController.idTypeVisible,
          child: textField(
            textController: dependentController.idNumberController,
            focusNode: dependentController.idNumberFocusNode,
            keyboardInputType: InputTypeEnum.alphanumeric,
            textInputType: TextInputType.text,
            hintText: 'PPT# ID Number (required)',
            errorText: dependentController.passportErrorMessage,
            validate: dependentController.validate['id_number'],
            onChanged: (value) {
              if (!dependentController.idTypeVisible) {
                dependentController.updateIdTypeValidation();
              }
            },
          ),
        ),
        addVerticalHeight(10.0),
        paddingLabel("PASSPORT ID"),
        textField(
          textController: dependentController.passportIdController,
          focusNode: dependentController.passportIdFocusNode,
          keyboardInputType: InputTypeEnum.numeric,
          textInputType: TextInputType.text,
          hintText: 'PASSPORT ID',
        ),
      ],
    );
  }

  //GENDER SEGMENT CONTROL
  Widget _genderRelationControlView() {
    return Container(
      width: double.infinity,
      child: MaterialSegmentedControl(
        children: dependentController.relationshipType,
        selectionIndex: dependentController.relationshipSelection,
        borderColor: Style.MyColors.themeColor,
        selectedColor: Style.MyColors.themeColor,
        unselectedColor: Colors.white,
        borderRadius: 8.0,
        onSegmentChosen: (index) {
          dependentController.setRelationShipSegmentState(index);
        },
      ),
    );
  }

  // SEGMENT BUTTON UI
  Widget _segmentIdTypeControlView() {
    return Container(
      width: double.infinity,
      child: MaterialSegmentedControl(
        children: dependentController.identityType,
        selectionIndex: dependentController.currentSelectionIdType,
        borderColor: Style.MyColors.themeColor,
        selectedColor: Style.MyColors.themeColor,
        unselectedColor: Colors.white,
        borderRadius: 8.0,
        onSegmentChosen: (index) {
          dependentController.setIdTypeSegmentState(index);
        },
      ),
    );
  }

  // LIST OF COUNTRIES IN DROPDOWN
  Widget _countriesDDView() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0),
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
        items: dependentController.countries
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
        value: dependentController.selectedCountry,
        onChanged: (value) {
          dependentController.onNationalitySelection(value);
        },
      ),
    );
  }
}

//ADD DEPENDENT 2nd HALF
class DependentProfileFormBottomWidget extends StatelessWidget {
  final DependentProfileXController dependentController;

  DependentProfileFormBottomWidget({this.dependentController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paddingLabel("DATE OF BIRTH*"),
        textField(
          textController: dependentController.dobController,
          focusNode: dependentController.dobFocusNode,
          isReadOnly: true,
          hintText: "DD/MM/YYYY",
          textInputType: TextInputType.datetime,
          errorText: 'Date of Birth is required.',
          validate: dependentController.validate['dob'],
          onTapAction: () {
            dependentController.selectDate();
          },
        ),
        addVerticalHeight(10.0),
        paddingLabel("EMAIL ADDRESS"),
        textField(
          textController: dependentController.emailController,
          focusNode: dependentController.emailFocusNode,
          hintText: ' E-mail ',
          errorText: 'E-mail',
        ),
        addVerticalHeight(10.0),
        paddingLabel("CONTACT NUMBER"),
        textField(
          textController: dependentController.contactController,
          focusNode: dependentController.contactFocusNode,
          keyboardInputType: InputTypeEnum.numeric,
          textInputType: TextInputType.number,
          hintText: 'Phone Number',
          errorText: 'Phone Number',
        ),
        addVerticalHeight(20.0),
        paddingLabel("IDENTITY ID EXPIRATION DATE"),
        textField(
          textController: dependentController.iedController,
          focusNode: dependentController.iedFocusNode,
          isReadOnly: true,
          hintText: "DD/MM/YYYY",
          textInputType: TextInputType.datetime,
          onTapAction: () {
            dependentController.selectIEDate();
          },
        ),
        addVerticalHeight(20.0),
        paddingLabel("DRIVING LICENSE EXPIRATION DATE"),
        textField(
          textController: dependentController.dledController,
          focusNode: dependentController.dledFocusNode,
          isReadOnly: true,
          hintText: "DD/MM/YYYY",
          textInputType: TextInputType.datetime,
          onTapAction: () {
            dependentController.selectDLEDDate();
          },
        ),
      ],
    );
  }
}

class SaveDocumentsWidget extends StatelessWidget {
  final DependentProfileXController dependentController;

  SaveDocumentsWidget({this.dependentController});

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
              SizedBox(
                width: 100,
                child: button(
                  'Upload',
                  () => _showPicker(2),
                  isRounded: true,
                ),
              ),
            ],
          ),
          addVerticalHeight(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              paddingLabel("Passport"),
              SizedBox(
                width: 100,
                child: button(
                  'Upload',
                  () => _showPicker(3),
                  isRounded: true,
                ),
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
                    dependentController.getImageGallery();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: label("camera".tr, fontSize: MediumFontSize),
                  onTap: () {
                    dependentController.getImageCamera();
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
