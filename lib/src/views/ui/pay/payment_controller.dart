import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart' as res;
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/constants.dart';
import 'package:ebpv2/src/utilities/expiry_date_helper.dart';
import 'package:ebpv2/src/utilities/form_validators.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/ui/home/model/pending_payment.dart';
import 'package:ebpv2/src/views/ui/motor/model/loyality_points.dart';
import 'package:ebpv2/src/views/ui/motor/payment/benifit_payment_view.dart';
import 'package:ebpv2/src/views/ui/motor/payment/credimax_payment_view.dart';
import 'package:ebpv2/src/views/ui/motor/payment/model/benifit_response.dart';
import 'package:ebpv2/src/views/ui/motor/payment/model/credimax_response.dart';
import 'package:ebpv2/src/views/ui/motor/payment/model/transaction_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GeneralPaymentController extends GetxController {
  //method channel name for credimax native interaction
  static final platform = MethodChannel('credimax.channel.payment');

  //all types of payment options
  List<bool> paymentOptions;
  PendingPayment item;
  String token;
  TextEditingController points, promoCode;
  TextEditingController nameOnCard, cardNumber, expiryDate, securityCode;
  CrediMaxResponse crediMaxResponse;
  BenifitResponse benefitModel;
  LoyalityPoints loyalty;

  RxString discountAmount = "".obs;
  RxString totalAmount = "".obs;
  bool isDiscountVisilbe;

  @override
  void onInit() {
    getToken();
    paymentOptions = [false, false, false, false];
    item = Get.arguments['item'];
    points = TextEditingController();
    promoCode = TextEditingController();
    nameOnCard = TextEditingController();
    cardNumber = TextEditingController();
    expiryDate = TextEditingController();
    securityCode = TextEditingController();

    super.onInit();
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
      update();
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  String calculateTotalToPaid() {
    var finalAmount = discountAmount.value == ""
        ? item.amount
        : item.amount - double.parse(discountAmount.value);
    return finalAmount.isNegative
        ? item.amount.toString()
        : finalAmount.toString();
  }

  //set selected payment option
  switchPaymentOptions(index) {
    for (int i = 0; i < paymentOptions.length; i++) {
      paymentOptions[i] = i == index;
    }
    debugPrint("PAYMENT OPTION ${paymentOptions[index]}");
    update();
  }

  //call benifit pay api
  void proceedToBenefitPayment(PendingPayment item) async {
    //check the originate flow to find the required controller instance

    // based on the flow set the total amount
    var details = {
      "utf2": "test",
      "amt": item.amount,
      "Type": item.type,
      "Points": item.points != null
          ? item.points > 0
              ? item.points
              : 0
          : 0,
      "TransactionId": item.id
    };

    res.Result result = await DioClient().post(
      'Payment/BenefitPayment',
      details,
      token: token,
      isPostData: true,
    );
    if (result is res.SuccessState) {
      benefitModel = BenifitResponse.fromJson(result.value);
      if (!benefitModel.isFullPaid) {
        Get.to(
          BenifitPaymentView(
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
                checkTransactionStatus(val);
              }
            },
          ),
        );
      } else {
        //? Take user back to Pending Payments screen and update the list
        debugPrint("IS FULL PAID ${benefitModel.isFullPaid}");
        Get.back(result: true);
      }
    } else if (result is res.ErrorState) {
      errorMessage(result.msg);
    }
  }

  //check benifit payment status by passing id
  void checkTransactionStatus(int val) async {
    res.Result result =
        await DioClient().get('Payment/GetTransaction?id=$val', token);
    if (result is res.SuccessState) {
      var transactionStatusResponse =
          TransactionStatusResponse.fromJson(result.value);
      if (transactionStatusResponse.status == 'Failed') {
        Get.back();
        Get.toNamed(AppRoutes.PAYMENT_FAILED);
        // Get.close(2);
      } else if (transactionStatusResponse.status == 'Success') {
        Get.back();
        /* if (originate_Flow == MyString.renewMotorflow) {
          updatePaymentSuccessFullDeatils(MyString.motorInsurance, val, quote);
        } else {*/
        CustomDialogHelper.showAlertDialog(
            title: "Alert",
            description: "Payment Success",
            okBtnFunction: () {
              // Get.offNamed(AppRoutes.DASHBOARD);
              Get.back();
              Get.back();
            });
        // }
      }
    } else if (result is res.ErrorState) {
      Get.back();
      Get.toNamed(AppRoutes.PAYMENT_FAILED);
      // ErrorResponse error=ErrorResponse.fromJson(result.msg);
      // // Get.back();
      // errorMessage(error.message);
    }
  }

  //If user redeems loyalty points completely, then call below API
  void closeFullyUsedPoints() async {
    res.Result result =
        await DioClient().get('Payment/CloseUsingPoints?id=193', token);
    if (result is res.SuccessState) {
      successMessage("Success");
    } else if (result is res.ErrorState) {
      Get.back();
      errorMessage("Some error occured!");
    }
  }

  ///bottom sheet ui for credit card details
  void showBottomSheetDialoug(
      PendingPayment item, CrediMaxResponse crediMaxResponse) {
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'name_card'.tr,
                      ),
                      validator: (val) {
                        return AppFormFieldValidator.generalEmptyValidator(val);
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
                        return AppFormFieldValidator.creditCardNumberValidator(
                            val);
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

                /*          Container(
                      margin: EdgeInsets.all(10.0),
                      child: CustomLabel(
                        title: MyString.creditCardDisclaimer,
                        fontSize: 12,
                        fontFamily: Constants.FONT_SF_UI_TEXT_MEDIUM,
                        maxLines: 2,
                      ),
                    ),*/
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
                                item,
                                crediMaxResponse);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void credMaxPayment(PendingPayment item) async {
    var details = {
      "Name": "test",
      "Amount": item.amount,
      "Type": item.type,
      "TransactionId": item.id,
      "Points": points.text != "" ? item.points : 0
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
                CustomDialogHelper.showAlertDialog(
                    title: "Alert",
                    description: "Payment Success",
                    okBtnFunction: () {
                      // Get.offNamed(AppRoutes.DASHBOARD);
                      Get.back();
                      Get.back();
                    });
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
      PendingPayment item,
      CrediMaxResponse crediMaxResponse) async {
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
      print(data);
      //adding a loder while the code cedimax sdk is ruuning in backgriund
      CustomDialogHelper.showLoading(showLongWaitingMessage: false);
      //registering to callback from native andorid for payment status
      platform.setMethodCallHandler((call) => _didRecievePaymentUpdate(call));
      //calling native code and passing all details to perform payment (trigger sdk)
      await platform.invokeMethod('credimaxPayment', data);
    } catch (e) {
      print('Failed : ${e.message}');
    }
    //later replace the amt variable witht the below line
    /*
          "amt": originatedFlow == MyString.renewMotorflow?switchController.issedQuote.totalPremiumBeforeDiscount:0,
      */

    //  "amt": calculateTotalPremeium(quote),
    // based on the flow set the total amount
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
      "Points": item.points,
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
              Get.back();
              Get.back();
              //if the transaction is successful update the corresponding api
              /*  if (originate_Flow == MyString.motorInsurance) {
                InsurancePaymentXController insurancePaymentXController =
                Get.put(InsurancePaymentXController());
                insurancePaymentXController.confirmPayment();
              } else if (originate_Flow == MyString.renewMotorflow) {
                confirmPayment();
              }*/
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

  void applyDiscount(String text) {
    if (AppFormFieldValidator.loyaltyPointValidator(points.text,
            loyalty: loyalty) ==
        null) {
      isDiscountVisilbe = true;
      discountAmount.value = text;
      try {
        item.points = double.parse(text) * loyalty.result.rewardPoint;
      } catch (e) {}

      print(item.points);
      update();
    }
  }

/*  int calculatePoints() {
    return (loyalty.result.rewardPoint / double.parse(discountAmount.value))
        .toInt();
  }*/

}
