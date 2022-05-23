import 'package:flutter/material.dart';

import 'package:get/get.dart';

void showAnimatedDialog(Widget dialog, {bool dismissible = true}) {
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: dismissible,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    context: Get.context,
    pageBuilder: (context, animation1, animation2) => dialog,
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}
