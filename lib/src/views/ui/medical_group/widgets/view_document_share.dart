import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/images.dart';
import 'package:ebpv2/src/utilities/strings.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/medical_group/widgets/view_document_and_share_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewDocumentAndShareScreen extends StatelessWidget {
  ViewDocumentAndShareScreen({Key key}) : super(key: key);

  final ViewDocumentAndShareXController _controller =
      Get.put(ViewDocumentAndShareXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSilverBar(
            title: _controller.viewTitle,
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
        init: _controller,
        builder: (_) {
          return Container(
            child: Column(
              children: [
                Flexible(
                    flex: 8,
                    child: Container(
                      child: Center(
                        child: _controller.endPointString.isNotEmpty ||
                                _controller.fullPathUrl.isNotEmpty
                            ? (_controller.fileType == "jpg" ||
                                    _controller.fileType == "jpeg" ||
                                    _controller.fileType == "png")
                                ? Container(
                                    // height: 200,
                                    width: Get.width,
                                    child: CachedNetworkImage(
                                      imageUrl: _controller.getDocumentUri(),
                                      fit: BoxFit.fitWidth,
                                      errorWidget: (context, value, data) =>
                                          Container(
                                        child: Text(""),
                                      ),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SfPdfViewer.network(
                                    _controller.getDocumentUri(),
                                    key: _controller.pdfViewerKey,
                                  )
                            : Container(),
                      ),
                    )),
                Flexible(
                    flex: 3,
                    child: Container(
                      child: Center(
                        child: _buildActionButton(context, "share".tr,
                            svgImage: Images.share_white, onClick: () {
                          if (_controller.endPointString.isNotEmpty ||
                              _controller.fullPathUrl.isNotEmpty)
                            _controller.sharingData();
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
