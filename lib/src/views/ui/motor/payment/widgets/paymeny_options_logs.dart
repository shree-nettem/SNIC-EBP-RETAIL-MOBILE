


import 'package:ebpv2/src/utilities/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class PaymentOptionsLogo extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            Images.visa,

          ),
          SvgPicture.asset(
            Images.master_card,

          ),
          SvgPicture.asset(
            Images.amex,
          ),

          SvgPicture.asset(
            Images.benefit,

          ),
          SvgPicture.asset(
            Images.paypal,

          ),
        ],
      ),
    );
  }
}
