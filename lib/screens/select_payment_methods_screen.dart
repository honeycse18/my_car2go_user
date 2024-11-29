import 'package:car2gouser/controller/select_payment_methods_screen_controller.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/select_payment_method_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPaymentMethodsScreen extends StatelessWidget {
  const SelectPaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectPaymentMethodScreenController>(
        global: false,
        init: SelectPaymentMethodScreenController(),
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: AppLanguageTranslation
                      .paymentMethodTransKey.toCurrentLanguage),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap24,
                  ),
                  /* <---- Payment option ----> */
                  SliverList.separated(
                    itemCount: FakeData.paymentOptionLists.length,
                    itemBuilder: (context, index) {
                      final paymentOption = FakeData.paymentOptionLists[index];
                      return SelectPaymentMethodWidget(
                        paymentOptionImage: paymentOption.paymentImage,
                        cancelReason: paymentOption,
                        selectedCancelReason: controller.selectedPaymentOption,
                        paymentOption: paymentOption.viewAbleName,
                        hasShadow:
                            controller.selectedPaymentMethodIndex == index,
                        onTap: () {
                          controller.selectedPaymentMethodIndex = index;
                          controller.selectedPaymentOption = paymentOption;
                          controller.update();
                        },
                        radioOnChange: (Value) {
                          controller.selectedPaymentMethodIndex = index;
                          controller.selectedPaymentOption = paymentOption;
                          controller.update();
                        },
                        index: index,
                        selectedPaymentOptionIndex:
                            controller.selectedPaymentMethodIndex,
                      );
                    },
                    separatorBuilder: (context, index) => AppGaps.hGap16,
                  ),
                ],
              )),
              /* <-------- Bottom bar--------> */
              bottomNavigationBar: ScaffoldBodyWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomStretchedButtonWidget(
                      onTap: controller.paymentAcceptCarRentRequest,
                      child: Text(AppLanguageTranslation
                          .paymentTransKey.toCurrentLanguage),
                    ),
                    AppGaps.hGap10,
                  ],
                ),
              ),
            ));
  }
}
