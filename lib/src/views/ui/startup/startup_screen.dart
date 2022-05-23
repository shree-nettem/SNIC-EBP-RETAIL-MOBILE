import 'package:ebpv2/src/utilities/app_helper.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/views/ui/startup/startup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class StartUpScreen extends StatelessWidget {
  final StartUpController controller = Get.put(StartUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        Images.splash,
        fit: BoxFit.fill,
        height: Get.height,
        animate: true,
        onLoaded: (composition) {
          controller.animationController
            ..duration = composition.duration
            ..forward().whenComplete(
              () {
                AppHelper.landingScreenDetails().then(
                  (pageRouteName) {
                    Get.offAndToNamed(pageRouteName);
                  },
                );
              },
            );
        },
      ),
    );
  }
}
