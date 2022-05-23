import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool value;

  const CustomCheckBox({@required this.text, this.onTap, this.value = false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              height: 15.0,
              width: 15.0,
              decoration: new BoxDecoration(
                color: value ? MyColors.PrimaryColor : Colors.white,
                border:
                    new Border.all(width: 1.0, color: MyColors.PrimaryColor),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(4.0)),
              ),
            ),
            if (text != "" && text != null)
              Flexible(
                child: Container(
                  margin: new EdgeInsets.only(left: 10.0, right: 10),
                  child: new Text(
                    text,
                    maxLines: 2,
                    style: TextStyle(
                        color: MyColors.PrimaryColor,
                        fontSize: 12,
                        fontFamily: Constants.FONT_SF_UI_TEXT_REGULAR,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
