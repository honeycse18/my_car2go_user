import 'package:car2gouser/controller/setting_pages_controller/setting_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/screen_widget/settings_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsScreenController>(
      init: SettingsScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText: AppLanguageTranslation.settingTransKey,
          hasBackButton: true,
        ),
        body: ScaffoldBodyWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* <---- Setting items ----> */
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap32,
                      /* <---- Change password setting ----> */
                      SettingsListTileWidget(
                        titleText: AppLanguageTranslation
                            .changePasswordTransKey.toCurrentLanguage,
                        onTap: () {
                          Get.toNamed(AppPageNames.changePasswordPromptScreen);
                        },
                        settingsValueTextWidget: const Text(''),
                      ),
                      AppGaps.hGap24,
                      /* <---- Change language setting ----> */
                      SettingsListTileWidget(
                        titleText: AppLanguageTranslation
                            .changeLanguageTransKey.toCurrentLanguage,
                        onTap: () async {
                          await Get.toNamed(AppPageNames.languageScreen);
                          controller.update();
                        },
                        settingsValueTextWidget: Text(
                          controller.currentLanguageText,
                          style:
                              const TextStyle(color: AppColors.bodyTextColor),
                        ),
                      ),
                      AppGaps.hGap24,
                      /* <---- Delete account setting ----> */
                      SettingsListTileWidget(
                        titleText: AppLanguageTranslation
                            .deleteAccountTransKey.toCurrentLanguage,
                        onTap: () {
                          Get.toNamed(AppPageNames.deleteAccount);
                        },
                        settingsValueTextWidget: const Text(''),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
