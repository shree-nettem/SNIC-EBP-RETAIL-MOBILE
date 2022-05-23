import 'dart:io';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewDocumentXController extends GetxController {
  String filePath1;
  String filePath2;
  String passport;
  String cpr;

  @override
  void onInit() {
    if (Get.arguments != null) {
      filePath1 = Get.arguments["filePath1"] ?? "";
      filePath2 = Get.arguments["filePath2"] ?? "";
    }

    // setFiles();
    super.onInit();
  }

  // void setFiles() {
  //   passport = "http://20.203.8.34/Files/Documents/$filePath1";
  //   cpr = "http://20.203.8.34/Files/Documents/$filePath2";

  //   debugPrint(passport);
  //   update();
  // }

  void downloadImage() async {
    if (filePath1 != "")
      var result = await DioClient().downloadFile(
          "http://20.203.8.34/Files/Documents/$filePath1",
          imgName: "CPRfront",
          needLoadingUI: false);
    if (filePath2 != "")
      var result2 = await DioClient().downloadFile(
          "http://20.203.8.34/Files/Documents/$filePath2",
          imgName: "CPRback");
  }

  void sharingData() async {
    DioClient().showLoading();
    var result = await DioClient().downloadTempFile(
        "http://20.203.8.34/Files/Documents/$filePath1",
        imgName: "CPRfront",
        needLoadingUI: false);
    var result2 = await DioClient().downloadTempFile(
        "http://20.203.8.34/Files/Documents/$filePath2",
        imgName: "CPRback",
        needLoadingUI: false);
    try {
      DioClient().hideLoading();
      await Share.shareFiles(
        [
          if (filePath1 != "" && result != null) result.toString(),
          if (filePath2 != "" && result2 != null) result2.toString()
        ],
        mimeTypes: ["image/png"],
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
