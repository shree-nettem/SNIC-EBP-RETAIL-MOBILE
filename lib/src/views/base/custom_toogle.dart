import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';

class CustomToggle extends StatelessWidget {
  final List<String> totalItems;
  final Function onTap;
  final List<bool> isStatusSelected;
  final bool isSelected;

  const CustomToggle(
      {Key key,
      this.onTap,
      this.isStatusSelected,
      this.totalItems,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => ToggleButtons(
                constraints: BoxConstraints.expand(
                    width: (constraints.maxWidth - 4) / totalItems.length),
                children: List.from(totalItems.map(
                  (name) => Text(
                    name,
                    textAlign: TextAlign.center,
                  ),
                )),
                borderRadius: BorderRadius.circular(10.0),
                borderColor: MyColors.Border,
                borderWidth: 1,
                textStyle: TextStyle(color: MyColors.Border),
                focusColor: Colors.white,
                isSelected: isStatusSelected,
                fillColor: MyColors.VerticalDividerColor,
                selectedColor: Colors.white,
                disabledColor: Colors.white,
                onPressed: onTap,
              ),
            ),
          ),
        ),
        Visibility(
          visible: isSelected,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 4),
            child: CustomLabel(
              title: "Please select relationship type",
              color: MyColors.red,
            ),
          ),
        )
      ],
    );
  }
}
