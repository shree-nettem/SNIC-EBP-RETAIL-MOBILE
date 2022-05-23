import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferXController extends GetxController {
  final qrKey = GlobalKey();
  File qrfile;
  String referralCode = "";
  int numberOfReferrals = 0;

  @override
  void onInit() {
    super.onInit();
    getReferalData();
  }

  Future<void> getReferalData() async {
    referralCode = await SharedPreferencesHelper().getReferalCode;
    numberOfReferrals = await SharedPreferencesHelper().getNumberOfReferrals;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void shareQRImage() async {
    try {
      RenderRepaintBoundary boundary =
          qrKey.currentContext.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final appDir = await getApplicationDocumentsDirectory();
      var datetime = DateTime.now();
      qrfile = await File('${appDir.path}/$datetime.png').create();
      await qrfile?.writeAsBytes(pngBytes);
      await Share.shareFiles(
        [qrfile.path],
        mimeTypes: ["image/png"],
        text: "",
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
