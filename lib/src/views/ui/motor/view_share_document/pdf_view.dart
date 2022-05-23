import 'dart:io';

import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/motor/view_share_document/view_share_doc_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFPreview extends StatelessWidget {
  File file;
  PDFPreview(this.file);
  ViewShareDocController controller=Get.put(ViewShareDocController());

  @override
  Widget build(BuildContext context) {
    print(this.file.path);
    return Scaffold(

      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            //change it to show only the file name (save file pattern changed)
            title: (file.path.split('/').last).replaceAll("files", "").split("]").last.replaceAll(new RegExp(r"\d"), "").replaceAll("_", ""),
            isBackButtonExist: true,
            isActionButtonExist: false,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _viewDocumentUI(context),
          )
        ],
      ),
    );
  }

  _viewDocumentUI(BuildContext context) {
    return GetBuilder(
      init: controller,
        builder: (_) {
          return Container(
            child: Column(
              children: [
                Flexible(
                    flex: 8,
                    child: Container(
                      child: Center(child: SfPdfViewer.file(file))
                    )),
                Flexible(
                    flex: 3,
                    child: Container(
                      child: Center(
                        child: _buildActionButton(context, 'share'.tr,
                            svgImage: Images.share_white, onClick: () {
                              controller.shareDocument(file);
                            }),
                      ),
                    ))
              ],
            ),
          );
        });
  }

  Widget _buildActionButton(BuildContext context, String title,
      {String svgImage, Function onClick}) {
    return Center(
      child: CustomButton(
        title: title,
        width: MediaQuery.of(context).size.width / 2 + 50,
        fontSize: 12,
        paddingWidth: 10,
        height: 40,
        svgImage: svgImage,
        buttonAction: onClick,
      ),
    );

  }
}



