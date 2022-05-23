import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart' as res;
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/expiry_date_helper.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/utilities/utils.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/home/model/pending_payment.dart';
import 'package:ebpv2/src/views/ui/motor/model/issue_quote.dart';
import 'package:ebpv2/src/views/ui/motor/model/loyality_points.dart';
import 'package:ebpv2/src/views/ui/motor/model/payment_ssue_policy_model.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/insurance_payment_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/motor_paln_Controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/controller/vehicle_details_controller.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_plan/screen/payment_sucess_screen.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/controller/renew_switch_controller.dart';
import 'package:ebpv2/src/views/ui/motor/payment/credimax_payment_view.dart';
import 'package:ebpv2/src/views/ui/motor/payment/model/benifit_response.dart';
import 'package:ebpv2/src/views/ui/motor/payment/model/credimax_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'benifit_payment_view.dart';
import 'model/transaction_status.dart';

class PaymentXController extends GetxController {
  final formKey = GlobalKey<FormState>();

  //all types of payment options
  List<bool> paymentOptions;

  //temp variable to hold the flow for credimaxCallback
  String originate_Flow = "";

  BenifitResponse benefitModel;
  CrediMaxResponse crediMaxResponse;

  RxBool isLoading = RxBool(true);

  RxInt loyaltyPoints = 0.obs;

  //method channel name for credimax native interaction
  static final platform = MethodChannel('credimax.channel.payment');

  TextEditingController points, promoCode;
  TextEditingController nameOnCard, cardNumber, expiryDate, securityCode;

  RxString eligibleAmount = "".obs;
  String token;
  TransactionStatusResponse transactionStatusResponse;

  RxString discountAmount = "".obs;

  bool isDiscountVisilbe;

  RenewSwitchController switchController;
  MotorPalnXController palnXController;
  VehicleDetailsXController vehicleDetailsXController;
  LoyalityPoints loyalty;

  @override
  void onInit() {
    getToken();
    isLoading.value = true;
    paymentOptions = [false, false, false, false];
    points = TextEditingController();
    promoCode = TextEditingController();
    nameOnCard = TextEditingController();
    cardNumber = TextEditingController();
    expiryDate = TextEditingController();
    securityCode = TextEditingController();
    isDiscountVisilbe = false;
    super.onInit();
  }

  //set selected payment option
  switchPaymentOptions(index) {
    for (int i = 0; i < paymentOptions.length; i++) {
      paymentOptions[i] = i == index;
    }
    print(paymentOptions[index]);
    update();
  }

  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
    getLoyaltyPoint();
  }

