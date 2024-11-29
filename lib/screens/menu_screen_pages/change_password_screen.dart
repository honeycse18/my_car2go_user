import 'package:car2gouser/controller/setting_pages_controller/change_password_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChangePasswordPromptScreen extends StatelessWidget {
  const ChangePasswordPromptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordCreateController>(
        init: ChangePasswordCreateController(),
        global: false,
        builder: (controller) => CustomScaffold(
              /*<------- AppBar ------>*/

              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleText: AppLanguageTranslation
                    .changePasswordTransKey.toCurrentLanguage,
                hasBackButton: true,
              ),

              /* <-------- Body Content --------> */
              body: ScaffoldBodyWidget(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: controller.signUpFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /* <---- Current password field----> */
                                CustomTextFormField(
                                  controller: controller
                                      .currentPasswordEditingController,
                                  isPasswordTextField:
                                      controller.toggleHideOldPassword,
                                  labelText: AppLanguageTranslation
                                      .oldPasswordTransKey.toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.unlockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: () {
                                        controller.toggleHideOldPassword =
                                            !controller.toggleHideOldPassword;
                                        controller.update();
                                      },
                                      icon: SvgPictureAssetWidget(
                                          AppAssetImages.hideSVGLogoLine,
                                          color:
                                              controller.toggleHideOldPassword
                                                  ? AppColors.bodyTextColor
                                                  : AppColors.primaryColor)),
                                ),
                                AppGaps.hGap24,
                                /* <---- Create new password text field ----> */
                                CustomTextFormField(
                                  validator: Helper.passwordFormValidator,
                                  controller:
                                      controller.newPassword1EditingController,
                                  // hasShadow: false,
                                  isPasswordTextField:
                                      controller.toggleHideNewPassword,
                                  labelText: AppLanguageTranslation
                                      .newPasswordTransKey.toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.unlockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: () {
                                        controller.toggleHideNewPassword =
                                            !controller.toggleHideNewPassword;
                                        controller.update();
                                      },
                                      icon: SvgPictureAssetWidget(
                                          AppAssetImages.hideSVGLogoLine,
                                          color:
                                              controller.toggleHideNewPassword
                                                  ? AppColors.bodyTextColor
                                                  : AppColors.primaryColor)),
                                ),
                                AppGaps.hGap24,
                                /* <---- Create confirm password text field ----> */
                                CustomTextFormField(
                                  validator:
                                      controller.confirmPasswordFormValidator,
                                  controller:
                                      controller.newPassword2EditingController,
                                  // hasShadow: false,
                                  isPasswordTextField:
                                      controller.toggleHideConfirmPassword,
                                  labelText: AppLanguageTranslation
                                      .confirmPasswordTransKey
                                      .toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.unlockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: () {
                                        controller.toggleHideConfirmPassword =
                                            !controller
                                                .toggleHideConfirmPassword;
                                        controller.update();
                                      },
                                      icon: SvgPictureAssetWidget(
                                          AppAssetImages.hideSVGLogoLine,
                                          color: controller
                                                  .toggleHideConfirmPassword
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                ),
                                AppGaps.hGap24,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /* <-------- Bottom bar of sign up text --------> */
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                child: CustomStretchedTextButtonWidget(
                    buttonText: AppLanguageTranslation
                        .savePasswordTransKey.toCurrentLanguage,
                    onTap: controller.onSavePasswordButtonTap
                    // controller.onSavePasswordButtonTap
                    ),
              ),
            ));
  }
}
