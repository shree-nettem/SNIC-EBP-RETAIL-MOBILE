import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/customer_profile_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/model/financial_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FinancialDetailsXController extends GetxController {
  List<String> openAccountReasonOptions = [
    "Select",
    "General Insurance",
    "Health Insurance",
    "Car Insurance",
    "Bike Insurance",
    "Life Insurance"
  ];
  List<String> monthlyIncomeTypes = [
    "< BD 300",
    "BD 300 – BD 1000",
    "BD 1001 – BD 2500",
    "BD 2501 – BD 5000",
    "> BD 5000"
  ];
  List<String> sourceOfIncomeList = [];
  List<String> sourceOfIncomeOptions = [
    "Salary",
    "Inheritance",
    "Business Ownership",
    "Investments"
  ];

  List<String> baseBanks = [
    'Ahli United Bank (Bahrain) B.S.C. ( c )',
    'Ahli United Bank B.S.C',
    'Al Baraka Islamic Bank B.S.C. (c)',
    'Al-Salam Bank - Bahrain B.S.C.',
    'Arab Bank plc',
    'Bahrain Development Bank B.S.C.',
    'Bahrain Islamic Bank B.S.C.',
    'BBK',
    'BMI Bank B.S.C (c)',
    'BNP Paribas',
    'Citibank N.A.',
    'Credit Libanais SAL ',
    'Eskan Bank',
    'First Abu Dhabi Bank - Bahrain Branch',
    'Future Bank B.S.C. (c)',
    'Gulf International Bank B.S.C.',
    'Habib Bank Limited',
    'HSBC Bank Middle East Limited',
    'ICICI Bank Limited',
    'Ila',
    'Ithmaar Bank B.S.C. ( c )',
    'Khaleeji Commercial Bank B.S.C.',
    'Kuwait Finance House Bahrain  B.S.C. (c)',
    'MashreqBank psc',
    'National Bank of Bahrain BSC',
    'National Bank of Kuwait S.A.K.P',
    'Rafidain Bank',
    'Standard Chartered Bank',
    'State Bank of India',
    'The Housing Bank for Trade and Finance - Jordan',
    'United Bank Limited'
  ];

  TextEditingController monthlyIncomeController, IBANController;

  String monthlyIncome,
      sourceOfIncome,
      reasonForOpeningAccount,
      bank,
      IBANNumber;

  void setMonthlyIncome(String monthlyIncome) {
    monthlyIncomeController.text = monthlyIncome;
  }

  void setSourceOfIncome(String sourceOfIncome) {
    this.sourceOfIncome = sourceOfIncome;
  }

  void setMonthlyIncomeRannge(String sourceOfIncome) {
    this.monthlyIncome = monthlyIncome;
  }

  void setReasonForOpeningAccount(String reasonForOpeningAccount) {
    this.reasonForOpeningAccount = reasonForOpeningAccount;
  }

  void setBank(String bank) {
    this.bank = bank;
    debugPrint("BANK " + bank);
  }

  void setIBANNumber(String iban) {
    this.IBANNumber = iban;
  }

  getMonthlyIncome() => monthlyIncomeController.text;

  getSourceOfIncome() => sourceOfIncome;

  getReasonForOpeningAccount() => reasonForOpeningAccount;

  getIBANNumber() => IBANController.text;

  final formKey = GlobalKey<FormState>();

  FinancialModel financialModel;
  SharedPreferencesHelper _sharedPreferencesHelper = SharedPreferencesHelper();
  bool isLoading = false;
  var token;
  int bankIndex = 0, sourceOfIncomeIndex = 0;

  @override
  void onInit() {
    IBANController = TextEditingController();
    monthlyIncomeController = TextEditingController();

    getToken();

    super.onInit();
  }

  /* SET CUSTOMER DATA */
  setData() {
    final customerDetails =
        Get.find<CustomerProfileController>().customerDetails;

    IBANController.text = customerDetails.details.iBAN ?? "";
    this.sourceOfIncome = customerDetails.details.sourceOfIncome ?? "";

    if (customerDetails.details.bank != null) {
      bankIndex = baseBanks
          .indexWhere((element) => element == customerDetails.details.bank);
      bank = baseBanks[bankIndex];
    }

    if (customerDetails.details.sourceOfIncome != null) {
      sourceOfIncomeIndex = sourceOfIncomeOptions.indexWhere(
          (element) => element == customerDetails.details.sourceOfIncome);
      sourceOfIncome = sourceOfIncomeOptions[sourceOfIncomeIndex];
    }

    debugPrint("SOURCE OF INCOME $bank");
    // getLookUps("SourceOfIncome");
    // getLookUps("SalaryLookup");
    update();
  }

  getLookUps(String code) async {
    Result result =
        await DioClient().get('Benefit/GetBenefitLookup?type=$code', token);
    if (result is SuccessState) {
      if (code == "SourceOfIncome") {
        sourceOfIncomeList = result.value.cast<String>();
      } else if (code == "SalaryLookup") {
        monthlyIncomeTypes = result.value.cast<String>();
      }

      debugPrint("SOURCE_INCOME ${sourceOfIncomeList.toList()}");
      update();
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    } else if (result is NetworkErrorState) {
      bool hasNetworkError = false;
    }
  }

  /* GET TOKEN */
  getToken() async {
    token = await _sharedPreferencesHelper.getAccessToken;
    debugPrint("TOKEN $token");
  }

  /* SAVE FINANCIAL INFO TO THE SERVER */
  saveFinancialInfo() {
    var financialInfoRequestMap = {
      "Salary": getMonthlyIncome(),
      "SourceOfIncome": sourceOfIncome ?? "",
      "Bank": bank,
      "IBAN": getIBANNumber() ?? ""
    };

    debugPrint("FINANCIAL $financialInfoRequestMap");
    postFinancialInfo(financialInfoRequestMap);
  }

  /* POST BASIC IN*/
  postFinancialInfo(financialInfoRequestMap) async {
    Result result = await DioClient().post(
      'Customer/SaveProfileFinancialDetails',
      financialInfoRequestMap,
      token: token,
      isPostData: true,
    );
    if (result is SuccessState) {
      updateCustomerDetails();
      successMessage("Successfully updated!");
    } else if (result is ErrorState) {
      errorMessage(result.msg.error.toString());
    }
  }

  /* UPDATE CUSTOMER DETAILS */
  updateCustomerDetails() {
    final customerDetails =
        Get.find<CustomerProfileController>().customerDetails;

    customerDetails.details.sourceOfIncome = sourceOfIncome;
    customerDetails.details.iBAN = getIBANNumber();
    update();
  }

  saveUserBasicData() {
    final customerDetails =
        Get.find<CustomerProfileController>().customerDetails;

    var requestMap = {
      "ID": customerDetails.details.iD,
      "FirstName": customerDetails.details.firstName ?? "",
      "MiddleName": customerDetails.details.middleName ?? "",
      "LastName": customerDetails.details.lastName ?? "",
      "Address": "",
      "IBAN": IBANController.text ?? customerDetails.details.iBAN,
      "IDType": customerDetails.details.iDType,
      "DateOfBirth": customerDetails.details.dateOfBirth,
      "Department": customerDetails.details.department,
      "Gender": customerDetails.details.gender,
      "MobileNumber": customerDetails.details.mobileNumber,
      "Salary": customerDetails.details.salary,
      "PassportID": customerDetails.details.passportID,
      "IdentityID": customerDetails.details.identityID,
      "Position": customerDetails.details.position,
      "MaritalStatus": customerDetails.details.maritalStatus,
      "PersonalEmail": customerDetails.details.personalEmail,
      "IDType": 1,
      "Nationality": customerDetails.details.nationality,
      "Bank": customerDetails.details.bank,
      "OtherContactNumber": customerDetails.details.otherContactNumber,
      "PrimaryEmail": customerDetails.details.primaryEmail,
      "CorporateEmail": customerDetails.details.corporateEmail,
      "IdentityExpiryDate": customerDetails.details.identityExpiryDate,
      "LicenceExpiryDate": customerDetails.details.licenceExpiryDate,
      "Subscribed": customerDetails.details.subscribed,
      "MobileNumberOTP": "",
      "CorporateEmailOTP": "",
      "PersonalEmailOTP": "",
      "MailingAddressTown": customerDetails.details.mailingAddressTown,
      "MailingAddressBlock": customerDetails.details.mailingAddressBlock,
      "MailingAddressRoad": customerDetails.details.mailingAddressRoad,
      "MailingAddressHouse": customerDetails.details.mailingAddressHouse,
      "HomeAddressTown": customerDetails.details.homeAddressTown,
      "HomeAddressBlock": customerDetails.details.homeAddressBlock,
      "HomeAddressRoad": customerDetails.details.homeAddressRoad,
      "HomeAddressHouse": customerDetails.details.homeAddressHouse
    };

    Get.find<CustomerProfileController>().saveProfileData(requestMap);
  }

  @override
  void dispose() {
    super.dispose();
    FocusScope.of(Get.context).unfocus();
    monthlyIncomeController.clear();
  }
}
