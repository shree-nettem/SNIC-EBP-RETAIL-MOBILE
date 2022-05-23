import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BenifitPaymentView extends StatelessWidget {
  String url;
  final Function(int) paymentStatus;
  BenifitPaymentView({
    this.url,
    this.paymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        child: WebView(
          initialUrl: url,
          onPageStarted: (val) {
            if (val.contains('BenefitErrorResponse')) {
              paymentStatus(400);
            } else if (val.contains('paymentcancel')) {
              List<String> trasnsactoionId = val.split("paymentid=");
              paymentStatus(int.parse(trasnsactoionId[1]));
            } else if (val.contains('PaymentTransactionId')) {
              List<String> trasnsactoionId = val.split("PaymentTransactionId=");
              paymentStatus(int.parse(trasnsactoionId[1]));
            } /*else if (val.contains('Logged-Out')) {
            Get.back(); // Close current window
          }*/
          },
          onProgress: (val) {
            print('progress $val');
          },
          onPageFinished: (val) {},
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
