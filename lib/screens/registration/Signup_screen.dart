import 'package:car2gouser/controller/registration_screen_controller.dart';
import 'package:car2gouser/models/enums/gender.dart';
import 'package:car2gouser/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<RegistrationScreenController>(
        global: false,
        init: RegistrationScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.registerTransKey.toCurrentLanguage,
                  hasBackButton: true),
              /* <-------- Body Content --------> */
              body: ScaffoldBodyWidget(
                  child: Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: controller.signUpFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap26,
                      /* <-------- SignUp Form --------> */
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .gettingStartedTransKey.toCurrentLanguage,
                                style: AppTextStyles.titleBoldTextStyle,
                              ),
                              AppGaps.hGap8,
                              Text(
                                AppLanguageTranslation
                                    .setUpYourProfileTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyLargeTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                              AppGaps.hGap32,
                              /*<-------Text field for full name ------>*/
                              CustomTextFormField(
                                  validator: Helper.textFormValidator,
                                  controller:
                                      controller.nameTextEditingController,
                                  labelText: AppLanguageTranslation
                                      .fullNameTransKey.toCurrentLanguage,
                                  hintText: 'E.g jhon doe',
                                  prefixIcon: const SvgPictureAssetWidget(
                                      AppAssetImages.profileSVGLogoLine)),
                              AppGaps.hGap16,
                              /*<-------Text field for email ------>*/
                              if (controller.isEmail)
                                CustomTextFormField(
                                    validator: Helper.emailFormValidator,
                                    controller:
                                        controller.emailTextEditingController,
                                    isReadOnly:
                                        controller.screenParameter!.isEmail,
                                    labelText: AppLanguageTranslation
                                        .emailAddressTransKey.toCurrentLanguage,
                                    hintText: 'E.g abc@example.com',
                                    suffixIcon:
                                        controller.screenParameter!.isEmail
                                            ? RawButtonWidget(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppPageNames.loginScreen,
                                                      arguments:
                                                          SignUpScreenParameter(
                                                        isEmail: true,
                                                        theValue: controller
                                                            .emailTextEditingController
                                                            .text,
                                                      ));
                                                },
                                                child: Text(
                                                  'Edit',
                                                  maxLines: 1,
                                                  style: AppTextStyles
                                                      .bodySmallTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor),
                                                ),
                                              )
                                            : AppGaps.emptyGap,
                                    prefixIcon: const SvgPictureAssetWidget(
                                        AppAssetImages.emailSVGLogoLine)),
                              AppGaps.hGap16,
                              /*<-------Text field for phone number ------>*/
                              if (controller.isEmail == false)
                                PhoneNumberTextFormFieldWidget(
                                  validator: Helper.phoneFormValidator,
                                  initialCountryCode:
                                      controller.currentCountryCode,
                                  controller:
                                      controller.phoneTextEditingController,
                                  isReadOnly:
                                      !controller.screenParameter!.isEmail,
                                  labelText: AppLanguageTranslation
                                      .phoneNumberTransKey.toCurrentLanguage,
                                  hintText: '197464646',
                                  suffixIcon: !controller
                                          .screenParameter!.isEmail
                                      ? RawButtonWidget(
                                          onTap: () {
                                            Get.toNamed(
                                                AppPageNames.loginScreen,
                                                arguments: SignUpScreenParameter(
                                                    isEmail: false,
                                                    theValue: controller
                                                        .phoneTextEditingController
                                                        .text,
                                                    countryCode: controller
                                                        .currentCountryCode));
                                          },
                                          child: Text(
                                            'Edit',
                                            maxLines: 1,
                                            style: AppTextStyles
                                                .bodySmallTextStyle
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor),
                                          ),
                                        )
                                      : AppGaps.emptyGap,
                                  onCountryCodeChanged:
                                      controller.onCountryChange,
                                ),
                              /* <---- for extra 16px gap in height ----> */
                              AppGaps.hGap16,
