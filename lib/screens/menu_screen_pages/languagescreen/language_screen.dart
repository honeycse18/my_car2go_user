import 'package:car2gouser/widgets/screen_widget/language_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car2gouser/controller/language_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  /// Currently selected language
  // LanguageSetting currentLanguage = LanguageSetting.english;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageScreenController>(
        init: LanguageScreenController(),
        builder: (controller) => CustomScaffold(
              backgroundColor: AppColors.backgroundColor,
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleText:
                    AppLanguageTranslation.languageTransKey.toCurrentLanguage,
                hasBackButton: true,
              ),

              /* <--------Body Content --------> */
              body: CustomScaffoldBodyWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap30,
                    Text(
                        AppLanguageTranslation
                            .selectLanguageTransKey.toCurrentLanguage,
                        style: AppTextStyles.semiSmallXBoldTextStyle
                            .copyWith(color: AppColors.primaryColor)),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          /* <---- For extra 16px gap in height ----> */
                          const SliverToBoxAdapter(child: AppGaps.hGap16),
                          /* <---- Language choice list ----> */
                          SliverList.separated(
                            itemBuilder: (context, index) {
                              final language = controller.languages[index];
                              return LanguageListTileWidget(
                                  languageFlagLocalAssetFileName: language.flag,
                                  languageNameText: language.name,
                                  isLanguageSelected:
                                      controller.selectedLanguage.id ==
                                          language.id,
                                  onTap: () =>
                                      controller.onLanguageTap(language));
                            },
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                            itemCount: controller.languages.length,
                          ),
                          // Bottom extra spaces
                          const SliverToBoxAdapter(child: AppGaps.hGap30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
