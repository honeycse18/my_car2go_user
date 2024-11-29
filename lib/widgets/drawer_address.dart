import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';

/*<------- Single drawer menu widget ------>*/
class DrawerMenuSvgWidget extends StatelessWidget {
  final String text;
  final String localAssetIconName;
  final Color color;
  final void Function()? onTap;
  const DrawerMenuSvgWidget({
    Key? key,
    required this.text,
    required this.localAssetIconName,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        onTap: onTap,
        borderRadiusRadiusValue: const Radius.circular(14),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButtonWidget(
              fixedSize: const Size(48, 48),
              backgroundColor: AppColors.primaryColor.withOpacity(0.06),
              child: SvgPictureAssetWidget(
                localAssetIconName,
                color: color,
                height: 24,
                width: 24,
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Text(text,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: AppColors.primaryTextColor)),
            ),
          ],
        ));
  }
}

/*<------- Single drawer menu widget ------>*/
class DrawerMenuPngWidget extends StatelessWidget {
  final String text;
  final String localAssetIconName;
  final Color color;
  final void Function()? onTap;
  const DrawerMenuPngWidget({
    Key? key,
    required this.text,
    required this.localAssetIconName,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        onTap: onTap,
        borderRadiusRadiusValue: const Radius.circular(5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButtonWidget(
              fixedSize: const Size(32, 32),
              backgroundColor: color.withOpacity(0.1),
              child: Image.asset(
                localAssetIconName,
                color: color,
                height: 13,
                width: 13,
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Text(text,
                  style: AppTextStyles.bodyMediumTextStyle
                      .copyWith(color: const Color(0xFF3A416F))),
            ),
          ],
        ));
  }
}
