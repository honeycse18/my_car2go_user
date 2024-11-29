import 'package:car2gouser/controller/create_new_password_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewPasswordScreenController>(
        init: CreateNewPasswordScreenController(),
        builder: (controller) => CustomScaffold(
              /* <---- AppBar ----> */
              appBar: CoreWidgets.appBarWidget(
                  titleText: '', screenContext: context, hasBackButton: true),
              /* <---- Body content----> */
              body: ScaffoldBodyWidget(
                  /* <---- Form for creating new password ----> */
                  child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.changePassFormKey,
                child: Column(
                  children: [
                    AppGaps.hGap24,
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* <---- for extra 32px gap in height ----> */
                          AppGaps.hGap32,
                          Text(
                            AppLanguageTranslation
                                .createNewPasswordTransKey.toCurrentLanguage,
                            style: AppTextStyles.titleBoldTextStyle
                                .copyWith(color: AppColors.primaryTextColor),
                          ),
                          AppGaps.hGap8,
                          Text(
                            AppLanguageTranslation
                                .youCanLoginTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                          /* <---- for extra 32px gap in height ----> */
                          AppGaps.hGap32,
                          /*<-------Text field for password ------>*/
                          Obx(() => CustomTextFormField(
                                validator: controller.passwordFormValidator,
                                controller:
                                    controller.passwordTextEditingController,
                                isPasswordTextField:
                                    controller.toggleHidePassword.value,
                                labelText: AppLanguageTranslation
                                    .passwordTransKey.toCurrentLanguage,
                                hintText: '********',
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.unlockSVGLogoLine),
                                suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    color: Colors.transparent,
                                    onPressed:
                                        controller.onPasswordSuffixEyeButtonTap,
                                    icon: SvgPictureAssetWidget(
                                        AppAssetImages.hideSVGLogoLine,
                                        color:
                                            controller.toggleHidePassword.value
                                                ? AppColors.bodyTextColor
                                                : AppColors.primaryColor)),
                              )),
                          AppGaps.hGap24,
                          /*<-------Text field for confirm password ------>*/
                          Obx(() => CustomTextFormField(
                                validator: controller.passwordFormValidator,
                                controller: controller
                                    .confirmPasswordTextEditingController,
                                isPasswordTextField:
                                    controller.toggleHideConfirmPassword.value,
                                labelText: AppLanguageTranslation
                                    .confirmPasswordTransKey.toCurrentLanguage,
                                hintText: '********',
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.unlockSVGLogoLine),
                                suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    color: Colors.transparent,
                                    onPressed: controller
                                        .onConfirmPasswordSuffixEyeButtonTap,
                                    icon: SvgPictureAssetWidget(
                                        AppAssetImages.hideSVGLogoLine,
                                        color: controller
                                                .toggleHideConfirmPassword.value
                                            ? AppColors.bodyTextColor
                                            : AppColors.primaryColor)),
                              )),
                          /* <---- for extra 32px gap in height ----> */
                          AppGaps.hGap32,
                        ],
                      ),
                    ))
                  ],
                ),
              )),
              /*<------- Bottom Bar ------>*/
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: 30 + context.mediaQueryViewInsets.bottom,
                    right: 24,
                    left: 24),
                child: CustomStretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation
                      .savePasswordTransKey.toCurrentLanguage,
                  onTap: controller.onSavePasswordButtonTap,
                ),
              ),
            ));
  }
}
