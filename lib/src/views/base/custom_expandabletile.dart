import 'package:ebpv2/src/utilities/colors.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'custom_button.dart';
import 'custom_label.dart';

class CustomExpandableTile extends StatelessWidget {
  final GlobalKey<ExpansionTileCardState> expansionCardKey;
  final dynamic classview;
  final String title;
  final String name;
  final String leadindIcon;
  final isButtonVisible;
  final isStatusVisible;
  final isTileDisable;
  final String status;
  final String buttonText;
  final Function onExpansionChanged;
  final Function onButtonClick;

  const CustomExpandableTile(
      {Key key,
      @required this.expansionCardKey,
      @required this.classview,
      this.leadindIcon = '',
      this.isButtonVisible,
      this.isStatusVisible,
      this.isTileDisable = false,
      this.title = '',
      this.name = '',
      this.status = '',
      this.buttonText = '',
      this.onExpansionChanged,
      this.onButtonClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 20, 32, 5),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(25),
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
      child: ExpansionTileCard(
        baseColor: isTileDisable ? MyColors.disableGreyColor : Colors.white,
        borderRadius: BorderRadius.circular(20), // if you need this

        key: expansionCardKey,
        trailing: Visibility(visible: false, child: SizedBox()),
        onExpansionChanged: onExpansionChanged,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  title.isNotEmpty
                      ? Container(
                          width: 26,
                          height: 26,
                          decoration: leadindIcon.isEmpty
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.PrimaryColor, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))
                              : null,
                          child: title.isNotEmpty && leadindIcon.isEmpty
                              ? Center(
                                  child: CustomLabel(
                                    title: title,
                                    color: MyColors.PrimaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    maxLines: 2,
                                  ),
                                )
                              : leadindIcon.isNotEmpty
                                  ? SvgPicture.asset(
                                      leadindIcon,
                                    )
                                  : Container(),
                        )
                      : Container(),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: CustomLabel(
                      title: name,
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isStatusVisible ? true : false,
              child: status == 'Completed'
                  ? statusWidget(MyColors.VerticalDividerColor,
                      widgetText: 'completed'.tr)
                  : status == 'Required'
                      ? statusWidget(MyColors.requiredFieldColor,
                          widgetText: 'required'.tr)
                      : Container(),
            ),
            Visibility(
                visible: isButtonVisible ? true : false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _buildStartButton(onButtonClick ?? () {}),
                ))
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: classview,
          ),
        ],
      ),
    );
  }

//Marks the status of information
  Widget statusWidget(Color widgetColor, {String widgetText = ''}) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            height: 7,
            width: 7,
            color: widgetColor,
          ),
        ),
        SizedBox(width: 3),
        CustomLabel(
          title: widgetText,
          color: widgetColor,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ],
    );
  }

  /* SAVE BUTTON */
  Widget _buildStartButton(Function onButtonnClick) {
    return Center(
      child: CustomButton(
        title: buttonText,
        width: 64,
        fontSize: 12,
        height: 26,
        buttonAction: onButtonnClick,
      ),
    );
  }
}
