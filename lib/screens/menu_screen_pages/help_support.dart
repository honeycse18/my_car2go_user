import 'package:car2gouser/controller/menu_screen_controller/helps_support_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:car2gouser/widgets/screen_widget/settings_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpSupportScreenController>(
      init: HelpSupportScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText:
              AppLanguageTranslation.helpSupportTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        body: ScaffoldBodyWidget(
            child: Column(
          children: [
            AppGaps.hGap30,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* <-------- Content --------> */

                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap16,

                          /* <----privacy policy button ----> */
                          SettingsListTileWidget(
                            titleText: AppLanguageTranslation
                                .privacyPolicyTransKey.toCurrentLanguage,
                            onTap: () {
                              Get.toNamed(AppPageNames.privacyPolicyScreen);
                            },
                            settingsValueTextWidget: const Text(''),
                          ),
                          AppGaps.hGap16,
                          /* <----terms and condition button ----> */
                          SettingsListTileWidget(
                            titleText: AppLanguageTranslation
                                .termsConditionTransKey.toCurrentLanguage,
                            onTap: () {
                              Get.toNamed(
                                AppPageNames.termsConditionScreen,
                              );
                              // await Get.toNamed(AppPageNames.languageScreen);
                              controller.update();
                            },
                            settingsValueTextWidget: const Text(''),
                          ),
                          AppGaps.hGap16,
                          /* <----FAQA button ----> */
                          SettingsListTileWidget(
                            titleText: AppLanguageTranslation
                                .faqaTransKey.toCurrentLanguage,
                            onTap: () {
                              Get.toNamed(AppPageNames.faqaScreen);
                              // await Get.toNamed(AppPageNames.languageScreen);
                              controller.update();
                            },
                            settingsValueTextWidget: const Text(''),
                          ),
                          AppGaps.hGap20,
                          const Text('Contact Customer Service',
                              style: AppTextStyles
                                  .titleSemiSmallSemiboldTextStyle),
                          AppGaps.hGap20,
                          CustomStretchedButtonWidget(
                            onTap: () async {
                              final didOpenSuccessfully =
                                  await Helper.openWhatsapp(
                                      whatsappPhoneNumber:
                                          controller.faqData.whatsapp);
                              if (didOpenSuccessfully == false) {
                                AppDialogs.showErrorDialog(
                                    messageText: 'Failed to open Whatsapp');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/whatsapp.png'),
                                AppGaps.wGap10,
                                Text(AppLanguageTranslation
                                    .contactViaWhatsappTransKey
                                    .toCurrentLanguage)
                              ],
                            ),
                          ),
                          AppGaps.hGap16,
                          CustomStretchedOutlinedButtonWidget(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/Email.png'),
                                AppGaps.wGap10,
                                Text(
                                  AppLanguageTranslation.contactViaEmailTransKey
                                      .toCurrentLanguage,
                                  style: AppTextStyles
                                      .titleSemiSmallSemiboldTextStyle
                                      .copyWith(
                                          color: AppColors.mainButtonBackColor),
                                ),
                              ],
                            ),
                            onTap: () async {
                              final didOpenSuccessfully = await Helper.openMail(
                                  emailAddress: controller.faqData.email);
                              if (didOpenSuccessfully == false) {
                                AppDialogs.showErrorDialog(
                                    messageText: 'Failed to open mail');
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    // SingleChildScrollView(
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       AppGaps.hGap16,
                    //       /* <----contact us button ----> */
                    //       SettingsListTileWidget(
                    //         titleText: AppLanguageTranslation
                    //             .contactUsTransKey.toCurrentLanguage,
                    //         onTap: () {
                    //           Get.toNamed(AppPageNames.contactUsScreen);
                    //         },
                    //         settingsValueTextWidget: const Text(''),
                    //       ),
                    //       AppGaps.hGap16,
                    //       /* <----privacy policy button ----> */
                    //       SettingsListTileWidget(
                    //         titleText: AppLanguageTranslation
                    //             .privacyPolicyTransKey.toCurrentLanguage,
                    //         onTap: () {
                    //           Get.toNamed(AppPageNames.privacyPolicyScreen);
                    //         },
                    //         settingsValueTextWidget: const Text(''),
                    //       ),
                    //       AppGaps.hGap16,
                    //       /* <----terms and condition button ----> */
                    //       SettingsListTileWidget(
                    //         titleText: AppLanguageTranslation
                    //             .termsConditionTransKey.toCurrentLanguage,
                    //         onTap: () {
                    //           Get.toNamed(
                    //             AppPageNames.termsConditionScreen,
                    //           );
                    //           // await Get.toNamed(AppPageNames.languageScreen);
                    //           controller.update();
                    //         },
                    //         settingsValueTextWidget: const Text(''),
                    //       ),
                    //       AppGaps.hGap30,

                    //       /* <----FAQA button ----> */
                    //       CustomStretchedOutlinedButtonWidget(
                    //         child: Text(
                    //           AppLanguageTranslation
                    //               .faqaTransKey.toCurrentLanguage,
                    //           style: const TextStyle(
                    //               color: AppColors.primaryColor),
                    //         ),
                    //         onTap: () {
                    //           Get.toNamed(AppPageNames.faqaScreen);
                    //         },
                    //       )
                    //     ],
                    //   ),
                    // ),
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
