import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/date_time_extesion_helper.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/medical_ecard/motor_ecard_buffer_model.dart';
import 'package:ebpv2/src/views/ui/medical_ecard/motor_ecards_model.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share_plus/share_plus.dart';

import 'medicalEcardsModel.dart';

class MotorEcardViewXController extends GetxController {
  final AutoScrollController scrollController = new AutoScrollController();
  int pageNo = 0;
  String token;
  String companyID;
  String userID;

  bool isCardFrontSide = true;
  RxBool isDownloadingInitialMotorCards = false.obs;
  RxList<PdfPageImage> frontImages = RxList<PdfPageImage>();
  List<PdfPageImage> backImages = []; //scroll to previous plan
  void scrollToPreviousPage() {
    if (pageNo != 0) {
      this.pageNo = pageNo - 1;
      scrollController.scrollToIndex(pageNo,
          preferPosition: AutoScrollPosition.middle);
      update();
    }
  }

//scroll to next plan
  void scrollToNextPage() {
    if (pageNo >= 0 && pageNo < frontImages.length && frontImages.length > 1) {
      this.pageNo = pageNo + 1;
      scrollController.scrollToIndex(pageNo,
          preferPosition: AutoScrollPosition.middle);
      update();
    }
  }

  @override
  void onInit() {
    getToken();
    super.onInit();
  }

// coverting pdf files into images
  getImageFromPDF(Uint8List data) async {
    final document = await PdfDocument.openData(data);

    try {
      final pageBack = await document.getPage(2);
      PdfPageImage back =
          await pageBack.render(width: pageBack.width, height: pageBack.height);
      backImages.add(back);
      await pageBack.close();

      final page = await document.getPage(1);
      PdfPageImage front =
          await page.render(width: page.width, height: page.height);
      frontImages.add(front);
      await page.close();
    } catch (e) {}

    // return pageImage;
  }

  toggleCards({int currentIndex = 0}) {
    print(currentIndex);
    pageNo = currentIndex;
    if (isCardFrontSide) {
      isCardFrontSide = false;
    } else {
      isCardFrontSide = true;
    }
    // update();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    userID = await _sharedPreferencesHelper.getCustomerId;
    var getCompanies = await _sharedPreferencesHelper.getCompanyId;
    List obj = json.decode(getCompanies);
    try {
      var company =
          obj.firstWhere((element) => element["Name"] == "Global ITs");
      companyID = company["Id"].toString();
    } catch (e) {
      if (obj.length > 0) companyID = obj.first["Id"].toString();
    }

    getMotorCardsBufferData();
    // getMotorCards();
  }

// savig files in temp memory
  Future<File> savingInTemp() async {
    File file;

    Directory loc = await getTemporaryDirectory();
    String fullPath = '${loc.path.toString()}/eCard${UniqueKey()}.png';
    file = File(fullPath);
    await file.writeAsBytes(
        isCardFrontSide ? frontImages[pageNo].bytes : backImages[pageNo].bytes);
    return file;
  }

// sharing data across all apps
  sharingData() async {
    savingInTemp().then((value) async {
      try {
        await Share.shareFiles(
          [value.path],
          mimeTypes: ["image/png"],
        );
      } catch (e) {
        print(e.toString());
      }
    });
  }

// download image locally
  void downloadImage() async {
    final result = await ImageGallerySaver.saveImage(
        isCardFrontSide ? frontImages[pageNo].bytes : backImages[pageNo].bytes,
        quality: 60,
        name: "motorEcard$pageNo");
    errorMessage("fileDownloaded".tr);
  }

// gettig motor ecard from backend
  void getMotorCardsBufferData() async {
    isDownloadingInitialMotorCards.value = true;
    Result result =
        await DioClient().get('Motor/GetActiveCards', token, isLoading: false);

    if (result is SuccessState) {
      var jsonData = MotorEcardBufferDataModel.fromJson(result.value);
      if (jsonData is MotorEcardBufferDataModel) {
        List<String> filteredData =
            jsonData.result.map((e) => e.buffer).toList().take(7).toList();
        recurringAllRecords(filteredData);
        update();
      }
    } else if (result is ErrorState) {
      // Get.back();
      errorMessage(result.msg.toString());
    }
  }

// saving all files in local bject
  recurringAllRecords(List<String> stringData) async {
    stringData.forEach((element) {
      saveFileInnTemp(element);
    });
    isDownloadingInitialMotorCards.value = false;
    update();
  }

//saving files i temp memory
  saveFileInnTemp(String buffer) async {
    Uint8List bytes = base64.decode(buffer);
    getImageFromPDF(bytes);
  }
}
