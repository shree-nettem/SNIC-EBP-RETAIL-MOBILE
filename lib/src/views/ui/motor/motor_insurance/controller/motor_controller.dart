import 'package:ebpv2/src/services/dio_client.dart' as dio;

import 'package:ebpv2/src/services/result.dart' as res;

import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/motor/model/draft_format.dart';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MotorXController extends GetxController {
  final List<GlobalKey<ExpansionTileCardState>> expansionCardKey = [
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
  ];

  MotorInsuranceDraftFormat draftFormat;

  List<MotorInsuranceDraft> draftProgressStatus;

  List motorCategories = ["Vehicle details", "Select your plan", "Payment"];

  String token;

  @override
  void onInit() {
    // TODO: implement onInit
    draftProgressStatus = [
      new MotorInsuranceDraft(false, 1),
      new MotorInsuranceDraft(false, 0),
      new MotorInsuranceDraft(false, 0),
    ];

    super.onInit();
  }

  onStartButtonClicked({int position, bool isExpanded}) {
    if (isExpanded == null) {
      expansionCardKey[position].currentState.expand();
      draftProgressStatus[position].isExpanded = true;
    } else if (!isExpanded) {
      draftProgressStatus[position].isExpanded = false;
    } else if (isExpanded) {
      draftProgressStatus[position].isExpanded = true;
    }
    update();
  }
}

class MotorInsuranceDraft {
  bool _isExpanded;
  int _status;
  bool isDealerQuotionUploaded;

  //status 0 is considered to be disabled
  //status 1 is considered to be active
  //status 2 is considered to be completed

  MotorInsuranceDraft(this._isExpanded, this._status);

  int get status => _status;

  set status(int value) {
    _status = value;
  }

  bool get isExpanded => _isExpanded;

  set isExpanded(bool value) {
    _isExpanded = value;
  }
}
