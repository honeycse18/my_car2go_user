import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/*<------- Tab list for TabBar widget ------>*/
class TabStatusWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onTap;

  const TabStatusWidget(
      {super.key, required this.text, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RawButtonWidget(
        onTap: onTap,
        borderRadiusValue: 8,
        backgroundColor:
            isSelected ? AppColors.primaryColor : AppColors.myRideTabColor,
        child: Container(
          height: 52,
          width: 117,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(text,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: isSelected
                  ? AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: Colors.white)
                  : AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: AppColors.primaryTextColor)),
        ),
      ),
    );
  }
}
