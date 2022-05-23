import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/group_life/beneficiary/add_binificiary_controller.dart';
import 'package:ebpv2/src/views/ui/group_life/beneficiary/beneficiary_controller.dart';
import 'package:ebpv2/src/views/ui/group_life/beneficiary/widgets/add_beneficiary_form.dart';
import 'package:ebpv2/src/views/ui/group_life/models/get_benificiaries_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeneficiaryScreen extends StatelessWidget {
  BeneficiaryScreen({Key key}) : super(key: key);

  final BeneficiaryXController _controller = Get.put(BeneficiaryXController());
  final AddBinificiaryXController _benificiaryController =
      Get.put(AddBinificiaryXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (cntrlr) {
          return _controller.hideAddBenificiaryScreen.value
              ? ListView.builder(
                  itemCount: _controller.totalBenificiaries.length + 1,
                  itemBuilder: (context, index) {
                    return index == _controller.totalBenificiaries.length
                        ? benificiaryRemainingBody(
                            context, _controller.totalBenificiaries.length)
                        : _cardViewUI(
                            _controller.totalBenificiaries[index], index);
                  })
              : AddBinificiaryForm();
        });
  }

  Widget benificiaryRemainingBody(BuildContext context, int totalLength) {
    return Column(
      children: [
        if (!_controller.checkTotalPercentageIsequal100())
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        if (totalLength == 0 && _controller.totalBenificiaries.length != 0)
          CustomLabel(
            title: 'atleastOneBenificiary'.tr,
            color: MyColors.RedColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        if (!_controller.checkTotalPercentageIsequal100())
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        if (!_controller.checkTotalPercentageIsequal100())
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: CustomLabel(
              title:
                  "${'currentPercentage'.tr}${_controller.getCurrentPercentage()}%, ${'itMustBeHundred'.tr}",
              color: MyColors.RedColor,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              maxLines: 2,
            ),
          ),
        if (_controller.isSaveOn.value)
          CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        if (_controller.isSaveOn.value)
          if (_controller.checkTotalPercentageIsequal100())
            CustomLabel(
              title: 'changesMade'.tr,
              color: MyColors.greeen,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT * 2),
        _buildAddDepenndentButton(context, "addBenificiary".tr, onclick: () {
          Get.find<AddBinificiaryXController>()
              .setBenificiaryTextfields(null, null);
          _controller.changeBenificiaryUI();
        }),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        _buildAddDepenndentButton(context, "makeEqualShare".tr, onclick: () {
          if (_controller.totalBenificiaries.isNotEmpty) {
            print(_controller.totalBenificiaries);
            _controller.shareEqualPercetages();
          }
        }),
        CustomSpacer(value: Dimensions.PADDING_SIZE_DEFAULT),
        // if (_controller.isSaveOn.value)
        _buildAddDepenndentButton(context, "save".tr,
            btnColor: _controller.isSaveOn.value
                ? _controller.checkTotalPercentageIsequal100()
                    ? MyColors.PrimaryColor
                    : MyColors.DisabledColor
                : MyColors.DisabledColor,
            isActive: _controller.isSaveOn.value, onclick: () {
          if (_controller.isSaveOn.value) if (_controller
              .checkTotalPercentageIsequal100()) {
            if (_controller.totalBenificiaries.length > 0) {
              _controller.saveBenificiaries();
            }
          } else {
            _controller.togglePercentageText(false);
          }
        }),
        CustomSpacer(
          value: Dimensions.PADDING_SIZE_DEFAULT * 2,
        ),
      ],
    );
  }

  Widget _cardViewUI(LifeBenificiaries benificiaries, int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 5, 32, 5),
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: MyColors.GrayColor,
            blurRadius: 22.0,
            offset: Offset(
              0.0,
              6.0,
            ),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.find<AddBinificiaryXController>()
              .setBenificiaryTextfields(benificiaries, index);
          _controller.changeBenificiaryUI();
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 2,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 17.5, 15, 17.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomLabel(
                      title: benificiaries.beneficiaryName.tr,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ],
                ),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLabel(
                      title:
                          "${(DateTime.now().difference(benificiaries.beneficiaryDateOfBirth).inDays / 365).floor()} ${"yearsOld".tr}",
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    CustomLabel(
                      title:
                          "${benificiaries.beneficiaryPercentage.toStringAsFixed(1)}%"
                              .tr,
                      color: MyColors.VerticalDividerColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ],
                ),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT / 2,
                ),
                CustomLabel(
                  title: (benificiaries.guardianName == null ||
                          benificiaries.guardianName == '')
                      ? "${"no".tr} ${"gaurdian".tr}"
                      : "${"gaurdian".tr}: ${benificiaries.guardianName}".tr,
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* ADD NEW DEPENDET BUTTON */
  Widget _buildAddDepenndentButton(BuildContext context, String title,
      {Function onclick,
      Color btnColor = MyColors.PrimaryColor,
      bool isActive = true}) {
    return Center(
      child: CustomButton(
        title: title,
        isActive: isActive,
        bgColor: btnColor,
        width: MediaQuery.of(context).size.width / 2 + 50,
        fontSize: 12,
        paddingWidth: 10,
        height: 40,
        buttonAction: onclick,
      ),
    );
  }
}
