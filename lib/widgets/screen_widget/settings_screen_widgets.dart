import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/* <---- Setting list tile from settings screen ----> */

class SettingsListTileWidget extends StatelessWidget {
  final Widget settingsValueTextWidget;
  final String titleText;
  final Widget? valueWidget;
  final void Function()? onTap;
  final bool showRightArrow;
  const SettingsListTileWidget({
    Key? key,
    required this.titleText,
    this.valueWidget,
    this.onTap,
    this.showRightArrow = true,
    required this.settingsValueTextWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSettingsListTileWidget(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleText,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle,
                  ),
                  settingsValueTextWidget,
                  const SvgPictureAssetWidget(
                    AppAssetImages.rightArrowSVGLogoLine,
                    color: AppColors.bodyTextColor,
                    height: 15,
                    width: 15,
                  ),
                ],
              )),
              valueWidget ?? AppGaps.emptyGap,
              showRightArrow ? AppGaps.wGap8 : AppGaps.emptyGap,
            ],
          ),
        ));
  }
}

class SettingsValueTextWidget extends StatelessWidget {
  final String text;
  const SettingsValueTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: AppColors.bodyTextColor.withOpacity(0.5)),
    );
  }
}
