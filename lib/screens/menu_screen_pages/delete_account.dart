import 'package:car2gouser/controller/menu_screen_controller/delete_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteAccountScreenController>(
      init: DeleteAccountScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /*<------- AppBar ------>*/

        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText:
              AppLanguageTranslation.deleteAccountTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        /*<------- Body Content ------>*/

        body: ScaffoldBodyWidget(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGaps.hGap30,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLanguageTranslation
                          .deleteAccountTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallBoldTextStyle
                          .copyWith(color: Colors.black),
                    ),
                    /* <---- For extra 20px gap in height ----> */
                    AppGaps.hGap20,
                    /* <---- Text for awareness----> */
                    Text(AppLanguageTranslation
                        .areYouWantDeleteAccountTransKey.toCurrentLanguage),
                    AppGaps.hGap20,
                    Text(
                      AppLanguageTranslation.accountTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallBoldTextStyle
                          .copyWith(color: Colors.black),
                    ),
                    AppGaps.hGap20,
                    Text(
                      AppLanguageTranslation
                          .deleteAccountRemoveDataTransKey.toCurrentLanguage,
                    ),
                    AppGaps.hGap30,
                    /* <---- Delete button ----> */
                    CustomStretchedButtonWidget(
                        onTap: () {},
                        // onTap: controller.onContinueButtonTap,
                        child: Text(
                          AppLanguageTranslation
                              .deleteTransKey.toCurrentLanguage,
                        )),
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
