import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileFieldWidget extends StatelessWidget {
  final String appBarTitle;
  final String subtitle;
  final Widget child;

  const ProfileFieldWidget(
      {required this.appBarTitle,
      required this.subtitle,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            appBarTitle,
            style: AppTextStyles.titlesemiSmallMediumTextStyle
                .copyWith(color: AppColors.primaryColor),
          ),
        ),
        AppGaps.hGap4,
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            subtitle,
            style: AppTextStyles.bodyTextStyle
                .copyWith(color: AppColors.bodyTextColor),
          ),
        ),
        AppGaps.hGap16,
        child,
      ],
    );
  }
}
