import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/contact_form/contact_form_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactFormXController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController tabController;

  final formKey = GlobalKey<FormState>();

  String messageType = 'Select';
  String messageCategory = 'Select';
  String token;
  TextEditingController messageController;
  List<String> totalMessageTypes = ['Select'];
  List<String> totalMessageCategories = ['Select'];
  RxList<TotalSuggestionMessages> totalSuggestedMessages =
      RxList<TotalSuggestionMessages>();

  @override
  void onInit() {
    messageController = TextEditingController();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      FocusManager.instance.primaryFocus?.unfocus();
    });

    getToken();
    super.onInit();
  }

  @override
  void onClose() {
    messageController.dispose();
    tabController.dispose();

    super.onClose();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    getMessageType();
    getMessageCategory();
    getTotalComplaints();
  }

  getMessageType() async {
    Result result =
        await DioClient().get('Suggestion/GetSuggestionType', token);
    if (result is SuccessState) {
      var jsonData = List<MessageType>.from(
          result.value.map((x) => MessageType.fromJson(x)));
      if (jsonData is List<MessageType>) {
        totalMessageTypes = jsonData.map((e) => e.value).toList();
        totalMessageTypes.insert(0, 'Select');
        update();
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  getMessageCategory() async {
    Result result =
        await DioClient().get('Suggestion/GetSuggestionCategory', token);
    if (result is SuccessState) {
      var jsonData = List<MessageType>.from(
          result.value.map((x) => MessageType.fromJson(x)));
      if (jsonData is List<MessageType>) {
        totalMessageCategories = jsonData.map((e) => e.value).toList();
        totalMessageCategories.insert(0, 'Select');
        update();
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  getTotalComplaints() async {
    Result result = await DioClient()
        .get('Suggestion/GetSuggestions', token, isLoading: false);
    if (result is SuccessState) {
      var jsonData = List<TotalSuggestionMessages>.from(
          result.value.map((x) => TotalSuggestionMessages.fromJson(x)));
      if (jsonData is List<TotalSuggestionMessages>) {
        totalSuggestedMessages.value = jsonData;
        print(totalSuggestedMessages.length);
        update();
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  postFeedback() async {
    Map<String, dynamic> body = {
      "SuggestionType": this.messageType,
      "SuggestionCategory": this.messageCategory,
      "SuggestionMessage": messageController.text,
    };

    Result result = await DioClient()
        .post('Suggestion/CreateSuggestion', body, token: token);
    if (result is SuccessState) {
      Get.toNamed(AppRoutes.CONTACT_FORM_SUCCESS);
      getTotalComplaints();
      clearDataInForm();
    } else if (result is ErrorState) {
      errorMessage(result.msg.toString());
    }
  }

  clearDataInForm() {
    messageCategory = "Select";
    messageType = "Select";
    messageController.clear();
    update();
  }

  void setMessagetype(String msgType) {
    this.messageType = msgType;
  }

  void setMessageCate(String msgType) {
    this.messageCategory = msgType;
  }

  String getStatusOfClaim(int statusId) {
    switch (statusId) {
      case 0:
        return "Draft";
        break;
      case 1:
        return "Submitted";
        break;
      case 2:
        return "Processing";
        break;
      case 3:
        return "Approved";
        break;
      case 4:
        return "Rejected";
        break;
      default:
        return "Draft";
    }
  }

  Color getStatusColor(int statusId) {
    switch (statusId) {
      case 0:
        return MyColors.GrayColor;
        break;
      case 1:
        return MyColors.themeColor;
        break;
      case 2:
        return MyColors.themeColor;
        break;
      case 3:
        return MyColors.greeen;
        break;
      case 4:
        return MyColors.red;
        break;
      default:
        return MyColors.GrayColor;
    }
  }
}
