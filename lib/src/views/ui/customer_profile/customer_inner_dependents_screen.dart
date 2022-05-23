import 'package:ebpv2/src/utilities/colors.dart';
import 'package:ebpv2/src/utilities/dimensions.dart';
import 'package:ebpv2/src/views/base/custom_button.dart';
import 'package:ebpv2/src/views/base/custom_label.dart';
import 'package:ebpv2/src/views/base/custom_spacer.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/add_dependent_form_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_controllers/dependent_controller.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_model.dart';
import 'package:ebpv2/src/views/ui/customer_profile/widgets/add_dependent_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class InnerDependentsView extends StatelessWidget {
  final DependentXController _controller = Get.put(DependentXController());
  final AddDependentFormXController addDependentFormXController =
      Get.put(AddDependentFormXController());

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('dependant-widget-key'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.1) {
          debugPrint("${info.visibleFraction} of my widget is visible");
          addDependentFormXController.getCountries();
          _controller.addingDataFromApi();
        } else {
          debugPrint("${info.visibleFraction} of my widget is invisible");
        }
      },
      child: GetBuilder(
          init: _controller,
          builder: (_) {
            return _controller.isFormView.value
                ? AddDependentForm()
                : ListView.builder(
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: _controller.dependents != null
                        ? _controller.dependents.details.dependents.length + 1
                        : 1,
                    itemBuilder: (context, index) {
                      if (index ==
                          (_controller.dependents != null
                              ? _controller.dependents.details.dependents.length
                              : 0)) {
                        return _buildAddDependentButton(context);
                      } else {
                        return _cardViewUI(
                            _controller.dependents.details.dependents[index],
                            _controller.dependents.details);
                      }
                    });
          }),
    );
  }

  Widget _cardViewUI(Dependents dependent, Details details) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 5, 32, 5),
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: MyColors.GrayColor,
            blurRadius: 22.0,
            offset: Offset(
              0.0,
              6.0,
            ),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          _controller.addDependentClicked();
          _controller.isEditingChanging();
          Get.find<AddDependentFormXController>()
              .setBeneficiaryTextFields(dependent);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 2,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 17.5, 15, 17.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CustomLabel(
                        title: "${dependent.firstName}" +
                            " ${dependent.middleName ?? ""}" +
                            " ${dependent.lastName}",
                        color: MyColors.PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                CustomSpacer(
                  value: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                CustomLabel(
                  title: _controller.updateRelation(dependent.relationshipType),
                  color: MyColors.PrimaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* ADD NEW DEPENDET BUTTON */
  Widget _buildAddDependentButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_DEFAULT,
          bottom: Dimensions.PADDING_SIZE_DEFAULT),
      child: Center(
        child: CustomButton(
          title: 'add_new_dependent'.tr,
          width: MediaQuery.of(context).size.width - 64,
          fontSize: 12,
          height: 40,
          buttonAction: () {
            _controller.addDependentClicked();
            Get.find<AddDependentFormXController>()
                .setBeneficiaryTextFields(null);
          },
        ),
      ),
    );
  }
}
