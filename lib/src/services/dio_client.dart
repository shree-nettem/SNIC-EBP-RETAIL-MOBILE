import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ebpv2/src/models/error_message_model.dart';
import 'package:ebpv2/src/models/only_message_model.dart';
import 'package:ebpv2/src/services/result.dart';
import 'package:ebpv2/src/utilities/ui_constants.dart';
import 'package:ebpv2/src/views/base/custom_dialog_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';

import 'dio_exceptions.dart';

class DioClient {
  static const int timeOutInSeconds = 50;
  static const String devBaseURL = 'http://20.203.8.34/';
  static const String qaBaseURL = '';

  final Dio dio = Dio(BaseOptions(
      connectTimeout: 120 * 1000, // 120 seconds
      receiveTimeout: 120 * 1000 // 120 seconds
      ))
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print(options.uri);
      print(options.headers);
      print(options.data);
      return handler.next(options);
    }, onResponse: (response, handler) {
      print("RESPONSE ${response.data}");
      return handler.next(response);
    }, onError: (response, handler) {
      print(response.error);
      return handler.next(response);
    }));

  //GET
  Future<Result> get(String api, String token,
      {bool isLoading = true, bool keepLoading = false}) async {
    if (isLoading) showLoading();
    var url = devBaseURL + api;
    if (token != "" && token != null) {
      dio.options.headers["Authorization"] = "Bearer $token";
    }
    bool interNetaAvailale = await InternetConnectionChecker().hasConnection;
    if (interNetaAvailale == true) {
      try {
        Response response = await dio.get(
          url,
        );
        if (!keepLoading) {
          hideLoading();
        }

        return Result.success(response.data);
      } on DioError catch (error) {
        if (isLoading) hideLoading();
        if (error.response.statusCode == 400) {
          var errorData = ErrorMessageModel.fromJson(error.response.data);
          if (errorData is ErrorMessageModel) {
            return Result.error(errorData.message);
          }
        } else {
          var errorMessage = DioExceptions.fromDioError(error).toString();
          debugPrint("ERROR " + error.message);
          return Result.error(errorMessage);
        }
      }
    } else {
      if (!keepLoading) {
        hideLoading();
      }
      return Result.error("No internet connection");
    }
  }

  //POST
  Future<Result> postTest(String endPoint, var postMap) async {
    var url = endPoint;

    Response response;
    bool interNetaAvailale = await InternetConnectionChecker().hasConnection;
    if (interNetaAvailale == true) {
      try {
        response = await dio.post(url, data: postMap);
        print(response.statusCode);
        hideLoading();
        return Result.success(response.data);
      } on DioError catch (error) {
        hideLoading();
        debugPrint("ERROR " + error.response.statusMessage);
        if (error.response.statusCode == 404) {
          var errorData = ErrorMessageModel.fromJson(error.response.data);
          if (errorData is ErrorMessageModel) {
            return Result.error(errorData.modelState.errors[0]);
          }
        } else if (error.response.statusCode == 400) {
          var errorData = OnlyMessageModel.fromJson(error.response.data);
          if (errorData is OnlyMessageModel) {
            return Result.error(errorData.message);
          }
        } else {
          var errorMessage = DioExceptions.fromDioError(error).toString();
          debugPrint(error.message);
          return Result.error(errorMessage);
        }
      }
    } else {
      hideLoading();

      return Result.error("No internet connection");
    }
  }

  //POST
  Future<Result> post(
    String endPoint,
    var postMap, {
    bool isPostData = true,
    String token,
    bool isEBPAPI = true,
    bool isHeaderJsonType = false,
    bool showLongWaitingMessage = false,
    bool isLoading = true,
    String description = "",
  }) async {
    var url = devBaseURL + endPoint;
    if (isLoading) {
      showLoading(
          showLongWaitingMessage: showLongWaitingMessage,
          description: description);
    }

    if (!isHeaderJsonType) {
      dio.options.headers['content-Type'] = Headers.formUrlEncodedContentType;
    } else {
      dio.options.headers['content-Type'] = Headers.jsonContentType;
    }
    if (!isEBPAPI) {
      dio.options.headers["token"] = "$token";
      url = endPoint;
    }
    if (token != "" && token != null && isEBPAPI) {
      dio.options.headers["Authorization"] = "Bearer $token";
    }
    Response response;
    bool interNetaAvailale = await InternetConnectionChecker().hasConnection;
    if (interNetaAvailale == true) {
      try {
        if (isPostData) {
          response = await dio.post(url, data: postMap);
        } else {
          response = await dio.post(url);
        }
        print(response.statusCode);
        hideLoading();
        return Result.success(response.data);
      } on DioError catch (error) {
        hideLoading();
        if (error.response.statusCode == 404) {
          var errorData = ErrorMessageModel.fromJson(error.response.data);
          if (errorData is ErrorMessageModel) {
            return Result.error(errorData.modelState.errors[0]);
          }
        } else if (error.response.statusCode == 400) {
          var errorData = OnlyMessageModel.fromJson(error.response.data);
          if (errorData is OnlyMessageModel) {
            return Result.error(errorData.message);
          }
        } else {
          var errorMessage = DioExceptions.fromDioError(error).toString();
          debugPrint(error.message);
          return Result.error(errorMessage);
        }
      }
    } else {
      hideLoading();

      return Result.error("No internet connection");
    }
  }

  //PUT
  Future<Result> put(String api, String token,
      {bool isLoading = true, bool keepLoading = false}) async {
    if (isLoading) showLoading();
    var url = devBaseURL + api;
    if (token != "" && token != null) {
      dio.options.headers["Authorization"] = "Bearer $token";
    }
    bool interNetaAvailale = await InternetConnectionChecker().hasConnection;
    if (interNetaAvailale == true) {
      try {
        Response response = await dio.put(url, data: {});
        if (!keepLoading) hideLoading();

        return Result.success(response.data);
      } on DioError catch (error) {
        if (isLoading) hideLoading();
        if (error.response.statusCode == 400) {
          var errorData = ErrorMessageModel.fromJson(error.response.data);
          if (errorData is ErrorMessageModel) {
            return Result.error(errorData.message);
          }
        } else {
          var errorMessage = DioExceptions.fromDioError(error).toString();
          debugPrint("ERROR " + error.message);
          return Result.error(errorMessage);
        }
      }
    } else {
      if (isLoading) {
        hideLoading();
      }
      return Result.error("No internet connection");
    }
  }

  Future<Result> postFile(image, endPoint, token) async {
    try {
      var url = devBaseURL + endPoint;
      showLoading();
      dio.options.headers = {"Authorization": "Bearer " + token};

      Map<String, MultipartFile> fileMap = {};
      String fileName = image.path;
      fileMap['image'] = MultipartFile(image.openRead(), await image.length(),
          filename: fileName);
      var formData = FormData.fromMap(fileMap);
      bool interNetaAvailale = await InternetConnectionChecker().hasConnection;
      if (interNetaAvailale == true) {
        Response response = await dio.post(
          url,
          data: formData,
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
        hideLoading();
        return Result.success(response.data);
      } else {
        hideLoading();

        return Result.error("No internet connection");
      }
    } on DioError catch (error) {
      hideLoading();
      var errorMessage = DioExceptions.fromDioError(error).toString();
      print(errorMessage);
      return Result.error(errorMessage);
    }
  }

  showLoading(
      {bool showLongWaitingMessage = false,
      String tittle = "",
      String description = ""}) {
    CustomDialogHelper.showLoading(
        showLongWaitingMessage: showLongWaitingMessage,
        description: description);
  }

  hideLoading() {
    CustomDialogHelper.hideLoading();
  }

/*
  Future<PDFDocument> loadPDFDocument(String api) async {
    if (api == null || api == "") {
      return null;
    }
    print(devBaseURL + api);
    return await PDFDocument.fromURL(devBaseURL + api);
  }
*/

  Future downloadFile(
    String imageSrc, {
    String imgName = "Ecard",
    String imageFormat = "png",
    bool needLoadingUI = true,
  }) async {
    if (needLoadingUI) showLoading();
    bool interNetaAvailale = await InternetConnectionChecker().hasConnection;
    if (interNetaAvailale == true) {
      try {
        var response = await Dio()
            .get(imageSrc, options: Options(responseType: ResponseType.bytes));
        final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: imgName);
      } catch (e) {
        return null;
      }
    } else {
      if (needLoadingUI) {
        hideLoading();
      }
      return Result.error("No internet connection");
    }

    if (needLoadingUI) hideLoading();
    errorMessage("fileDownloaded".tr);

    return true;
  }

  Future downloadTempFile(
    String imageSrc, {
    String imgName = "Ecard",
    String imageFormat = "png",
    bool needLoadingUI = true,
  }) async {
    if (needLoadingUI) showLoading();
    Dio dio = Dio();
    var documentDirectory = await getTemporaryDirectory();
    final myImagePath = '${documentDirectory.path}/SNIC';
    var datetime = DateTime.now();
    var filePathAndName =
        myImagePath + '/$imgName${datetime.toString()}.$imageFormat';
    bool interNetaAvailale = await InternetConnectionChecker().hasConnection;
    if (interNetaAvailale == true) {
      try {
        await dio.download(
          imageSrc,
          filePathAndName,
        );
      } catch (e) {
        return null;
      }
    } else {
      if (needLoadingUI) {
        hideLoading();
      }

      return Result.error("No internet connection");
    }

    if (needLoadingUI) hideLoading();
    // downloadFile function returns path where image has been downloaded
    return filePathAndName;
  }
}


// bool result = await InternetConnectionChecker().hasConnection;
// if(result == true) {
//   print('YAY! Free cute dog pics!');
// } else {
//   print('No internet :( Reason:');
//   print(InternetConnectionChecker().lastTryResults);
// }