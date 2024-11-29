import 'package:car2gouser/controller/menu_screen_controller/privacy_policy_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyPolicyScreenController>(
        init: PrivacyPolicyScreenController(),
        builder: (controller) => CustomScaffold(
              /*<------- AppBar ------>*/
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleText: AppLanguageTranslation
                    .privacyPolicyTransKey.toCurrentLanguage,
                hasBackButton: true,
              ),
              /* <--------Body Content --------> */

              body: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: [
                    Expanded(
                      /* <-------- Side padding for scaffold body contents--------> */
                      child: ScaffoldBodyWidget(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /* <-------- Fetch data from API --------> */
                              HtmlWidget(controller.supportTextItem.content),
                              AppGaps.hGap50,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
