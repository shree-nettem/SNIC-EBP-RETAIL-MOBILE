import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:flutter/cupertino.dart';

class CustomSpacer extends StatelessWidget {
  final double value;
  final bool isHeight;

  CustomSpacer(
      {this.value = Dimensions.PADDING_SIZE_DEFAULT, this.isHeight = true});

  @override
  Widget build(BuildContext context) {
    return isHeight
        ? SizedBox(
            height: value,
          )
        : SizedBox(
            width: value,
          );
  }
}
