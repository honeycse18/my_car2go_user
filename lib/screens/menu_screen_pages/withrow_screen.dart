// import 'package:car2gouser/controller/introscreen_controller.dart';
import 'package:car2gouser/controller/menu_screen_controller/withrow_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/screen_widget/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithrowScreenController>(
      init: WithrowScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /*<------- AppBar  ------>*/
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText: AppLanguageTranslation.withdrawTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        /*<------- Body Content ------>*/
        body: ScaffoldBodyWidget(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGaps.hGap30,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLanguageTranslation.withdrawTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallBoldTextStyle
                          .copyWith(color: Colors.black),
                    ),
                    /*<------- Amount text field for withdraw ------>*/
                    CustomTextFormField(
                      controller: controller.amountTextEditingController,
                      labelText: AppLanguageTranslation
                          .howMuchWantWithdrawTransKey.toCurrentLanguage,
                      hintText: 'E.g: \$50',
                      prefixIcon: const SvgPictureAssetWidget(
                          AppAssetImages.emailSVGLogoLine),
                    ),
                    /*<------- Select withdraw method ------>*/
                    Text(
                        AppLanguageTranslation
                            .selectMethodTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleBoldTextStyle),
                    AppGaps.hGap10,
                    Container(
                      height: 56,
                      width: 392,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.bodyTextColor)),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: TransactionWidget(
                            dateTime: DateTime.now(),
                            title: "**** **** **** 8970",
                            icon: const SvgPictureAssetWidget(
                              AppAssetImages.masterCardSvgFillIcon,
                            ),
                            text1: "Expires: 12/26",
                            text2: "",
                            backColor: Colors.transparent,
                          )),
                    ),
                    AppGaps.hGap10,
                    Container(
                      height: 56,
                      width: 392,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.bodyTextColor)),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: TransactionWidget(
                            dateTime: DateTime.now(),
                            title: "**** **** **** 8970",
                            icon: const SvgPictureAssetWidget(
                              AppAssetImages.paypalSvgFillIcon,
                            ),
                            text1: "Expires: 12/26",
                            text2: "",
                            backColor: Colors.transparent,
                          )),
                    ),
                    /* <---- for extra 10px gap in height ----> */
                    AppGaps.hGap10,
                    Container(
                      height: 56,
                      width: 392,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.bodyTextColor)),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: TransactionWidget(
                            dateTime: DateTime.now(),
                            title: "**** **** **** 8970",
                            icon: const SvgPictureAssetWidget(
                              AppAssetImages.visaSvgFillIcon,
                            ),
                            text1: "Expires: 12/26",
                            text2: "",
                            backColor: Colors.transparent,
                          )),
                    ),
                    AppGaps.hGap10,
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
