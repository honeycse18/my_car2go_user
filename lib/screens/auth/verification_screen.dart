import 'package:car2gouser/controller/verification_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationScreenController>(
        init: VerificationScreenController(),
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context, hasBackButton: true),
              body: ScaffoldBodyWidget(
                  child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppGaps.screenPaddingValue),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /* <---- For extra 80px gap in height ----> */
                          AppGaps.hGap80,
                          /* <---- Verification icon and text ----> */
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppGaps.hGap20,
                                HighlightAndDetailTextWidget(
                                    textColor: AppColors.primaryColor,
                                    subtextColor: AppColors.bodyTextColor,
                                    slogan: AppLanguageTranslation
                                        .otpVerificationTransKey
                                        .toCurrentLanguage,
                                    subtitle:
                                        controller.verificationSubtitleText),
                              ],
                            ),
                          ),
                          AppGaps.hGap40,
                          /* <---- OTP input field ----> */
                          Pinput(
                            controller: controller.otpInputTextController,
                            length: 6,
                            focusedPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: controller.isOtpError
                                  ? const TextStyle(color: Colors.red)
                                  : const TextStyle(
                                      color: AppColors.primaryTextColor),
                              decoration: BoxDecoration(
                                // color: AppColors.shadeColor2,
                                border: controller.isOtpError
                                    ? Border.all(color: Colors.red, width: 1)
                                    : Border.all(
                                        color: AppColors.primaryColor,
                                        width: 2),
                                borderRadius: const BorderRadius.all(
                                    AppComponents.defaultBorderRadius),
                              ),
                            ),
                            errorPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                color: Colors.red,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: const BorderRadius.all(
                                    AppComponents.defaultBorderRadius),
                              ),
                            ),
                            submittedPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: controller.isOtpError
                                  ? AppTextStyles.bodyLargeSemiboldTextStyle
                                      .copyWith(color: Colors.red)
                                  : AppTextStyles.bodyLargeSemiboldTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                              decoration: BoxDecoration(
                                color: controller.isOtpError
                                    ? AppColors.errorColor.withOpacity(0.1)
                                    : Colors.white,
                                border: controller.isOtpError
                                    ? Border.all(color: Colors.red, width: 1)
                                    : Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1),
                              ),
                            ),
                            followingPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: controller.isOtpError
                                  ? const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)
                                  : const TextStyle(
                                      color: AppColors.primaryTextColor,
                                      fontWeight: FontWeight.w600),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: AppColors.fromBorderColor),
                                borderRadius: const BorderRadius.all(
                                    AppComponents.defaultBorderRadius),
                              ),
                            ),
                            defaultPinTheme: PinTheme(
                              width: 80,
                              height: 54,
                              textStyle: const TextStyle(
                                color: AppColors.primaryColor,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.primaryColor),
                              ),
                            ),
                            onCompleted: (pin) {
                              controller.onSendCodeButtonTap();
                            },
                          ),
                          if (controller.isOtpError)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Invalid Verification Code',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          AppGaps.hGap24,
                          controller.isDurationOver()
                              ? Center(
                                  child: TextButton(
                                      onPressed: controller.isDurationOver()
                                          ? () {
                                              controller.onResendButtonTap();
                                            }
                                          : controller.onResendButtonTap,
                                      child: Text(
                                          AppLanguageTranslation
                                              .resendOTPTransKey
                                              .toCurrentLanguage,
                                          style: AppTextStyles
                                              .bodyMediumTextStyle
                                              .copyWith(
                                            color: AppColors.primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w600,
                                          ))),
                                )
                              : Center(
                                  child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLanguageTranslation
                                          .resendCodeInTransKey
                                          .toCurrentLanguage,
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor),
                                    ),
                                    AppGaps.wGap10,
                                    Text(
                                        '${controller.otpTimerDuration.inMinutes.toString().padLeft(2, '0')}'
                                        ':${(controller.otpTimerDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                            color: AppColors.primaryColor))
                                  ],
                                )),
                          AppGaps.hGap30,
                        ],
                      ),
                    ),
                  ))
                ],
              )),
              /* <---- Bottom Bar----> */
              /*  bottomNavigationBar: CustomScaffoldBottomBarWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomStretchedTextButtonWidget(
                        buttonText: AppLanguageTranslation
                            .verifyOTPTransKey.toCurrentLanguage,
                        onTap: controller.onSendCodeButtonTap),
                    TextButton(
                        onPressed: controller.isDurationOver()
                            ? () {
                                controller.onResendButtonTap();
                              }
                            : /* null */ controller.onResendButtonTap,
                        child: Text(
                            AppLanguageTranslation
                                .resendOTPTransKey.toCurrentLanguage,
                            style: const TextStyle(
                                color: AppColors.primaryTextColor))),
                  ],
                ),
              ), */
            ));
  }
}
