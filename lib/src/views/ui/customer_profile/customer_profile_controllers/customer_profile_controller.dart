import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/credentials.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/basic_info_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/dependent_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CustomerProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool cardViewExpanded = false.obs;
  RxInt expandedIndex = 0.obs;
  RxDouble opacityValue = 1.0.obs;
  bool isLoading = false;
  var token;
  List addressCodeList = [];
  List salaryTypeList = [];
  List sourceOfIncomeList = [];

  RxBool basicInformation = false.obs;
  RxBool financialDetails = false.obs;
  RxBool identification = false.obs;
  RxBool personalVerification = false.obs;
  RxBool mailingAddress = false.obs;

  List profileCategories = [
    'basic_information'.tr,
    'financial_details'.tr,
    'identification'.tr,
    'personal_verification'.tr,
    'address'.tr
  ];
  final AutoScrollController scrollController = AutoScrollController();
  CustomerProfileModel customerDetails;
  RxString customerName = "".obs;

  void togglingExpansion(bool toogleValue, int index) {
    cardViewExpanded.value = toogleValue;
    expandedIndex.value = index;
    opacityValue.value = toogleValue == true ? 0.3 : 1.0;
  }

  TabController tabController;
  SharedPreferencesHelper _sharedPreferencesHelper = SharedPreferencesHelper();
  var townList;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      // if (tabController.indexIsChanging) {
      FocusScope.of(Get.context).requestFocus(FocusNode());
      // }
    });
    getToken();
  }

  Future scrollToIndex() async {
    await scrollController.animateTo(150,
        duration: Duration(milliseconds: 1000), curve: Curves.ease);
  }

  /* GET TOKEN */
  getToken() async {
    token = await _sharedPreferencesHelper.getAccessToken;
    getCustomerDetailsFromAPI();
    debugPrint("TOKEN $token");
  }

  getLookUps(String code) async {
    Result result = await DioClient()
        .get('Benefit/GetBenefitLookup?type=$code', token, isLoading: false);
    if (result is SuccessState) {
      if (code == "AddressCode") {
        addressCodeList = result.value;
      } else if (code == "SourceOfIncome") {
        sourceOfIncomeList = result.value;
      } else if (code == "SalaryLookup") {
        salaryTypeList = result.value;
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  getCustomerDetailsFromAPI({bool isLoading = true}) async {
    Result result =
        await DioClient().get('Customer/Details2', token, isLoading: isLoading);
    if (result is SuccessState) {
      var jsonData = CustomerProfileModel.fromJson(result.value);
      if (jsonData is CustomerProfileModel) {
        customerDetails = jsonData;
        //print(customerDetails.details.documents.first.file);
        Get.find<BasicInfoXController>().addingDataAfterApi();
        basicInformation.value = customerDetails.basicInformation;
        financialDetails.value = customerDetails.financialDetails;
        identification.value = customerDetails.identification;
        personalVerification.value = customerDetails.personalVerification;
        mailingAddress.value = customerDetails.mailingAddress;
        getCustomerName();
        update();
      }
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  //SAVE PROFILE DATA API CALL
  saveProfileData(Map requestData) async {
    print(requestData);
    Result result = await DioClient().post(
      'Customer/SaveProfile',
      requestData,
      token: token,
      isPostData: true,
    );
    print(result.toString());
    if (result is SuccessState) {
      getCustomerDetailsFromAPI();
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  getCustomerName() {
    customerName.value = customerDetails != null
        ? "${customerDetails.details.firstName ?? ""} ${customerDetails.details.middleName ?? ""} ${customerDetails.details.lastName ?? ""}"
        : "";
  }

  setCustomerName(String name) {
    customerName.value = name;
    // update();
  }

  CustomerProfileModel getCustomerDetails() => customerDetails;

  //on back clicked
  void backActionClicked({bool fromMainMenuAccount = false}) {
    if (Get.find<DependentXController>().isEditing.value == true &&
        !fromMainMenuAccount) {
      Get.find<DependentXController>().addDependentClicked();
      Get.find<DependentXController>().isEditingChanging();
    } else {
      Get.back();
    }
    update();
  }

  initJumio() {
    debugPrint("JUMIO Initialized");
    Get.toNamed(AppRoutes.PERSONAL_IDENTIFICATION_REQUIRED, arguments: {
      'id': customerDetails.details.iD,
      "step_id": 3,
    });
  }

  updateView() {
    update();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
