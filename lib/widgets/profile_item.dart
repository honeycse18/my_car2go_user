import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const ProfileItem(
      {super.key, required this.title, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppTextStyles.bodySmallTextStyle.copyWith(
                        color: AppColors.bodyTextColor,
                      )),
                  const VerticalGap(5),
                  Text(value,
                      style: AppTextStyles.bodyLargeMediumTextStyle.copyWith(
                        color: AppColors.primaryTextColor,
                      )),
                ],
              ),
            ),
            const HorizontalGap(5),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: AppColors.bodyTextColor),
          ],
        ));
  }
}
