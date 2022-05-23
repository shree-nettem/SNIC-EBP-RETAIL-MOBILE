import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/views/base/custom_silver_bar.dart';
import 'package:ebpv2/src/views/ui/contact_form/complaint_status/complaint_status_view.dart';
import 'package:ebpv2/src/views/ui/contact_form/contact_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_message/new_message_view.dart';

class ContactFormScreen extends StatelessWidget {
  ContactFormScreen({Key key}) : super(key: key);

  final ContactFormXController _controller = Get.put(ContactFormXController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (cntrl) {
          return Scaffold(
            backgroundColor: MyColors.MainColor,
            resizeToAvoidBottomInset: true,
            body: CustomScrollView(
              // keyboardDismissBehavior:
              //     ScrollViewKeyboardDismissBehavior.onDrag,
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                CustomSilverBar(
                  title: 'feedback'.tr,
                  info: "contact_form_help_text".tr,
                  isBackButtonExist: true,
                  isActionButtonExist: true,
                ),
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: _customerContactFormUI(context))
              ],
            ),
          );
        });
  }

  _customerContactFormUI(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          new Container(
            child: new TabBar(
              indicatorColor: MyColors.PrimaryColor,
              labelColor: MyColors.PrimaryColor,
              unselectedLabelColor: MyColors.GrayColor,
              controller: _controller.tabController,
              tabs: [
                new Tab(
                  text: 'new_message'.tr,
                ),
                new Tab(
                  text: 'complaint_status'.tr,
                ),
              ],
            ),
          ),
          Container(
            height: Get.height - 210 - MediaQuery.of(context).viewInsets.bottom,
            child: TabBarView(
              controller: _controller.tabController,
              children: [
                NewMessageView(),
                ComplaintStatusView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
