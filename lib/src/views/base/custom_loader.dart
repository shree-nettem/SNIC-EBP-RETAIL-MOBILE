import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  final bool showLongWaitingMessage;
  final String tittle, description;

  const CustomLoader(
      {this.showLongWaitingMessage = false,
      this.tittle = MyString.pleaseWait,
      this.description = ""});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: showLongWaitingMessage ? true : false,
            child: CustomLabel(
              title: tittle,
              fontFamily: Constants.FONT_PROXIMA_NOVA,
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.0),
          SpinKitRing(
            color: MyColors.LoaderColor,
            size: 40.0,
            lineWidth: 5,
          ),
          SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Visibility(
              visible: showLongWaitingMessage ? true : false,
              child: CustomLabel(
                title: description,
                color: Colors.white,
                fontFamily: Constants.FONT_PROXIMA_NOVA,
                fontSize: 16,
                textAlign: TextAlign.center,
                maxLines: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
