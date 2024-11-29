import 'package:car2gouser/controller/setting_pages_controller/password_change_success_screen.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordChangSuccessScreen extends StatelessWidget {
  const PasswordChangSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordChangSuccessScreenController>(
      init: PasswordChangSuccessScreenController(),
      builder: (controller) => CustomScaffold(
        /* <-------- Empty appbar with back button --------> */
        appBar: CoreWidgets.appBarWidget(
            screenContext: context, hasBackButton: false),
        /* <--------Body content --------> */
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssetImages.passwordChangeSuccessIllustration,
                    cacheHeight: (240 * 1.5).toInt(),
                    cacheWidth: (260 * 1.5).toInt(),
                    height: 240,
                    width: 260),
                AppGaps.hGap56,
                HighlightAndDetailTextWidget(
                    textColor: Colors.black,
                    subtextColor: const Color(0xff888AA0),
                    isSpaceShorter: true,
                    slogan: AppLanguageTranslation
                        .greatePasswordChangedTransKey.toCurrentLanguage,
                    subtitle: AppLanguageTranslation
                        .problemWithYourAccountTransKey.toCurrentLanguage),
                AppGaps.hGap30,
              ],
            ),
          ),
        ),
        /* <-------- Bottom bar  --------> */
        bottomNavigationBar: CustomScaffoldBottomBarWidget(
          child: CustomStretchedTextButtonWidget(
            buttonText: AppLanguageTranslation.loginTransKey.toCurrentLanguage,
            onTap: () {
              Get.offAllNamed(AppPageNames.loginScreen);
            },
          ),
        ),
      ),
    );
  }
}
