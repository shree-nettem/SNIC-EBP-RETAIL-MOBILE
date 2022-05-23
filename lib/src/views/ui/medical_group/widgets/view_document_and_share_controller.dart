import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';

class ViewDocumentAndShareXController extends GetxController {
  String endPointString = '';
  String middlePointString = 'Medical/GetTravelCertificate?';
  String fullPathUrl = '';
  String viewTitle = "travelCertificate".tr;
  final tt = DioClient.devBaseURL;
  String fileType = 'pdf';

  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

  // PDFDocument pdfDocument;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["fullPathUrl"] == null) {
        endPointString = Get.arguments['endPoint'] ?? '';
        fileType = endPointString.split(".").last;
        print("fileType is $fileType");
      } else {
        fullPathUrl = Get.arguments['fullPathUrl'] ?? '';
        fileType = fullPathUrl.split(".").last;
        print("fileType is $fileType");
      }

      viewTitle = Get.arguments["viewTitle"] ?? 'travelCertificate'.tr;
    }
  }

  String getDocumentUri() {
    print(fullPathUrl != ''
        ? fullPathUrl
        : DioClient.devBaseURL + middlePointString + endPointString);
    return fullPathUrl != ''
        ? fullPathUrl
        : DioClient.devBaseURL + middlePointString + endPointString;
  }

  void sharingData() async {
    if (fileType != "jpg" && fileType != "jpeg" && fileType != "png") {
      fileType = "pdf";
    }

    var result = await DioClient().downloadTempFile(getDocumentUri(),
        imageFormat: fileType != '' ? fileType : 'pdf',
        imgName: 'travelInsurance');
    try {
      await Share.shareFiles(
        [result.toString()],
        mimeTypes: ["pdf/pdf"],
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
