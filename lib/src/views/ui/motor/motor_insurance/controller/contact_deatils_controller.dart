

import 'dart:io';

import 'package:ebpv2/src/services/dio_client.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/shared_preference.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:ebpv2/src/views/ui/motor/model/ErrorResponse.dart';
import 'package:ebpv2/src/views/ui/motor/model/contact_details.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDeatilsController extends GetxController{
  String token;
  ContactDetails contactDetails;

  @override
  void onInit() {
    // TODO: implement onInit
    getToken();
    super.onInit();
  }


  /* GET TOKEN */
  getToken() async {
    SharedPreferencesHelper _sharedPreferencesHelper =
    SharedPreferencesHelper();
    token = await _sharedPreferencesHelper.getAccessToken;
  }

  Future<void> getContactDetails(String decider) async {
   Result result = await DioClient()
        .get('Values/ContactDetails', token);
    if (result is SuccessState) {
       contactDetails = ContactDetails.fromJson(result.value);

       if(decider==MyString.whatsApp){
         openwhatsapp(contactDetails.whatsAppNumber);
       }else if(decider==MyString.call){
         await launch("tel://${contactDetails.contactTel}");
       }



    } else if (result is ErrorState) {
      errorMessage(result.msg);
    }
  }

  openwhatsapp(String whatsAppNumber) async{

    var whatsappURl_android = "https://wa.me/+973$whatsAppNumber/?text=${Uri.parse('Hi')}";
    var whatappURL_ios ="https://wa.me/+973$whatsAppNumber?text=${Uri.parse("Hi")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
       CustomDialogHelper.CustomDialogOkay(title: "Alert",description: "whatsapp no installed",okBtnFunction: (){
         Get.back();
       });
      }
    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        CustomDialogHelper.CustomDialogOkay(title: "Alert",description: "whatsapp no installed",okBtnFunction: (){
          Get.back();
        });
      }
    }
  }
}