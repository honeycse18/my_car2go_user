import 'package:car2gouser/screens/bottomsheet_screen/base_bottom_sheet.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmBottomSheet extends StatelessWidget {
  final String title;
  final String yesButtonText;
  final String noButtonText;
  final void Function()? noButtonTap;
  final void Function()? yesButtonTap;
  const ConfirmBottomSheet(
      {super.key,
      required this.title,
      required this.yesButtonText,
      required this.yesButtonTap,
      required this.noButtonTap,
      required this.noButtonText});

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
        child: Column(
      children: [
        const VerticalGap(19),
        Text(
          title,
          style: AppTextStyles.titleSemiboldTextStyle
              .copyWith(color: AppColors.primaryTextColor),
        ),
        AppGaps.hGap32,
        CustomStretchedTextButtonWidget(
            onTap: yesButtonTap,
            buttonText: yesButtonText,
            backgroundColor: AppColors.errorColor),
        AppGaps.hGap16,
        RawButtonWidget(
          onTap: noButtonTap,
          child: Container(
            height: 56,
            width: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: AppColors.mainButtonBackColor, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              noButtonText,
              style: AppTextStyles.bodyLargeSemiboldTextStyle
                  .copyWith(color: AppColors.buttonLightStandardColor),
            ),
          ),
        ),
        const VerticalGap(30),
      ],
    ));
  }
}