/*                               DropdownButtonFormFieldWidget<String>(
                                value: controller.selectedGender,
                                hintText: 'Select Gender',
                                labelText: 'Gender',
                                items: controller.genderOptions,
                                getItemText: (gender) => gender,
                                onChanged: controller.onGenderChange,
                              ), */
                              DropdownButtonFormFieldWidget<Gender>(
                                value: controller.selectedGender,
                                hintText: 'Select Gender',
                                labelText: 'Gender',
                                validator: (value) {
                                  if (value == null) {
                                    return 'Gender is required';
                                  }
                                  return null;
                                },
                                // items: controller.genderOptions,
                                items: Gender.list,
                                getItemText: (gender) => gender
                                    .viewableTextTransKey.toCurrentLanguage,
                                onChanged: controller.onGenderChange,
                              ),
                              /* <---- for extra 16px gap in height ----> */
                              AppGaps.hGap16,
                              CustomTextFormField(
                                validator: controller.addressFormValidator,
                                controller: controller.addressController,
                                labelText: AppLanguageTranslation
                                    .addressTransKey.toCurrentLanguage,
                                hintText: '27, Elephant road',
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.pickLocationSVGLogoLine),
                              ),
                              const VerticalGap(16),
                              /*<-------Text field for password ------>*/
                              Obx(() => PasswordFormFieldWidget(
                                  passwordValidator:
                                      controller.passwordFormValidator,
                                  controller:
                                      controller.passwordTextEditingController,
                                  hidePassword:
                                      controller.toggleHidePassword.value,
                                  onPasswordVisibilityToggleButtonTap:
                                      controller.onPasswordSuffixEyeButtonTap,
                                  label: AppLanguageTranslation
                                      .passwordTransKey.toCurrentLanguage,
                                  showValidatorRules: true)),
                              AppGaps.hGap16,
                              /*<-------Text field for confirm password ------>*/
                              Obx(() => CustomTextFormField(
                                    validator:
                                        controller.confirmPasswordFormValidator,
                                    controller: controller
                                        .confirmPasswordTextEditingController,
                                    isPasswordTextField: controller
                                        .toggleHideConfirmPassword.value,
                                    labelText: AppLanguageTranslation
                                        .confirmPasswordTransKey
                                        .toCurrentLanguage,
                                    hintText: '********',
                                    prefixIcon: const SvgPictureAssetWidget(
                                        AppAssetImages.unlockSVGLogoLine),
                                    suffixIcon: IconButton(
                                        padding: EdgeInsets.zero,
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        color: Colors.transparent,
                                        onPressed: controller
                                            .onConfirmPasswordSuffixEyeButtonTap,
                                        icon: SvgPictureAssetWidget(
                                            controller.toggleHideConfirmPassword
                                                    .value
                                                ? AppAssetImages.hideSVGLogoLine
                                                : AppAssetImages
                                                    .showSVGLogoLine,
                                            color: controller
                                                    .toggleHideConfirmPassword
                                                    .value
                                                ? AppColors.bodyTextColor
                                                : AppColors.primaryColor)),
                                  )),
                              AppGaps.hGap15,
                              /*<------- checkbox for terms and conditions ------>*/
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: screenSize.width < 458
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Obx(() => Checkbox(
                                        value: controller
                                            .toggleAgreeTermsConditions.value,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        onChanged: controller
                                            .onToggleAgreeTermsConditions)),
                                  ),
                                  AppGaps.wGap16,
                                  /*<------- By creating an account, you agree to our terms and conditions ------>*/
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => controller
                                          .onToggleAgreeTermsConditions(
                                              !controller
                                                  .toggleAgreeTermsConditions
                                                  .value),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .createingAccountYouAgreeTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .bodySmallTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          ),
                                          CustomTightTextButtonWidget(
                                              onTap: () {},
                                              child: Text(
                                                AppLanguageTranslation
                                                    .termsConditionTransKey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .bodySmallMediumTextStyle
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: AppColors
                                                            .primaryColor),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              /* <---- for extra 32px gap in height ----> */
                              AppGaps.hGap32,
                              /*<------- Continue button ------>*/
                              CustomStretchedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .continueTransKey.toCurrentLanguage,
                                onTap:
                                    controller.toggleAgreeTermsConditions.value
                                        ? controller.onContinueButtonTap
                                        : null,
                              ),
                              AppGaps.hGap32,
                            ],
                          ),
                        ),
                      ),
                    ]),
              )),
            ));
  }
}
