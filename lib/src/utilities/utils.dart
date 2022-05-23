import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/ui/motor/view_share_document/pdf_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ui_constants.dart';

class Utils {
  static bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return false;
    else
      return true;
  }

  static bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static showProgressDialog(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: (title != null) ? false : true,
                    child: Text(title,
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Row(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(width: 16.0),
                      Text(msg, style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /* SHOW ALERT DIALOG FOR HELP */
  static Future<bool> showAlertDialogHelp(
      BuildContext context, String msg, String okTitle,
      {String title,
      Color backgroundColor = Colors.white,
      Function okHandler,
      String cancelTitle,
      Function cancelHandler}) {
    return Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            useRootNavigator: false,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Visibility(
                  visible: (title != null) ? false : true,
                  child: Text(title, textAlign: TextAlign.center),
                ),
                content: Text(msg),
                actions: _alertActions(okTitle, okHandler, context,
                    cancelTitle: cancelTitle, cancelHandler: cancelHandler),
              );
            })
        : showDialog(
            context: context,
            useRootNavigator: false,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return _alertDialogHelp(context, msg, okTitle,
                  title: title,
                  backgroundColor: backgroundColor,
                  okHandler: okHandler,
                  cancelTitle: cancelTitle,
                  cancelHandler: cancelHandler);
            },
          );
  }

  static Widget _alertDialogHelp(
      BuildContext context, String msg, String okTitle,
      {String title = 'Alert',
      Color backgroundColor = Colors.white,
      Function okHandler,
      String cancelTitle,
      Function cancelHandler}) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label(
                "Help",
                fontWeight: FontWeight.bold,
                fontSize: LargeFontSize,
              ),
              IconButton(
                icon: new Icon(Icons.close),
                color: MyColors.titleColor,
                highlightColor: Colors.black54,
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
          addVerticalHeight(8.0),
          Divider(
            color: MyColors.titleColor,
          ),
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            label(
              msg,
              fontSize: MediumFontSize,
              textAlign: TextAlign.center,
            ),
            addVerticalHeight(15.0),
            GestureDetector(
              onTap: () {
                launch("mailto://EBPSupport@snic.com.bh");
              },
              child: label(
                "EBPSupport@snic.com.bh",
                fontSize: MediumFontSize,
                textAlign: TextAlign.center,
                color: MyColors.themeColor,
              ),
            ),
            addVerticalHeight(15.0),
          ],
        ),
      ),
    );
  }

  static List<Widget> _alertActions(
      String okTitle, Function okHandler, BuildContext context,
      {String cancelTitle, Function cancelHandler}) {
    return [
      TextButton(
          child: Text(okTitle),
          onPressed: () {
            Navigator.of(context).pop(true);
            if (okHandler != null) okHandler();
          }),
      if (cancelTitle != null)
        TextButton(
            child: Text(cancelTitle),
            onPressed: () {
              Navigator.of(context).pop(false);
              if (cancelHandler != null) cancelHandler();
            }),
    ];
  }

  static Future<bool> showAlertDialog(
      BuildContext context, String msg, String okTitle,
      {String title,
      Color backgroundColor = Colors.white,
      Function okHandler,
      String cancelTitle,
      Function cancelHandler}) {
    return Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            useRootNavigator: false,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Visibility(
                  visible: (title != null) ? false : true,
                  child: label(
                    title,
                    fontSize: MediumFontSize,
                    textAlign: TextAlign.center,
                  ),
                ),
                content: label(
                  msg,
                  fontSize: MediumFontSize,
                  textAlign: TextAlign.center,
                ),
                actions: _alertActions(okTitle, okHandler, context,
                    cancelTitle: cancelTitle, cancelHandler: cancelHandler),
              );
            })
        : showDialog(
            context: context,
            useRootNavigator: false,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return _alertDialog(context, msg, okTitle,
                  title: title,
                  backgroundColor: backgroundColor,
                  okHandler: okHandler,
                  cancelTitle: cancelTitle,
                  cancelHandler: cancelHandler);
            },
          );
  }

  static Widget _alertDialog(BuildContext context, String msg, String okTitle,
      {String title,
      Color backgroundColor = Colors.white,
      Function okHandler,
      String cancelTitle,
      Function cancelHandler}) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      title: label(
        title,
        fontSize: RegularFontSize,
        textAlign: TextAlign.left,
        color: Colors.black,
      ),
      content: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: label(
          msg,
          fontSize: MediumFontSize,
          textAlign: TextAlign.left,
          color: Colors.black,
        ),
      ),
      actions: _alertActions(okTitle, okHandler, context,
          cancelTitle: cancelTitle, cancelHandler: cancelHandler),
    );
  }

  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  /// This decides which day will be enabled
  /// This will be called every time while displaying day in calender.
  static bool decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 6))))) {
      // if (day.weekday == 5 || day.weekday == 6) {
      //   return false;
      // } else {
      //   return true;
      // }
      return true;
    }
    return false;
  }

  static Future<String> selectDateAddDays(BuildContext context, initialDate,
      {DateTime firstDate, DateTime lastDate}) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      return DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  static Future<String> selectDate(BuildContext context, DateTime selectedDate,
      {DateTime firstDate, DateTime lastDate}) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime(2101),
    );
    if (picked != null) {
      return DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  static Future<String> initialSelectDate(BuildContext context,
      DateTime selectedDate, DateTime initialSetDate, DateTime lastSetDate,
      {bool isF = false}) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: initialSetDate,
        lastDate: lastSetDate);
    if (picked != null) {
      debugPrint(DateFormat('yyyy-MM-dd').format(picked));
      return DateFormat('yyyy-MM-ddTHH:mm:ss').format(picked);
    } else {
      return null;
    }
  }

  //ONLY FOR DISPLAY PURPOSE
  static String formattedDate(date) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    print("DATE " + tempDate.toString());
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  //ONLY FOR DISPLAY PURPOSE
  static String formattedDateFromString(String date) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    print("DATE " + tempDate.toString());
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  //ONLY TO PASS THE DATE TO SERVER
  static String serverFormattedDate(date) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final String formatted = formatter.format(tempDate);
    print("FORMATTED DATE " + formatted.toString());
    return formatted;
  }

  static String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd hh:mm:ss.sss');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static DateTime convertStringDateToDate(String date) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    return tempDate;
  }

  static String getOnlyYear(String date) {
    final DateTime parsedDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(parsedDate);
    print(formatted);
    return formatted;
  }

  static String getOnlyDate(String date) {
    final DateTime parsedDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    final String formatted = formatter.format(parsedDate);
    print(formatted);
    return formatted;
  }

  static String getOnlyFormattedDate(String date) {
    final DateTime parsedDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('MMM yyyy');
    final String formatted = formatter.format(parsedDate);
    print(formatted);
    return formatted;
  }

  //when server date is in dd/mm/yyyy
  static String formatDateTimeDisplay(String date) {
    final DateFormat displayFormatter = DateFormat('dd/MM/yyyy hh:mm:ss');
    final DateFormat serverFormatter = DateFormat('dd/MM/yyyy');
    final DateTime displayDate = displayFormatter.parse(date);
    final String formatted = serverFormatter.format(displayDate);
    return formatted;
  }

  static bool isAdult(String birthDateString) {
    String datePattern = "yyyy-MM-dd";

    // Current time - at this moment
    DateTime today = DateTime.now();

    // Parsed date to check
    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 18,
      birthDate.month,
      birthDate.day,
    );

    return adultDate.isBefore(today);
  }

  static saveFileFromString(
      String buffer, bool isViewSelected, String fileName) async {
    final encodedStr = buffer;
    Uint8List bytes = base64.decode(encodedStr);

    File file;

    if (Platform.isAndroid) {
      String fullPath;
      if (!fileName.contains(".pdf")) {
        fullPath = '/storage/emulated/0/Download/${UniqueKey()}$fileName.pdf';
      } else {
        fullPath = '/storage/emulated/0/Download/${UniqueKey()}$fileName';
      }
      file = File("$fullPath");
      await file.writeAsBytes(bytes);
      final Directory extDir = await getExternalStorageDirectory();
      String fullPath1;
      if (!fileName.contains(".pdf")) {
        fullPath1 = '${extDir.path.toString()}${UniqueKey()}$fileName.pdf';
        ;
      } else {
        fullPath1 = '${extDir.path.toString()}${UniqueKey()}$fileName';
        ;
      }
      File file1 = File("$fullPath1");
      await file1.writeAsBytes(bytes).then((value) => {
            if (isViewSelected) {Get.to(PDFPreview(file1))}
          });
    } else if (Platform.isIOS) {
      Directory loc = await getApplicationDocumentsDirectory();
      String fullPath;
      if (!fileName.contains(".pdf")) {
        fullPath = '${loc.path.toString()}/${UniqueKey()}$fileName.pdf';
        ;
      } else {
        fullPath = '${loc.path.toString()}/${UniqueKey()}$fileName';
      }
      file = File("$fullPath");
      await file.writeAsBytes(bytes);
      if (isViewSelected) {
        Get.to(PDFPreview(file));
      }
    }
  }

  static void saveALLRecords(String buffer, int i, String fileName) async {
    Uint8List bytes = base64.decode(buffer);
    File file;
    if (Platform.isAndroid) {
      String fullPath =
          '/storage/emulated/0/Download/$fileName${UniqueKey()}.pdf';
      file = File("$fullPath");
    } else if (Platform.isIOS) {
      Directory loc = await getApplicationDocumentsDirectory();
      String fullPath = '${loc.path.toString()}/$fileName${UniqueKey()}.pdf';
      print(fullPath);
      file = File("$fullPath");
    }

    await file.writeAsBytes(bytes);
  }

  static getColor(int index) {
    switch (index) {
      case 0:
        return Color.fromRGBO(64, 162, 190, 1);
        break;
      case 1:
        return Color.fromRGBO(0, 15, 95, 1);
        break;
      case 2:
        return Color.fromRGBO(247, 199, 40, 1);
        break;
      case 3:
        return Color.fromRGBO(214, 125, 122, 1);
        break;
      case 4:
        return Color.fromRGBO(167, 214, 132, 1);
        break;
      case 5:
        return Colors.orange;
        break;
      case 6:
        return Colors.pink;
        break;
      case 7:
        return Colors.pinkAccent;
        break;
      case 8:
        return Colors.grey;
      default:
        return 'secondary';
    }
  }

  static String getJumioErrorMessage(String errorCode) {
    switch (errorCode) {
      case "A10000":
        return "We have encountered a network communication problem";
        break;
      case "B10000":
        return "Authentication failed";
        break;
      case "C10401":
        return "Authentication failed";
        break;
      case "D10403":
        return "Authentication failed";
        break;
      case "E20000":
        return "No Internet connection available";
        break;
      case "F00000":
        return "Scanning not available this time, please contact the app vendor";
        break;
      case "G00000":
        return "Cancelled by end-user";
        break;
      case "H00000":
        return "The camera is currently not available";
        break;
      case "I00000":
        return "Certificate not valid anymore. Please update your application";
      case "K10400":
        return "Unsupported document code defined. Please contact Jumio support";
      default:
        return '';
    }
  }

  static Future<TimeOfDay> timePicker(BuildContext context) {
    return showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
  }

  static void showPickerImagePicker(
      {Function galleryBtn,
      Function cameraBtn,
      bool hideCamerabutton = false}) {
    showModalBottomSheet(
      context: Get.context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: label("gallery".tr, fontSize: MediumFontSize),
                    onTap: galleryBtn),
                if (!hideCamerabutton)
                  new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: label('camera'.tr, fontSize: MediumFontSize),
                      onTap: cameraBtn),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) +
        newFileName +
        path.split('/').last;
    return file.rename(newPath);
  }
}
