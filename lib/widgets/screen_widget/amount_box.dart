import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class AmountBox extends StatelessWidget {
  final void Function()? onTap;
  final String amount;
  const AmountBox({
    super.key,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      borderRadiusValue: 6,
      onTap: onTap,
      child: Container(
          height: 30,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.fromBorderColor, width: 1),
          ),
          child: Center(
              child: Text(amount,
                  style: AppTextStyles.bodySmallMediumTextStyle
                      .copyWith(color: AppColors.primaryColor)))),
    );
  }
}
