import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/controllers/ghady_retirement_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentValueHistoryDropDownView extends StatelessWidget {
  CurrentValueHistoryDropDownView({Key key}) : super(key: key);
  final GhadyRetirementDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(
          title: 'currentValueHistory'.tr,
          fontSize: 18,
          fontFamily: Constants.FONT_PROXIMA_NOVA,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(207, 215, 219, 1),
                Color.fromRGBO(255, 255, 255, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CurrentValueHistoryDropDown(
            label: controller.historyOverAllModel[0],
            options: controller.historyOverAllModel,
            onChanged: (HistoryOverAllModel val) {
              return controller.updateHistoryValue(val.key);
            },
          ),
        ),
      ],
    );
  }
}

class HistoryOverAllModel {
  HistoryOverAllModel(this.key, this.valueName);

  final int key;
  final String valueName;
}

class CurrentValueHistoryDropDown extends StatelessWidget {
  final HistoryOverAllModel label;
  final List<HistoryOverAllModel> options;
  final isIgnored;
  final HistoryOverAllModel Function(HistoryOverAllModel val) onChanged;
  const CurrentValueHistoryDropDown(
      {Key key,
      this.label,
      this.options,
      this.onChanged,
      this.isIgnored = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isIgnored,
      child: Container(
        child: DropdownButtonFormField(
          isDense: false,
          itemHeight: 56,
          icon: Icon(
            Icons.arrow_drop_down_sharp,
            size: 20,
          ),
          hint: CustomLabel(
            title: "Select",
            fontSize: 14,
          ),
          style: TextStyle(
              fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
              fontSize: 12,
              color: MyColors.PrimaryColor),
          iconEnabledColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          selectedItemBuilder: (BuildContext context) {
            return options.map((HistoryOverAllModel val) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      // height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                      child: Text(
                        val.valueName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                            fontSize: 12,
                            color: MyColors.PrimaryColor),
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
          isExpanded: true,
          value: label,
          items: options.map((HistoryOverAllModel value) {
            return DropdownMenuItem(
              value: value,
              child: Container(
                height: 30,
                child: Text(
                  value.valueName,
                  style: TextStyle(
                      fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                      fontSize: 12,
                      color: MyColors.PrimaryColor),
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            onChanged(value);
          },
        ),
      ),
    );
  }
}
