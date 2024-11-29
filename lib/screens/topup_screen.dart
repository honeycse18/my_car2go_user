import 'package:car2gouser/controller/topup_screen_controller.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/double.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:car2gouser/widgets/screen_widget/amount_box.dart';
import 'package:car2gouser/widgets/select_payment_method_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopUpScreenController>(
        init: TopUpScreenController(),
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.topUpTransKey.toCurrentLanguage,
                  hasBackButton: true),
              /* <-------- Body Content --------> */
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  /* <---- for extra 20px gap in height ----> */
                  const SliverToBoxAdapter(child: AppGaps.hGap20),
                  SliverToBoxAdapter(
                    child: CustomTextFormField(
                      controller: controller.topUpController,
                      prefixIcon: Text(AppComponents.currencySymbol),
                      prefixSpaceSize: 5,
                      labelText: AppLanguageTranslation
                          .howMuchDoYouWantToTopUpTransKey.toCurrentLanguage,
                      textInputType: TextInputType.number,
                      hintText: r'E.g 50',
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap12),
                  SliverToBoxAdapter(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AmountBox(
                          amount: 5.0.getCurrencyFormattedText(),
                          onTap: () => controller.onAmountTap(5),
                        ),
                        const HorizontalGap(19),
                        AmountBox(
                          amount: 15.0.getCurrencyFormattedText(),
                          onTap: () => controller.onAmountTap(15),
                        ),
                        const HorizontalGap(19),
                        AmountBox(
                          amount: 100.0.getCurrencyFormattedText(),
                          onTap: () => controller.onAmountTap(100),
                        ),
                        const HorizontalGap(19),
                        AmountBox(
                          amount: 1000.0.getCurrencyFormattedText(),
                          onTap: () => controller.onAmountTap(1000),
                        ),
                      ],
                    ),
                  )),
                  const SliverToBoxAdapter(child: AppGaps.hGap20),
                  SliverToBoxAdapter(
                    child: Text(
                      AppLanguageTranslation
                          .selectMethodTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap14),
                  /* <---- Payment Method----> */
                  SliverList.separated(
                    itemCount: AppSingleton
                        .instance.settings.activePaymentGateways.length,
                    itemBuilder: (context, index) {
                      final paymentOption = AppSingleton
                          .instance.settings.activePaymentGateways[index];
/*                       return SelectPaymentMethodWidget(
                        paymentOptionImage: paymentOption.logo,
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
                        // radioOnChange: (Value) {
                        //   controller.selectedPaymentMethodIndex = index;
                        //   controller.selectedPaymentOption = paymentOption;
                        //   controller.update();
                        // },
                        index: index,
                        selectedPaymentOptionIndex:
                            controller.selectedPaymentMethodIndex,
                      ); */
                      return TopUpPaymentMethodItemWidget(
                          onTap: () {
                            controller.selectedPaymentOption = paymentOption;
                            controller.update();
                          },
                          imageURL: paymentOption.logo,
                          name: paymentOption.name,
                          isSelected: controller.selectedPaymentOption.name ==
                              paymentOption.name);
                    },
                    separatorBuilder: (context, index) => AppGaps.hGap16,
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap10),
                  const SliverToBoxAdapter(child: AppGaps.hGap8),
                  /* <---- Top Up amount text field----> */
                ],
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomStretchedButtonWidget(
                    isLoading: controller.isLoading,
                    onTap: controller.shouldDisableTopUpButton
                        ? null
                        : controller.topUpWallet,
                    child: Text(
                      AppLanguageTranslation.topUpTransKey.toCurrentLanguage,
                    ),
                  ),
                  AppGaps.hGap20,
                ],
              )),
            ));
  }
}

class TopUpPaymentMethodItemWidget extends StatelessWidget {
  final String imageURL;
  final String name;
  final bool isSelected;
  final void Function()? onTap;
  const TopUpPaymentMethodItemWidget(
      {super.key,
      this.imageURL = '',
      this.name = '',
      this.isSelected = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        onTap: onTap,
        borderRadiusValue: 8,
        backgroundColor:
            isSelected ? AppColors.primaryColor.withOpacity(0.2) : null,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.fromBorderColor)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox.square(
                    dimension: 32,
                    child: CachedNetworkImageWidget(
                      imageURL: imageURL,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                  const HorizontalGap(12),
                  Expanded(
                      child: Text(name,
                          style: AppTextStyles.bodyMediumTextStyle
                              .copyWith(fontSize: 16)))
                ]),
          ),
        ));
  }
}
