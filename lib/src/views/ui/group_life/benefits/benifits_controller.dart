import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/group_life/benefits/benifites_model.dart';
import 'package:get/get.dart';

class BenifitsXController extends GetxController {
  List<String> benifitsIcons = [
    Images.death_by_cause,
    Images.terminal_illness,
    Images.disabbility,
    Images.deaf,
    Images.broken_bone,
    Images.illness_on_bed,
    Images.aeroplane,
    Images.dollar,
    Images.gun
  ];

  List<String> groupTermLife = [
    "Death by any cause",
    "In case of a terminal illness",
    "Permanent total disability",
    "Permanent partial disability",
    "Temporary Total disability",
    "Critical Illness",
    "Repatriation",
    "Accidental Medical Expenses",
    "Passive War & Conventional Terrorism"
  ];

  List<String> additionalBenefits = [
    "Claim Process",
    "Exclusions",
    "Passive War & Conventional Terrorism"
  ];

  List<BenefitsModel> totalBenefits = [];
  List<BenefitsSubSection> totalGroupLifeSections = [];

  List<BenefitsSubSection> totatAdditionalLifeSections = [];
  String title = "Group Term Life";
  String token;

  @override
  void onInit() {
    // getToken();

    super.onInit();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    getBenefits();
  }

  String selectImage(String type) {
    switch (type) {
      case "Death Any Cause":
        return Images.death_by_cause;
        break;
      case "In case of a Terminal Illness":
        return Images.terminal_illness;
        break;
      case "Permanent Total Disability":
        return Images.disabbility;
        break;
      case "Permanent Partial Disability":
        return Images.deaf;
        break;
      case "Temporary Total Disability":
        return Images.broken_bone;
        break;
      case "Critical Illness":
        return Images.illness_on_bed;
        break;
      case "Repatriation":
        return Images.aeroplane;
        break;
      case "Accidental Medical Expenses":
        return Images.dollar;
        break;
      case "Passive War and Conventional Terrorism":
        return Images.gun;
        break;
      default:
        return "NoImage";
    }
  }

  // getting group life terms data from api

  void gettingGroupLifeData(List<BenefitsModel> totalObjects) {
    totalObjects.forEach((element) {
      if (element.subSections.length > 0) if (element.subSections[0].ref
          .contains("LI")) {
        if (element.subSections[0].value.toUpperCase() == "COVERED")
          element.subSections.removeAt(0);
        title = element.title;
        if (element.subSections.length > 3) {
          final elementsLength = element.subSections.length;
          totatAdditionalLifeSections = element.subSections
              .getRange(elementsLength - 3, elementsLength)
              .toList();
          element.subSections.removeRange(elementsLength - 3, elementsLength);
          totalGroupLifeSections = element.subSections;
        }

        print(totalGroupLifeSections.length);
      }
    });
  }

  getBenefits() async {
    Result result = await DioClient().get('Medical/CustomerTOB', token);

    if (result is SuccessState) {
      if (result.value == null) {
        return;
      }
      var jsonData = List<BenefitsModel>.from(
          result.value.map((x) => BenefitsModel.fromJson(x)));
      if (jsonData is List<BenefitsModel>) {
        totalBenefits = jsonData;

        gettingGroupLifeData(totalBenefits);
        update();
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }
}
