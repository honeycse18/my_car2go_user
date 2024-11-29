import 'package:car2gouser/controller/profile_field_bottomsheet_controller.dart';
import 'package:car2gouser/models/enums/profile_field_name.dart';
import 'package:car2gouser/screens/bottomsheet_screen/base_bottom_sheet.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:car2gouser/widgets/screen_widget/profile_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileFieldBottomSheet extends StatelessWidget {
  const EditProfileFieldBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileFieldBottomsheetController>(
        init: ProfileFieldBottomsheetController(),
        global: false,
        builder: (controller) {
          return BaseBottomSheet(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalGap(12),
              const BottomSheetTopNotch(),
              const VerticalGap(8),
              ProfileFieldWidget(
                appBarTitle: controller.getTitleName,
                subtitle: controller.getSubtitleName,
                child: controller.profileFieldName == ProfileFieldName.phone
                    ? PhoneNumberTextFormFieldWidget(
                        controller: controller.textController,
                        initialCountryCode: controller.currentCountryCode,
                        onCountryCodeChanged: controller.onCountryCodeChanged,
                      )
                    : CustomTextFormField(
                        controller: controller.textController,
                        textInputType: switch (controller.profileFieldName) {
                          ProfileFieldName.email => TextInputType.emailAddress,
                          ProfileFieldName.phone => TextInputType.phone,
                          _ => null,
                        },
                      ),
              ),
              AppGaps.hGap32,
              CustomStretchedButtonWidget(
                isLoading: controller.isLoading,
                onTap: controller.onSubmitButtonTap,
                child: Text(controller.initialText.isEmpty
                    ? AppLanguageTranslation.saveTransKey.toCurrentLanguage
                    : AppLanguageTranslation.updateTransKey.toCurrentLanguage),
              ),
              const VerticalGap(30),
            ],
          ));
        });
  }
}
