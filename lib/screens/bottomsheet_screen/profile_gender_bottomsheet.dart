import 'package:car2gouser/controller/profile_gender_bottomsheet_controller.dart';
import 'package:car2gouser/models/enums/gender.dart';
import 'package:car2gouser/screens/bottomsheet_screen/base_bottom_sheet.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:car2gouser/widgets/screen_widget/profile_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileGenderBottomsheet extends StatelessWidget {
  const EditProfileGenderBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileGenderBottomsheetController>(
        init: ProfileGenderBottomsheetController(),
        builder: (controller) {
          return BaseBottomSheet(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VerticalGap(12),
                SizedBox(
                  width: 53,
                  height: 3,
                  child: Container(
                    decoration: const ShapeDecoration(
                        shape: StadiumBorder(), color: AppColors.bodyTextColor),
                  ),
                ),
                const VerticalGap(8),
                ProfileFieldWidget(
                  appBarTitle: 'Edit Gender',
                  subtitle:
                      'This helps personalize your experience on the app and can be updated at any time.',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Male Radio Button
                      Expanded(
                        child: RawButtonWidget(
                          onTap: () => controller.selectedGender = Gender.male,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.selectedGender == Gender.male
                                    ? AppColors.fromSelectedBorderColor
                                    : AppColors.fromBorderColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  controller.selectedGender == Gender.male
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color:
                                      controller.selectedGender == Gender.male
                                          ? AppColors.primaryColor
                                          : AppColors.bodyTextColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                    Gender.male.viewableTextTransKey
                                        .toCurrentLanguage,
                                    style: AppTextStyles.bodyLargeTextStyle
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Female Radio Button
                      Expanded(
                        child: RawButtonWidget(
                          onTap: () =>
                              controller.selectedGender = Gender.female,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    controller.selectedGender == Gender.female
                                        ? AppColors.fromSelectedBorderColor
                                        : AppColors.fromBorderColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  controller.selectedGender == Gender.female
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color:
                                      controller.selectedGender == Gender.female
                                          ? AppColors.primaryColor
                                          : AppColors.bodyTextColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                    Gender.female.viewableTextTransKey
                                        .toCurrentLanguage,
                                    style: AppTextStyles.bodyLargeTextStyle
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const HorizontalGap(10),
                      // Other Radio Button
                      Expanded(
                        child: RawButtonWidget(
                          onTap: () => controller.selectedGender = Gender.other,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.selectedGender == Gender.other
                                    ? AppColors.fromSelectedBorderColor
                                    : AppColors.fromBorderColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  controller.selectedGender == Gender.other
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color:
                                      controller.selectedGender == Gender.other
                                          ? AppColors.primaryColor
                                          : AppColors.bodyTextColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                    Gender.other.viewableTextTransKey
                                        .toCurrentLanguage,
                                    style: AppTextStyles.bodyLargeTextStyle
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppGaps.hGap32,
                CustomStretchedButtonWidget(
                  isLoading: controller.isLoading,
                  onTap: controller.onContinueButtonTap,
                  child: Text(
                      AppLanguageTranslation.saveTransKey.toCurrentLanguage),
                ),
                AppGaps.hGap32,
              ],
            ),
          );
        });
  }
}
