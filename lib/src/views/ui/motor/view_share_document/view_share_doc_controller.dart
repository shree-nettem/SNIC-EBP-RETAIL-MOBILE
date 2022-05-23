


import 'dart:io';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ViewShareDocController extends GetxController{
  Future<void> shareDocument(File file) async {
    try {
      await Share.shareFiles(
        [file.path],
        mimeTypes: ["pdf/pdf"],
      );
    } catch (e) {
      print(e.toString());
    }
  }

}