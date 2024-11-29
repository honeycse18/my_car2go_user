import 'dart:io';

import 'package:car2gouser/controller/login_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
        global: false,
        init: LoginScreenController(),
        builder: (controller) => CustomScaffold(
              /* <---- AppBar----> */
              appBar: CoreWidgets.appBarWidget(
                  titleText:
                      AppLanguageTranslation.loginTransKey.toCurrentLanguage,
                  screenContext: context,
                  hasBackButton: true),
              /* <---- Body Content----> */
              body: ScaffoldBodyWidget(
                  child: Column(
                children: [
                  /* <---- For extra 32px gap in height ----> */
                  AppGaps.hGap32,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLanguageTranslation
                                .welcomeAppTitleTransKey.toCurrentLanguage,
                            style: AppTextStyles.titleXBoldTextStyle
                                .copyWith(color: AppColors.primaryTextColor),
                          ),
                          /* <---- For extra 8px gap in height ----> */
                          AppGaps.hGap8,
                          Text(
                            controller.phoneMethod
                                ? AppLanguageTranslation
                                    .enterYourPhoneToCreateAccountTransKey
                                    .toCurrentLanguage
                                : AppLanguageTranslation
                                    .enterYourEmailToCreateAccountTransKey
                                    .toCurrentLanguage,
                            style: AppTextStyles.bodyLargeTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                          /* <---- for extra 53px gap in height ----> */
                          AppGaps.hGap53,
                          controller.phoneMethod
                              /*<------- Text field for login with phone number  ------>*/
                              ? CustomPhoneNumberTextFormFieldWidget(
                                  initialCountryCode:
                                      controller.currentCountryCode,
                                  controller:
                                      controller.phoneTextEditingController,
                                  hintText: '0197464646',
                                  onCountryCodeChanged:
                                      controller.onCountryChange,
                                )
                              /*<------- Text field for login with email address  ------>*/
                              : CustomTextFormField(
                                  controller:
                                      controller.emailTextEditingController,
                                  labelText: AppLanguageTranslation
                                      .emailAddressTransKey.toCurrentLanguage,
                                  hintText: 'E.g: demo.example@gmail.com',
                                  prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.emailSVGLogoLine,
                                    color: AppColors.secondaryFont2Color,
                                  ),
                                ),
                          /* <---- For extra 32px gap in height ----> */
                          AppGaps.hGap32,
                          CustomStretchedButtonWidget(
                            onTap: controller.onContinueButtonTap,
                            child: Text(AppLanguageTranslation
                                .continueTransKey.toCurrentLanguage),
                          ),
                          /* <---- For extra 32px gap in height ----> */
                          AppGaps.hGap32,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 0.5,
                                  decoration: const BoxDecoration(
                                      color: AppColors.bodyTextColor),
                                ),
                              ),
                              /* <---- For extra 8px gap in width ----> */
                              AppGaps.wGap8,
                              Text(
                                AppLanguageTranslation
                                    .orWithTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyMediumTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                              /* <---- For extra 8px gap in width ----> */
                              AppGaps.wGap8,
                              Expanded(
                                child: Container(
                                  height: 0.5,
                                  decoration: const BoxDecoration(
                                      color: AppColors.bodyTextColor),
                                ),
                              ),
                            ],
                          ),
                          /* <---- For extra 32px gap in height ----> */
                          AppGaps.hGap32,
                          /*<-------'Continue with email'  button , if anyone want to login with email address.  ------>*/
                          controller.phoneMethod
/*                               ? CustomStretchedOutlinedTextButtonWidget(
                                  image: Image.asset('assets/images/Email.png'),
                                  onTap: controller.onMethodButtonTap,
                                  buttonText: AppLanguageTranslation
                                      .continueWithEmailTransKey
                                      .toCurrentLanguage)
                              : CustomStretchedOutlinedTextButtonWidget(
                                  /*<-------  'continue with phone' button, if anyone want to login with phone number------>*/
                                  image: Image.asset('assets/images/Phone.png'),
                                  onTap: controller.onMethodButtonTap,
                                  buttonText: AppLanguageTranslation
                                      .continueWithPhoneTransKey
                                      .toCurrentLanguage), */
                              /* <-------- Login with email button --------> */

                              ? /* CustomStretchedOutlinedTextButtonWidget(
                                  image: Image.asset('assets/images/Email.png'),
                                  onTap: controller
                                      .onMethodButtonTap /* () {
                                      // Get.toNamed(AppPageNames.emailLogInScreen);
                                    } */
                                  ,
                                  buttonText: AppLanguageTranslation
                                      .continueWithEmailTransKey) */

                              ColoredOutlinedIconTextButton(
                                  icon: const SvgPictureAssetWidget(
                                      AppAssetImages.emailSVGLogoLine,
                                      color: AppColors.primaryTextColor),
                                  text: AppLanguageTranslation
                                      .continueWithEmailTransKey,
                                  onTap: controller.onMethodButtonTap)
                              /* <-------- Login with phone number button --------> */
                              : /* CustomStretchedOutlinedTextButtonWidget(
                                  image: Image.asset('assets/images/Phone.png'),
                                  onTap: controller
                                      .onMethodButtonTap /* () {
                                      // Get.toNamed(AppPageNames.emailLogInScreen);
                                    } */
                                  ,
                                  buttonText: AppLanguageTranslation
                                      .continueWithPhoneTransKey), */
                              ColoredOutlinedIconTextButton(
                                  icon: Image.asset('assets/images/Phone.png'),
                                  text: AppLanguageTranslation
                                      .continueWithPhoneTransKey,
                                  onTap: controller.onMethodButtonTap),
                          AppGaps.hGap16,

                          /* <---- Social buttons row ----> */
                          if (Platform.isAndroid)
/*                             Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: controller.onGoogleSignButtonTap,
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.secondaryButtonColor,
                                      minimumSize: const Size(30, 62),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            AppComponents.defaultBorderRadius),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            AppAssetImages.googleSVGLogoLine),
                                        AppGaps.wGap8,
                                        Text(
                                          AppLanguageTranslation
                                              .continueWithGoogleTransKey
                                              .toCurrentLanguage,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ), */
                            ColoredOutlinedIconTextButton(
                              icon: SvgPicture.asset(
                                  AppAssetImages.googleSVGLogoLine),
                              text: AppLanguageTranslation
                                  .continueWithGoogleTransKey.toCurrentLanguage,
                              onTap: controller.onGoogleSignButtonTap,
                            ),
                          const VerticalGap(30),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ));
  }
}