//get loyalty points
  Future<void> getLoyaltyPoint() async {
    res.Result result = await DioClient()
        .get('/Loyalty/GetCustomerLoyaltyPointsDetails', token);
    if (result is res.SuccessState) {
      loyalty = LoyalityPoints.fromJson(result.value);
      eligibleAmount.value = loyalty.result.eligibleAmount.toString();
      loyaltyPoints.value = loyalty.result.outstandingPoints.toInt();
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  //on close dispose all text controllers
  @override
  void onClose() {
    discountAmount.value = "";
    //points.dispose();
    promoCode.dispose();
    cardNumber.dispose();
    securityCode.dispose();
    expiryDate.dispose();
    nameOnCard.dispose();
    super.onClose();
  }

  //call benifit pay api
  void proceedToBenefitPayment(String originatedFlow, IssueQuote quote) async {
    //check the originate flow to find the required controller instance
    if (originatedFlow == MyString.renewMotorflow) {
      switchController = Get.find();
    } else if (originatedFlow == MyString.motorInsurance) {
      vehicleDetailsXController = Get.find();
      palnXController = Get.find();
    }

    // based on the flow set the total amount
    var details = {
      "utf2": "test",
      "amt": calculateTotalPremeium(quote) +
          (discountAmount.value.isNotEmpty &&
                  double.parse(discountAmount.value) > 0
              ? double.parse(discountAmount.value)
              : 0),
      "Type": originatedFlow == MyString.renewMotorflow
          ? "Renewed Policy"
          : originatedFlow == MyString.motorInsurance
              ? "New Policy"
              : "",
      "Points": discountAmount.value.isNotEmpty &&
              double.parse(discountAmount.value) > 0
          ? calculatePoints()
          : 0,
      "TransactionId": null
    };

    res.Result result = await DioClient().post(
      'Payment/BenefitPayment',
      details,
      token: token,
      isPostData: true,
    );
    if (result is res.SuccessState) {
      benefitModel = BenifitResponse.fromJson(result.value);
      Get.to(BenifitPaymentView(
          url: benefitModel.result,
          paymentStatus: (val) {
            //show error if failed or update the transcation status
            if (val == 400) {
              Get.back();
              CustomDialogHelper.showAlertDialog(
                  title: "Alert",
                  description: "Something went wrong please try again",
                  okBtnFunction: () {
                    Get.back();
                  });
            } else {
              checkTransactionStatus(val, originatedFlow, quote);
            }
          }));
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  //check benifit payment status by passing id
  void checkTransactionStatus(
      int val, String originatedFlow, IssueQuote quote) async {
    res.Result result =
        await DioClient().get('Payment/GetTransaction?id=$val', token);
    if (result is res.SuccessState) {
      transactionStatusResponse =
          TransactionStatusResponse.fromJson(result.value);
      if (transactionStatusResponse.status == 'Failed') {
        Get.back();
        Get.toNamed(AppRoutes.PAYMENT_FAILED);
        // Get.close(2);
      } else if (transactionStatusResponse.status == 'Success') {
        Get.back();
        if (originate_Flow == MyString.renewMotorflow) {
          updatePaymentSuccessFullDeatils(MyString.motorInsurance, val, quote);
        } else {
          CustomDialogHelper.showAlertDialog(
              title: "Alert",
              description: "Payment Success",
              okBtnFunction: () {
                Get.back();
                InsurancePaymentXController insurancePaymentXController =
                    Get.put(InsurancePaymentXController());
                if (originatedFlow == MyString.motorInsurance) {
                  insurancePaymentXController.confirmPayment(
                      id: val, token: token, quote: quote);
                } else if (originatedFlow == MyString.renewMotorflow) {
                  confirmPayment(id: val, quote: quote);
                }
              });
        }

        //use this in payment successscreen

        /* CustomDialogHelper.showAlertDialog(
            title: "Alert",
            description: "Payment Success",
            okBtnFunction: () {
              //if the transaction is successful update the corresponding api
              if (originatedFlow == MyString.motorInsurance) {
                InsurancePaymentXController insurancePaymentXController =
                    Get.put(InsurancePaymentXController());
                insurancePaymentXController.confirmPayment(id: val,token:token,quote:quote);
              } else if (originatedFlow == MyString.renewMotorflow) {
                confirmPayment(id: val);
              }
              Get.back();
            });*/
      }
    } else if (result is res.ErrorState) {
      Get.back();
      Get.toNamed(AppRoutes.PAYMENT_FAILED);
      // ErrorResponse error=ErrorResponse.fromJson(result.msg);
      // // Get.back();
      // errorMessage(error.message);
    }
  }

  //confirm payment for motor renewal flow
  void confirmPayment(
      {int id, IssueQuote quote, paymentMode = "BENEFITPAY"}) async {
    switchController = Get.find();
    var payment = {
      "proposalNumber": quote.proposalNumber,
      "collectionMode": paymentMode, //CREDIMAX, ONLINEPAY, BENEFITPAY
      "transactionNumber": id != null ? id : "",
      "collectionAmount": discountAmount != null &&
              discountAmount.value.isNotEmpty &&
              double.parse(discountAmount.value) > 0
          ? (quote.policyPremium - double.parse(discountAmount.value))
          : quote.policyPremium
    };
    var discount = {
      "proposalNumber": quote.proposalNumber,
      "collectionMode": "LOLYTPT", //CREDIMAX, ONLINEPAY, BENEFITPAY
      "transactionNumber": id != null ? id : "",
      "collectionAmount": discountAmount.value,
    };
    var details;
    if (discountAmount != null && discountAmount.value.isNotEmpty) {
      if (double.parse(discountAmount.value) > 0) {
        details = {
          "colPaymentList": [payment, discount]
        };
      } else {
        details = {
          "colPaymentList": [payment]
        };
      }
    } else {
      details = {
        "colPaymentList": [payment]
      };
    }
    res.Result result = await DioClient().post(
        '/Motor/RenewalPaymentAndIssuePolicy', details,
        token: token, isPostData: true, isHeaderJsonType: true);
    if (result is res.SuccessState) {
      PaymentAndIssuePolicyModel response =
          PaymentAndIssuePolicyModel.fromJson(result.value);

      Get.to(PaymentSuccessScreen(response));
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  //calculate total premium
  double calculateTotalPremeium(IssueQuote issedQuote) {
    //policy fees need to be added
    if (discountAmount != null &&
        discountAmount.value.isNotEmpty &&
        double.parse(discountAmount.value) > 0) {
      var finalValue = double.parse(((issedQuote.supplementaryBenefitsAmount +
                  issedQuote.vatAmount +
                  issedQuote.basicPremiumAmount +
                  issedQuote.stampDuty) -
              double.parse(discountAmount.value))
          .toStringAsFixed(3));
      return finalValue.isNegative
          ? double.parse(((issedQuote.supplementaryBenefitsAmount +
                  issedQuote.vatAmount +
                  issedQuote.basicPremiumAmount +
                  issedQuote.stampDuty))
              .toStringAsFixed(3))
          : finalValue;
    } else {
      return double.parse(((issedQuote.supplementaryBenefitsAmount +
              issedQuote.vatAmount +
              issedQuote.basicPremiumAmount +
              issedQuote.stampDuty))
          .toStringAsFixed(3));
    }
  }

  void credMaxPayment(String originatedFlow, IssueQuote item) async {
    var details = {
      "Name": "test",
      "Amount": calculateTotalPremeium(item) +
          (discountAmount.value.isNotEmpty &&
                  double.parse(discountAmount.value) > 0
              ? double.parse(discountAmount.value)
              : 0),
      "Type": originatedFlow == MyString.renewMotorflow
          ? "Renewed Policy"
          : originatedFlow == MyString.motorInsurance
              ? "New Policy"
              : "",
      "Points": discountAmount.value.isNotEmpty &&
              double.parse(discountAmount.value) > 0
          ? calculatePoints()
          : 0,
      "TransactionId": null
    };
    res.Result result = await DioClient().post(
      'Payment/CredimaxPayment',
      details,
      token: token,
      isPostData: true,
    );

    if (result is res.SuccessState) {
      crediMaxResponse = CrediMaxResponse.fromJson(result.value);
      var isFullPaid = crediMaxResponse.isFullPaid ?? false;
      if (!isFullPaid) {
        Get.to(
          CredimaxPaymentView(
            url: crediMaxResponse.paymentLink,
            paymentStatus: (val) {
              //show error if failed or update the transcation status
              if (val == 400) {
                Get.back();
                Get.toNamed(AppRoutes.PAYMENT_FAILED);
              } else {
                Get.back();
                if (originate_Flow == MyString.renewMotorflow) {
                  updatePaymentSuccessFullDeatils(
                      MyString.motorInsurance, val, item);
                } else {
                  CustomDialogHelper.showAlertDialog(
                      title: "Alert",
                      description: "Payment Success",
                      okBtnFunction: () {
                        Get.back();
                        InsurancePaymentXController
                            insurancePaymentXController =
                            Get.put(InsurancePaymentXController());
                        if (originatedFlow == MyString.motorInsurance) {
                          insurancePaymentXController.confirmPayment(
                              id: val,
                              token: token,
                              quote: item,
                              paymentMode: "CREDIMAX");
                        } else if (originatedFlow == MyString.renewMotorflow) {
                          confirmPayment(
                              id: val, quote: item, paymentMode: "CREDIMAX");
                          //  Get.to(PaymentSuccessScreen(response));
                        }
                      });
                }
                // checkTransactionStatus(val);
              }
            },
          ),
        );
        // showBottomSheetDialoug(item, crediMaxResponse);
      } else {
        //? Take user back to Pending Payments screen and update the list
        debugPrint("IS FULL PAID $isFullPaid");
        Get.back(result: true);
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  // get the session id and detils for credimax payment
  void proceedToCrediMaxPayment(
      String nameOnCard,
      String cardNumber,
      String expiryDate,
      String securityCode,
      String originatedFlow,
      IssueQuote quote) async {
//later replace the amt variable witht the below line
/*
    "amt": originatedFlow == MyString.renewMotorflow?switchController.issedQuote.totalPremiumBeforeDiscount:0,
*/
    //check the originate flow to find the required controller instance
    if (originatedFlow == MyString.renewMotorflow) {
      switchController = Get.find();
    } else if (originatedFlow == MyString.motorInsurance) {
      vehicleDetailsXController = Get.find();
      palnXController = Get.find();
    }
//  "amt": calculateTotalPremeium(quote),
    // based on the flow set the total amount
    var details = {
      "utf2": "test",
      "amt": 0.01,
      "Type": originatedFlow == MyString.renewMotorflow
          ? "Renewed Policy"
          : originatedFlow == MyString.motorInsurance
              ? "New Policy"
              : "",
      "Points": discountAmount.value.isNotEmpty &&
              double.parse(discountAmount.value) > 0
          ? calculatePoints()
          : 0
    };
    res.Result result = await DioClient().post(
      'Payment/CredimaxPayment',
      details,
      token: token,
      isPostData: true,
    );
    if (result is res.SuccessState) {
      crediMaxResponse = CrediMaxResponse.fromJson(result.value);
      try {
        var data = {
          "merchant": crediMaxResponse.result.merchant,
          "id": crediMaxResponse.result.session.id,
          "version": 56,
          "Amount": crediMaxResponse.paymentTransaction.amount,
          "nameOnCard": nameOnCard,
          "cardNumber": cardNumber,
          "expiryMonth": expiryDate.split('/')[0],
          "expiryYear": expiryDate.split('/')[1],
          "securityCode": securityCode,
        };
        originate_Flow = originatedFlow;
        //adding a loder while the code cedimax sdk is ruuning in backgriund
        CustomDialogHelper.showLoading(showLongWaitingMessage: false);
        //registering to callback from native andorid for payment status
        platform.setMethodCallHandler((call) => _didRecievePaymentUpdate(call));
        //calling native code and passing all details to perform payment (trigger sdk)
        await platform.invokeMethod('credimaxPayment', data);
      } catch (e) {
        print('Failed : ${e.message}');
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  //CrediMax PaymentUpdate triggered from native android
  Future<void> _didRecievePaymentUpdate(MethodCall call) async {
    switch (call.method) {
      case "_didRecievePaymentUpdate":
        if (call.arguments) {
          Get.back();
          updateCrediMaxPaymentTransaction(true);
        } else if (!call.arguments) {
          Get.back();
          updateCrediMaxPaymentTransaction(false);
        }
    }
  }

  //push credimax data to backend
  void updateCrediMaxPaymentTransaction(bool status) async {
    var details = {
      "Status": status ? "Success" : "Failed",
      "Points": 0,
      "Type": "Renewed Policy",
    };
    res.Result result = await DioClient().post(
      'Payment/UpdatePaymentTransaction?id=${crediMaxResponse.paymentTransaction.id}',
      details,
      token: token,
      isPostData: true,
    );
    if (result is res.SuccessState) {
      // crediMaxResponse = CrediMaxResponse.fromJson(result.value);
      if (status) {
        CustomDialogHelper.showAlertDialog(
            title: "Message",
            description: "Payment Successful",
            okBtnFunction: () {
              //if the transaction is successful update the corresponding api
              if (originate_Flow == MyString.motorInsurance) {
                InsurancePaymentXController insurancePaymentXController =
                    Get.put(InsurancePaymentXController());
                insurancePaymentXController.confirmPayment();
              } else if (originate_Flow == MyString.renewMotorflow) {
                confirmPayment();
              }
              Get.back();
            });
      } else {
        CustomDialogHelper.showAlertDialog(
            title: "Alert",
            description: "Payment failed please try again",
            okBtnFunction: () {
              Get.back();
            });
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  void applyDiscount(String text, IssueQuote issedQuote) {
    if (AppFormFieldValidator.loyaltyPointValidator(text, loyalty: loyalty) ==
        null) {
      try {
        var totalValue = double.parse(((issedQuote.supplementaryBenefitsAmount +
                    issedQuote.vatAmount +
                    issedQuote.basicPremiumAmount +
                    issedQuote.stampDuty) -
                double.parse(discountAmount.value))
            .toStringAsFixed(3));
        if (totalValue.isNegative) {
          isDiscountVisilbe = false;
          errorMessage("Loyality points can't be more than total amount");
          update();
        } else {
          isDiscountVisilbe = true;
          discountAmount.value = text;
          // discountAmount.value =
          // (int.parse(text) * loyalty.result.rewardPoint).toString();
          update();
        }
      } catch (e) {
        isDiscountVisilbe = false;
        update();
      }
    }
  }

  int calculatePoints() {
    // return (loyalty.result.rewardPoint / double.parse(discountAmount.value))
    //     .toInt();
    return (double.parse(discountAmount.value) * loyalty.result.rewardPoint)
        .toInt();
  }

  ///bottom sheet ui for credit card details
  void showBottomSheetDialoug(String originatedFlow, IssueQuote quote) {
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: Get.context,
        enableDrag: false,
        isScrollControlled: true,
        builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                height: 450,
                width: Get.context.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            Images.cancel,
                            color: Colors.grey,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: CustomLabel(
                          title: 'enterCardDetails'.tr,
                          fontSize: 18,
                          fontFamily: Constants.FONT_SF_UI_TEXT_MEDIUM,
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: TextFormField(
                            controller: nameOnCard,
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'name_card'.tr,
                            ),
                            validator: (val) {
                              return AppFormFieldValidator
                                  .generalEmptyValidator(val);
                            }),
                      ),
                      Container(
                          margin: EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: cardNumber,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'card_number'.tr,
                            ),
                            validator: (val) {
                              return AppFormFieldValidator
                                  .creditCardNumberValidator(val);
                            },
                          )),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: Get.context.width / 2.5,
                              child: TextFormField(
                                  controller: expiryDate,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    hintText: 'Expiry Date (mm/yy)',
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [CardExpirationFormatter()],
                                  validator: (val) {
                                    return AppFormFieldValidator
                                        .creditCardExpiryValidator(val);
                                  }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                width: Get.context.width / 2,
                                child: TextFormField(
                                    controller: securityCode,
                                    keyboardType: TextInputType.number,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        hintText: 'security_code'.tr,
                                        suffixIcon: Icon(Icons.credit_card)),
                                    validator: (val) {
                                      return AppFormFieldValidator
                                          .creditCardsecurityCodeValidator(
                                              val, cardNumber.text);
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                        child: Divider(
                          height: 2,
                          color: MyColors.PrimaryColor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              width: Get.context.width / 2.5,
                              title: 'cancel'.tr,
                              buttonAction: () {
                                Get.back();
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                              width: Get.context.width / 2.5,
                              title: 'proceed'.tr,
                              fontSize: 12,
                              buttonAction: () {
                                if (_formKey.currentState.validate()) {
                                  Get.back();
                                  proceedToCrediMaxPayment(
                                      nameOnCard.text,
                                      cardNumber.text,
                                      expiryDate.text,
                                      securityCode.text,
                                      originatedFlow,
                                      quote);
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }

  void updatePaymentSuccessFullDeatils(
      String originatedFlow, int val, IssueQuote quote) async {
    var startDate = DateTime.now();

    DateTime lastDayOfMonth =
        new DateTime(startDate.year + 1, startDate.month + 1, 0);
    var policyExpiryDate =
        Utils.convertDateTimeDisplay(lastDayOfMonth.toString());
    var savedDraftResponse = {
      "Year": "",
      "BrandNew": [
        vehicleDetailsXController.isBrandNew[0],
        vehicleDetailsXController.isBrandNew[1]
      ],
      "PolicyStartDate": Utils.convertDateTimeDisplay(startDate.toString()),
      "PolicyExpiryDate": policyExpiryDate,
      "SumInsured": "",
      "MotorMake": "",
      "MotorModel": "",
      "NoClaimDeclarationPeriod": "0",
      "QuoteNumber": "",
      "PlanName": "",
      "PlateNumber": "",
      "BankName": "",
      "ChassisNumber": "",
      "selectedPlanIndex": 0,
      "vehicleDetailsStatus": 1,
      "selectYourPlanStatus": 0,
      "paymentStatus": 0,
      "paymentType": [false, false],
      "ownership": [false, false],
      "isCashFlowVisible": false,
      "isPlanSelected": false,
      "isRecommendedVisible": true,
      "isLoanFlowVisible": false,
      "isCustomerFlowVisible": false,
      "isBankFlowVisible": false,
      "isQuotIssued": false,
      "isDealerQuotionUploaded": false,
      "isCprValid": false,
      "eligibleOption": "SELECT",
      "quot": quote,
      "isPaymentSuccessful": true,
      "isPolicyIssued": false,
      "transactionNumber": val
    };

    var body = {
      "status_code": 1,
      "message": "success",
      "result": savedDraftResponse,
    };

    res.Result result = await DioClient().post(
        'Customer/SavePreference/MotorPlan', body,
        token: token, isPostData: true, isHeaderJsonType: true);

    if (result is res.SuccessState) {
      CustomDialogHelper.showAlertDialog(
          title: "Alert",
          description: "Payment Success",
          okBtnFunction: () {
            Get.back();
            if (originatedFlow == MyString.motorInsurance) {
              InsurancePaymentXController insurancePaymentXController =
                  Get.put(InsurancePaymentXController());
              insurancePaymentXController.confirmPayment(
                  id: val, token: token, quote: quote);
            } else if (originatedFlow == MyString.renewMotorflow) {
              confirmPayment(id: val);
            }
          });
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }
}
