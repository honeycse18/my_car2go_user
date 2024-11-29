import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.fromSelectedBorderColor),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: AppColors.bodyTextColor,
              size: 24,
            ),
            AppGaps.wGap8,
            Text('Tab to search FAQ',
                style: AppTextStyles.bodyLargeTextStyle
                    .copyWith(color: AppColors.bodyTextColor)),
          ],
        ),
      ),
    );
  }
}
