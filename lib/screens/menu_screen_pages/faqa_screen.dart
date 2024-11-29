import 'package:car2gouser/controller/menu_screen_controller/faqa_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:car2gouser/widgets/screen_widget/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqaScreen extends StatelessWidget {
  const FaqaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqaScreenController>(
        init: FaqaScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
            /*<------- AppBar ------>*/

            appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleText:
                  AppLanguageTranslation.helpSupportTransKey.toCurrentLanguage,
              hasBackButton: true,
            ),
            /*<------- Body Content ------>*/

            body: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Column(
                children: [
                  Expanded(
                    child: ScaffoldBodyWidget(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          MySearchBar(onTap: () {}),
                          AppGaps.hGap24,
                          Text(
                            AppLanguageTranslation
                                .faqaTransKey.toCurrentLanguage,
                            style: AppTextStyles.titleSemiSmallBoldTextStyle
                                .copyWith(color: Colors.black),
                          ),
                          AppGaps.hGap16,
                          /* <----FAQA Item----> */
                          Expanded(
                              child: CustomScrollView(
                            slivers: [
                              const SliverToBoxAdapter(child: AppGaps.hGap5),
                              // PagedSliverList.separated(
                              //     pagingController:
                              //         controller.faqPagingController,
                              //     builderDelegate:
                              //         PagedChildBuilderDelegate<FaqItems>(
                              //             itemBuilder: (context, item, index) {
                              //       final FaqItems faqItem = item;

                              //       return ExpansionTileWidget(
                              //         titleWidget: Text(faqItem.question),
                              //         children: [
                              //           Container(
                              //               padding: const EdgeInsets.symmetric(
                              //                   horizontal: 16, vertical: 8),
                              //               child: Text(faqItem.answer))
                              //         ],
                              //       );
                              //     }),
                              //     separatorBuilder: (context, index) =>
                              //         AppGaps.hGap16),
                              SliverList.separated(
                                itemBuilder: (context, index) {
                                  final faqItem = controller.faqs[index];

                                  return ExpansionTileWidget(
                                    titleWidget: Text(faqItem.title),
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text(faqItem.description))
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                                itemCount: controller.faqs.length,
                              ),
                              const SliverToBoxAdapter(child: AppGaps.hGap36),
                              SliverToBoxAdapter(
                                /* <----Whatsapp button ----> */
                                child: CustomStretchedButtonWidget(
                                  onTap: () async {
                                    final didOpenSuccessfully =
                                        await Helper.openWhatsapp(
                                            whatsappPhoneNumber:
                                                controller.faqData.whatsapp);
                                    if (didOpenSuccessfully == false) {
                                      AppDialogs.showErrorDialog(
                                          messageText:
                                              'Failed to open Whatsapp');
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
                              ),
                              const SliverToBoxAdapter(child: AppGaps.hGap16),
                              SliverToBoxAdapter(
                                  /* <----Email button ----> */
                                  child: CustomStretchedOutlinedButtonWidget(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/Email.png'),
                                          AppGaps.wGap10,
                                          Text(
                                            AppLanguageTranslation
                                                .contactViaEmailTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .titleSemiSmallBoldTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          ),
                                        ],
                                      ),
                                      onTap: () async {
                                        final didOpenSuccessfully =
                                            await Helper.openMail(
                                                emailAddress:
                                                    controller.faqData.email);
                                        if (didOpenSuccessfully == false) {
                                          AppDialogs.showErrorDialog(
                                              messageText:
                                                  'Failed to open mail');
                                        }
                                      })),
                            ],
                          ))
                        ])),
                  ),
                ],
              ),
            )));
  }
}
