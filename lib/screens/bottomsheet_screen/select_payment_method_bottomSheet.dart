import 'package:car2gouser/controller/select_payment_method_bottomsheet_controller.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/select_payment_method_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPaymentMethodBottomSheet extends StatelessWidget {
  const SelectPaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectPaymentMethodBottomsheetController>(
        init: SelectPaymentMethodBottomsheetController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                /*<------- AppBar ------>*/
                AppBar(
                  backgroundColor: AppColors.backgroundColor,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  leading: Center(
                    child: CustomIconButtonWidget(
                        onTap: () {
                          Get.back();
                        },
                        hasShadow: true,
                        child: const SvgPictureAssetWidget(
                          AppAssetImages.arrowLeftSVGLogoLine,
                          color: AppColors.primaryTextColor,
                          height: 18,
                          width: 18,
                        )),
                  ),
                  title: Text(AppLanguageTranslation
                      .paymentMethodTransKey.toCurrentLanguage),
                ),
                AppGaps.hGap27,
                /*<------- Select payment method option ------>*/
                Expanded(
                    child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      itemCount: FakeData.paymentOptionList.length,
                      itemBuilder: (context, index) {
                        final paymentOption = FakeData.paymentOptionList[index];
                        return SelectPaymentMethodWidget(
                          paymentOptionImage: paymentOption.paymentImage,
                          cancelReason: paymentOption,
                          selectedCancelReason: controller.paymentOptionList,
                          paymentOption: paymentOption.viewAbleName,
                          hasShadow: controller.selectedReasonIndex == index,
                          onTap: () {
                            controller.selectedReasonIndex = index;
                            controller.paymentOptionList = paymentOption;
                            controller.update();
                          },
                          radioOnChange: (Value) {
                            controller.selectedReasonIndex = index;
                            controller.paymentOptionList = paymentOption;
                            controller.update();
                          },
                          index: index,
                          selectedPaymentOptionIndex:
                              controller.selectedReasonIndex,
                        );
                      },
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    ),
                  ],
                )),
                /*<------- Select option button ------>*/
                CustomStretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation
                      .selectOptionTransKey.toCurrentLanguage,
                  onTap: controller.onSubmitButtonTap,
                )
              ]),
            ));
  }
}
